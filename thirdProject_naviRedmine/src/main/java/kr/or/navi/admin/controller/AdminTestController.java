package kr.or.navi.admin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;

@Controller
@RequestMapping("/admin")
public class AdminTestController {

	@GetMapping
	public String adminPage(@RealUser EmpVO realUser, Model model) {
		model.addAttribute("realUser",realUser);
		return "admin/adminTest";
	}
	@GetMapping("facelogin")
	public String adminFaceLoginPage(@RealUser EmpVO realUser, Model model) {
		model.addAttribute("realUser",realUser);
		return "admin/adminTest2";
	}
	
	@GetMapping("faceemp")
	public String adminFaceEmpLoginPage(@RealUser EmpVO realUser, Model model) {
		model.addAttribute("realUser",realUser);
		return "admin/adminTest3";
	}

	

//	@GetMapping("project")
//	public String projectPage(Model model) {
//		return "admin/project";
//	}
//
//	@GetMapping("task")
//	public String taskPage(Model model) {
//		return "admin/task";
//	}
//
//	@GetMapping("wiki")
//	public String wikiPage(Model model) {
//		return "admin/wiki";
//	}
//
//	@GetMapping("formboard")
//	public String formPage(Model model) {
//		return "admin/board/form";
//	}
//
//	@GetMapping("anoboard")
//	public String anoPage(Model model) {
//		return "admin/board/ano";
//	}
//
//	@GetMapping("shareboard")
//	public String sharePage(Model model) {
//		return "admin/board/share";
//	}
//
//	@GetMapping("praisboard")
//	public String praisPage(Model model) {
//		return "admin/board/prais";
//	}
//
//	@GetMapping("photoboard")
//	public String photoPage(Model model) {
//		return "admin/board/photo";
//	}
//
//	@GetMapping("qnaboard")
//	public String qnaPage(Model model) {
//		return "admin/board/qna";
//	}
//
//	@GetMapping("datareportboard")
//	public String datareportPage(Model model) {
//		return "admin/datareporting";
//	}

}