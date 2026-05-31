package kr.or.navi;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.board.ano.service.AnoService;
import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.index.service.IndexService;
import kr.or.navi.mypagedetail.alarm.dao.AlramDAO;
import kr.or.navi.project.service.ProjectService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.AlarmVO;
import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.ProjectVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/index.do")
@Controller
public class IndexController {
	
	@Inject
	AnoService anoSerivce;
	
	@Inject
	IndexService indexService;
	
	@GetMapping()
	public String index(Model model) {
		List<BoardPostVO> anoMainlist = anoSerivce.retrieveAnoMainList();
		model.addAttribute("anoMainlist", anoMainlist);
		List<EmpVO> topPers = indexService.retriveTopPerformer();
		model.addAttribute("topPers", topPers);
		return "index"; // 확장자를 입력하지 않으면 index.html || index.jsp의 뷰를 찾아감
	}
	@Inject
	private AlramDAO dao;
	@ModelAttribute("alramDisplayList")
	public List<AlarmVO> selectAlramList(@RealUser EmpVO realUser){
		log.info("alramDisplayList");
		return dao.selectDisplayAlramList(realUser.getEmpId());
	}
	 @PostMapping("project")
	 @ResponseBody// 클라이언트에게 보내는 데이터 body에 담아서 보냄
	 public List<ProjectVO> projectChart() { 
		 //2. 프로젝트 총 계약갯수
		
			List<ProjectVO> proMainlist =indexService.selectList();
			
		
		 return proMainlist; 
		 
	 }
	
	
	@GetMapping("alram")
	@ResponseBody
	public List<AlarmVO> alramList(@RealUser EmpVO realUser){
		return dao.selectDisplayAlramList(realUser.getEmpId());
	}
	@PostMapping("alram")
	@ResponseBody
	public String alramClick(@RealUser EmpVO realUser, @RequestParam("alId") String alId) {
		log.info("alId : {}",alId);
		int cnt = dao.updateReadAlram(alId);
		if(cnt>0) {
			return "ok";
		}
		else {
			return "fail";
		}
	}
}
