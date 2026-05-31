package kr.or.navi.alarm.service;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicLong;

import javax.inject.Inject;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.navi.alarm.dao.AlramBoardMapper;
import kr.or.navi.alarm.dao.AlramTypeDAO;
import kr.or.navi.board.prais.dao.PraisDAO;
import kr.or.navi.chat.web.dao.ChatDAO;
import kr.or.navi.common.dao.CommonDAO;
import kr.or.navi.mapper.dao.EmpDAO;
import kr.or.navi.mypagedetail.alarm.dao.AlramDAO;
import kr.or.navi.project.dao.IssueDAO;
import kr.or.navi.project.dao.ProjectDAO;
import kr.or.navi.project.dao.TeamDAO;
import kr.or.navi.security.RealUser;
import kr.or.navi.task.dao.TaskDAO;
import kr.or.navi.vo.AlarmTypeVO;
import kr.or.navi.vo.AlarmVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.ChatUserVO;
import kr.or.navi.vo.CommonVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.IssueVO;
import kr.or.navi.vo.ProjectVO;
import kr.or.navi.vo.TaskVO;
import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class SseEmitters {
	private static final AtomicLong counter = new AtomicLong();

	@Inject
	private AlramTypeDAO atDao;
	@Inject
	private AlramDAO dao;
	@Inject
	private TeamDAO teamDao;
	@Inject
	private IssueDAO issueDao;
	@Inject
	private ProjectDAO projectDao;

	/**
	 * 사용자 정보와 sse객체를 담기위한 map ConcurrentHashMap를 이용하여 쓰레드의 접근을 제어
	 */
	private final Map<EmpVO, SseEmitter> emitters = new ConcurrentHashMap<EmpVO, SseEmitter>();

	/**
	 * @param empVO   session에 등록되어 있는 principal 객체
	 * @param emitter sse객체
	 * @return
	 */
	public SseEmitter add(EmpVO empVO, SseEmitter emitter) {
		log.info("emitter : {}", emitter);
		// 객체 추가
		this.emitters.put(empVO, emitter);
		log.info("new emitter added: {}", emitter);
		log.info("emitter list size: {}", emitters.size());
		// emitter를 통해 데이터를 전송하였고 완료처리 되었을때 수행하는 이벤트 핸들러
		emitter.onCompletion(() -> {
			log.info("onCompletion callback");
			this.emitters.remove(empVO); // 완료되면 리스트에서 삭제
		});
		// SseEmitter의 생성자를 통해 timeout을 설정할 수 있으며 지정한 시간이 지나면
		// connection을 종료하게 되는데 종료 이후 발생하는 이벤트 핸들러
		emitter.onTimeout(() -> {
			log.info("onTimeout callback");
			this.emitters.remove(empVO); // 타임아웃되면 리스트에서 삭제
			emitter.complete();
		});
		// SseEmitter 객체를 통해 에러가 발생했을 경우 발생되는 핸들러
		emitter.onError(e -> {
			log.error("onError callback", e);
			this.emitters.remove(empVO); // 에러 발생 시 리스트에서 삭제
			emitter.complete();
		});

		return emitter;
	}

	public void count() {
		ObjectMapper objectMapper = new ObjectMapper();

		long count = counter.incrementAndGet();
		String alram = "알람왔음";
		emitters.forEach((empVO, emitter) -> {
			Map<String, String> map = new HashMap<String, String>();
			map.put("msg", "새로운 글이 등록되었습니다.");
			map.put("sendId", "길상");
			map.put("receiveId", "민규");
			String jsonData = null;
			try {
				jsonData = objectMapper.writeValueAsString(map);
			} catch (JsonProcessingException e) {
				throw new RuntimeException(e);
			}
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			try {
				emitter.send(SseEmitter.event().name("count").data(jsonData));
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		});
	}

	/**
	 * 이슈 등록 시 실행될 메서드
	 * 
	 * @param realUser
	 * @param issueId
	 */
	public void issueReg(EmpVO realUser, String issueId) {
		// 해당 이슈 조회
		IssueVO selectIssue = issueDao.selectIssue(issueId);
		String proId = selectIssue.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		// 발생시킬 알림 vo조회
		AlarmTypeVO atVO = atDao.selectAlramType("A00003");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/issue/detail/" + proId + "/" + issueId);
		alarmVO.setAltypeId("A00003");
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectIssue.getIssueRegId().equals(empVO.getEmpId())) { // 이슈 등
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		});

		alarmVO.setAlRcvrId(selectPlId);
		dao.insertAlram(alarmVO);
		if (!selectPlId.equals(selectIssue.getIssueRegId())) {
			alarmVO.setAlRcvrId(selectIssue.getIssueRegId());
			dao.insertAlram(alarmVO);
		}

	}

//	"<li><a class='alram-item' data-id='A00014' href='/navi/board/photo/B00182'>"[포토공간]새로운 글이 등록되었습니다."<i class='icon new_icon'></i> </a></li>"
	public void issueMod(EmpVO realUser, String issueId) {
		IssueVO selectIssue = issueDao.selectIssue(issueId);
		String proId = selectIssue.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00004");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/issue/detail/" + proId + "/" + issueId);
		alarmVO.setAltypeId("A00004");
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectIssue.getIssueRegId().equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		});

		alarmVO.setAlRcvrId(selectPlId);
		dao.insertAlram(alarmVO);
		if (!selectPlId.equals(selectIssue.getIssueRegId())) {
			alarmVO.setAlRcvrId(selectIssue.getIssueRegId());
			dao.insertAlram(alarmVO);
		}
	}

	public void issueDel(EmpVO realUser, String issueId) {
		IssueVO selectIssue = issueDao.selectIssue(issueId);
		String proId = selectIssue.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00005");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/issue/detail/" + proId + "/" + issueId);
		alarmVO.setAltypeId("A00005");
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectIssue.getIssueRegId().equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][이슈 ID : " + selectIssue.getIssueTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		});

		alarmVO.setAlRcvrId(selectPlId);
		dao.insertAlram(alarmVO);
		if (!selectPlId.equals(selectIssue.getIssueRegId())) {
			alarmVO.setAlRcvrId(selectIssue.getIssueRegId());
			dao.insertAlram(alarmVO);
		}
	}

	@Inject
	private TaskDAO taskDao;

	/**
	 * 일감 등록시 실행될 메서드
	 * 
	 * @param realUser 일감 등록한 사용자
	 * @param taskId   일감id
	 */
	public void taskReg(EmpVO realUser, String taskId) {
		TaskVO task = taskDao.select(taskId); // 일감 조회
		String proId = task.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00006"); // 알람타입 vo 조회
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAltypeId("A00006");
		alarmVO.setAlRcvrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/task/" + proId + "/" + taskId);
		String cn = "새로운 일감이 등록되었습니다.";
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) { // 일감 등록자일 경우 제외
				return;
			}
			if (task.getTaskManId().equals(empVO.getEmpId())) { // 해당 일감의 담당자일 경우 알림 발생
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));

				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectPlId.equals(empVO.getEmpId())) { // 해당 일감이 속해 있는 프로젝트 관리자에게 알림 발생
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}

		});
		alarmVO.setAlSndrId(task.getTaskManId());
		dao.insertAlram(alarmVO); // 알림 정보를 데이터베이스에 저장
		alarmVO.setAlCn(
				"[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]" + atVO.getAltypeCn());
		// pl
		if (!task.getTaskManId().equals(selectPlId)) { // 알림 정보를 담당자에겐 다르게 저장
			alarmVO.setAlSndrId(selectPlId);
			alarmVO.setAlCn(cn);
			dao.insertAlram(alarmVO);
		}
	}

	public void taskMod(EmpVO realUser, String taskId) {
		TaskVO task = taskDao.select(taskId);
		String proId = task.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00014");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAltypeId("A00014");
		alarmVO.setAlRcvrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/task/" + proId + "/" + taskId);

		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (task.getTaskManId().equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));

				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}

		});
		alarmVO.setAlSndrId(task.getTaskManId());
		dao.insertAlram(alarmVO);
		if (!task.getTaskManId().equals(selectPlId)) {
			alarmVO.setAlSndrId(selectPlId);
			dao.insertAlram(alarmVO);
		}

	}

	public void taskDel(EmpVO realUser, String taskId) {
		TaskVO task = taskDao.select(taskId);
		String proId = task.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00015");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAltypeId("A00015");
		alarmVO.setAlRcvrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/task/" + proId + "/" + taskId);
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (task.getTaskManId().equals(empVO.getEmpId())) {

				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));

				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		});
		alarmVO.setAlSndrId(task.getTaskManId());
		dao.insertAlram(alarmVO);
		if (!task.getTaskManId().equals(selectPlId)) {
			alarmVO.setAlSndrId(selectPlId);
			dao.insertAlram(alarmVO);
		}
	}

	public void taskComp(EmpVO realUser, String taskId) {
		TaskVO task = taskDao.select(taskId);
		String proId = task.getProId();
		ProjectVO project = projectDao.selectProject(proId);
		String selectPlId = teamDao.selectPlId(proId);
		AlarmTypeVO atVO = atDao.selectAlramType("A00007");
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAltypeId("A00007");
		alarmVO.setAlRcvrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/project/task/" + proId + "/" + taskId);

		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			if (task.getTaskManId().equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));

				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
			if (selectPlId.equals(empVO.getEmpId())) {
				alarmVO.setAlCn("[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
						+ atVO.getAltypeCn());
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[프로젝트 : " + project.getProName() + "][일감 명 : " + task.getTaskTitle() + "]"
							+ atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}
		});
		alarmVO.setAlSndrId(task.getTaskManId());
		dao.insertAlram(alarmVO);
		if (!task.getTaskManId().equals(selectPlId)) {
			alarmVO.setAlSndrId(selectPlId);
			dao.insertAlram(alarmVO);
		}
	}

	@Inject
	private PraisDAO prDao;
	@Inject
	private EmpDAO empDao;
	@Inject
	private CommonDAO cmDao;
	@Inject
	private AlramBoardMapper boardMapper;

	public void boardReg(EmpVO realUser, String bpId, String atId) {
		BoardPostVO selectPrais = boardMapper.selectBaordPost(bpId);
		List<EmpVO> empList = empDao.selectList();
		AlarmTypeVO atVO = atDao.selectAlramType(atId);
		CommonVO brdVO = cmDao.selectOne(selectPrais.getBrdId());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/board/" + brdVO.getCmAtt1() + "/" + bpId);
		alarmVO.setAltypeId(atId);
		alarmVO.setAlCn("[" + brdVO.getCmName() + "]" + atVO.getAltypeCn());
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			try {
				String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
						+ alarmVO.getAlMoveUrl() + "'>";
				data += "[" + brdVO.getCmName() + "]" + atVO.getAltypeCn();
				data += "<i class='icon new_icon'></i> </a></li>";
				emitter.send(SseEmitter.event().name("count").data(data));
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		});
		empList.forEach(emp -> {
			alarmVO.setAlRcvrId(emp.getEmpId());
			dao.insertAlram(alarmVO);
		});
	}

	public void boardDel(EmpVO realUser, String bpId) {
		BoardPostVO selectPrais = boardMapper.selectBaordPost(bpId);
		List<EmpVO> empList = empDao.selectList();
		AlarmTypeVO atVO = atDao.selectAlramType("A00010");
		CommonVO brdVO = cmDao.selectOne(selectPrais.getBrdId());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/board/" + brdVO.getCmAtt1() + "/" + bpId);
		alarmVO.setAltypeId("A00010");
		alarmVO.setAlCn("[" + brdVO.getCmName() + "]" + atVO.getAltypeCn());
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (empVO.equals(realUser)) {
				return;
			}
			try {
				String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
						+ alarmVO.getAlMoveUrl() + "'>";
				data += "[" + brdVO.getCmName() + "]" + atVO.getAltypeCn();
				data += "<i class='icon new_icon'></i> </a></li>";
				emitter.send(SseEmitter.event().name("count").data(data));
			} catch (IOException e) {
				throw new RuntimeException(e);
			}
		});
		empList.forEach(emp -> {
			alarmVO.setAlRcvrId(emp.getEmpId());
			dao.insertAlram(alarmVO);
		});
	}

	public void qnaReg(EmpVO realUser, String bpId) {
		BoardPostVO selectPrais = boardMapper.selectBaordPost(bpId);
		EmpVO admin = boardMapper.selectAdmin();
		List<EmpVO> empList = empDao.selectList();
		AlarmTypeVO atVO = atDao.selectAlramType("A00017");
		CommonVO brdVO = cmDao.selectOne(selectPrais.getBrdId());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAltypeId("A00017");
		alarmVO.setAlCn("[" + brdVO.getCmName() + "]" + atVO.getAltypeCn());
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (admin.getEmpId().equals(empVO.getEmpId())) {
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ "/admin/qna/answer/" + bpId + "'>";
					data += "[" + brdVO.getCmName() + "]" + atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}

		});
		alarmVO.setAlMoveUrl("/board/" + brdVO.getCmAtt1() + "/" + bpId);
		alarmVO.setAlRcvrId(selectPrais.getEmpId());
		dao.insertAlram(alarmVO);
//		/admin/qna/answer/B00206
		alarmVO.setAlMoveUrl("/admin/qna/answer/" + bpId);
		alarmVO.setAlRcvrId(admin.getEmpId());
		dao.insertAlram(alarmVO);
	}

	public void qnaAnser(EmpVO realUser, String bpId) {
		BoardPostVO selectPrais = boardMapper.selectBaordPost(bpId);
		List<EmpVO> empList = empDao.selectList();
		AlarmTypeVO atVO = atDao.selectAlramType("A00016");
		CommonVO brdVO = cmDao.selectOne(selectPrais.getBrdId());
		AlarmVO alarmVO = new AlarmVO();
		alarmVO.setAlSndrId(realUser.getEmpId());
		alarmVO.setAlMoveUrl("/board/" + brdVO.getCmAtt1() + "/" + bpId);
		alarmVO.setAltypeId("A00016");
		alarmVO.setAlCn("[" + brdVO.getCmName() + "]" + atVO.getAltypeCn());
		emitters.forEach((empVO, emitter) -> {
			log.info("empVO : {}", empVO);
			log.info("emitter : {}", emitter);
			if (selectPrais.getEmpId().equals(empVO.getEmpId())) {
				try {
					String data = "<li><a class='alram-item' data-id='" + alarmVO.getAlarmId() + "' href='/navi"
							+ alarmVO.getAlMoveUrl() + "'>";
					data += "[" + brdVO.getCmName() + "]" + atVO.getAltypeCn();
					data += "<i class='icon new_icon'></i> </a></li>";
					emitter.send(SseEmitter.event().name("count").data(data));
				} catch (IOException e) {
					throw new RuntimeException(e);
				}
			}

		});
		alarmVO.setAlRcvrId(selectPrais.getEmpId());
		dao.insertAlram(alarmVO);
		alarmVO.setAlRcvrId("E00003");
		dao.insertAlram(alarmVO);
	}

	/**
	 * 채팅 로그인 알림을 전송하는 메서드
	 * @param realUser 로그인을 시도한 실제 사용자의 EmpVO 객체
	 */
	public void sendLoginNotification(@RealUser EmpVO realUser) {
	    // ObjectMapper 객체 생성
	    ObjectMapper objectMapper = new ObjectMapper();
	    // 알림 유형 조회
	    AlarmTypeVO atVO = atDao.selectAlramType("A00018");
	    // 사용자 이름 및 알림 메시지 생성
	    String userName = realUser.getEmpName();
	    String notificationMessage = userName + "님께서 " + atVO.getAltypeCn();

	    // 모든 SSE Emitters를 반복하면서 로그인 알림을 전송
	    emitters.forEach((empVO, emitter) -> {
	        // 실제 사용자와 동일한 경우 알림을 전송하지 않음
	        if (empVO.getEmpId().equals(realUser.getEmpId())) {
	            return;
	        }
	        try {
	            // SSE 이벤트를 생성하여 알림 메시지를 데이터로 전송
	            emitter.send(SseEmitter.event().name("login").data(objectMapper.writeValueAsString(notificationMessage)));
	        } catch (IOException e) {
	            // IOException 발생 시 런타임 예외로 처리
	            throw new RuntimeException(e);
	        }
	    });
	}

	@Inject
	ChatDAO chatDAO;

	public void sendMessage(String username, String roomId) {
		ObjectMapper objectMapper = new ObjectMapper();
		AlarmTypeVO atVO = atDao.selectAlramType("A00019");
		ChatUserVO cuVO = chatDAO.sameRoom(roomId, username);

	        emitters.forEach((empVO, emitter) -> {
	            // 현재 사용자와 같은 룸에 있는 사용자에게만 알림을 보냄
	            if (empVO.getEmpName().equals(cuVO.getEmpName())) {
	                    // JSON 객체 생성
	                    Map<String, Object> messageData = new HashMap<>();
	                    messageData.put("notificationMessage", username + "님께서 보낸" + atVO.getAltypeCn());
	                    messageData.put("roomId", roomId);
	                    messageData.put("username", cuVO.getEmpName());

	                    // JSON 문자열로 변환하여 전송
	                    try {
	                        emitter.send(SseEmitter.event().name("chat").data(objectMapper.writeValueAsString(messageData)));
	                    } catch (IOException e) {
	                        throw new RuntimeException(e);
	                    }
	                }
	        });
		}
	}
