package kr.or.navi.quick.certificate.controller;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.quick.certificate.service.CertService;
import kr.or.navi.quick.certificate.vo.CertVO;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;

@Controller
@RequestMapping("/quick/cert")
public class CertRecomController {
	@Inject
	private CertService service;

	@GetMapping
	public String certPage(@RealUser EmpVO vo, Model model) {
		List<CertVO> certList = service.selectCertList();
		List<CertVO> recomList = service.recomCertList(vo);
		model.addAttribute("certList", certList);
		model.addAttribute("recomList", recomList);
		return "quick/certList";
	}

	@PostMapping
	@ResponseBody
	public Object getRecom(@RealUser EmpVO vo) {
		List<CertVO> recomList = service.recomCertList(vo);
		return recomList;
	}
}
