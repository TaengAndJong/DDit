package kr.or.navi.projectdetail.filesave.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.groups.Default;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.lang3.StringUtils;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.common.paging.BootstrapFormBasePaginationRenderer;
import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.common.paging.PaginationRenderer;
import kr.or.navi.common.paging.SearchCondition;
import kr.or.navi.projectdetail.filesave.service.FileSaveService;
import kr.or.navi.projectdetail.gantt.controller.ProjectGanttController;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import kr.or.navi.vo.FileSaveFileVO;
import kr.or.navi.vo.FileSaveNoticeVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/project/filesave")
@Slf4j
public class ProjectFilesaveController {
	/*
	 * 1. 파일 저장소 id 를 조회한다.
	 * 2. 해당 파일 저장소의 file_save_notice 목록을 가져온다.
	 * 
	 */
	
	@Inject
	private FileSaveService service;
	
	@GetMapping("{proId}")
	public String filesavePage(@PathVariable(name = "proId") String proId,
			@RequestParam(name="page", required = false, defaultValue = "1") int currentPage
			, Model model
			, @ModelAttribute("simpleCondition") SearchCondition simpleCondition
	) {
		log.info("simpleCondition : {}",simpleCondition);
		PaginationInfo paging = new PaginationInfo(10,10);
		paging.setCurrentPage(currentPage);
		paging.setSimpleCondition(simpleCondition);
		List<FileSaveNoticeVO> fsList = service.retrieveFileSaveNotice(paging,proId);
		model.addAttribute("fsList", fsList);
		PaginationRenderer renderer = new BootstrapFormBasePaginationRenderer("#searchForm");
		String pagingHTML = renderer.renderPagination(paging);
		model.addAttribute("pagingHTML",pagingHTML);
		model.addAttribute("paging",paging);
		return "project/filesave/filesave";
	}
	//상세페이지
	@GetMapping("{proId}/{fsnId}")
	public String filesaveDetailPage(@PathVariable(name = "proId") String proId,@PathVariable(name="fsnId")String fsnId,Model model) {
		FileSaveNoticeVO vo = service.retrieveFileSaveVO(fsnId);
		model.addAttribute("fs", vo);
		List<FileSaveFileVO> list = service.retriveFileSaveFileList(fsnId);
		model.addAttribute("fileList",list);
		return "project/filesave/filesaveDetail";
	}
	
	//수정 페이지
	@GetMapping("modify/{proId}/{fsnId}")
	public String filesaveModPage(@PathVariable(name = "proId") String proId,@PathVariable(name="fsnId")String fsnId,Model model) {
		FileSaveNoticeVO vo = service.retrieveFileSaveVO(fsnId);
		model.addAttribute("fs", vo);
		List<FileSaveFileVO> list = service.retriveFileSaveFileList(fsnId);
		model.addAttribute("fileList",list);
		return "project/filesave/filesaveModify";
	}
	@PostMapping("mod/{fsnId}")
	@ResponseBody
	public Map<String, String> filesaveModController(@PathVariable(name="fsnId") String fsnId, Model model,@ModelAttribute("fs") FileSaveNoticeVO updateFs) throws IOException {
		log.info("updateFs : {}",updateFs);
		Map<String, String> map = new HashedMap();
		if(StringUtils.isNotBlank(updateFs.getFsnTitle()) && StringUtils.isNotBlank(updateFs.getFsnCn())) {
			updateFs.setFsnId(fsnId);
			int cnt = service.modifyFileSave(updateFs);
			if(cnt>0) {
				map.put("msg", "ok");
			}else {
				map.put("msg", "fail");
			}
		}else {
			map.put("msg", "fail");
		}
		return map;
	}
	@DeleteMapping("{fsnId}")
	public String filesaveDelController(@PathVariable(name="fsnId") String fsnId, Model model) {
		log.info("fsnId : {}",fsnId);
		int cnt = service.removeFileSave(fsnId);
		if(cnt>0) {
			model.addAttribute("msg", "ok");
		}else {
			model.addAttribute("msg", "fail");
		}
		return "jsonView";
	}
	
	@GetMapping("add/{proId}")
	public String filesaveAddPage(
			@ModelAttribute("fs") FileSaveNoticeVO insertFs
			,@PathVariable("proId") String proId
			,Model model) {
		return "project/filesave/filesaveAdd";
	}
	@PostMapping("add/{proId}")
	public String filesaveAddController(
			@Validated(Default.class) @ModelAttribute("fs") FileSaveNoticeVO insertFs
			, Errors errors,@RealUser EmpVO realUser
			,@PathVariable("proId") String proId) throws IOException {
		log.info("insertFs : {}",insertFs);
		if(!errors.hasErrors()) {
			insertFs.setProId(proId);
			insertFs.setFsnRegId(realUser.getEmpId());
			
			int cnt = service.createFileSave(insertFs);
			if(cnt>0) {
				return "redirect:/project/filesave/"+proId;
			}else {
				return "project/filesave/filesaveAdd";
			}
		}else {
			return "project/filesave/filesaveAdd";
		}
	}
	@GetMapping("download/{fsnId}")
	public ResponseEntity<Resource> downloadFile(@PathVariable String fsnId) throws IOException{
		return service.downloadFile(fsnId);
	}
	@PostMapping("file/del/{fsnId}")
	@ResponseBody
	public Map<String, String> isssueFileDelController(@PathVariable String fsnId) throws IOException {
		int cnt = service.removeFileSaveFile(fsnId);
		Map<String, String> msg = new HashedMap();
		if(cnt>0) {
			msg.put("msg", "ok");
		}else {
			msg.put("msg", "fail");
		}
		return msg;
	}
}
