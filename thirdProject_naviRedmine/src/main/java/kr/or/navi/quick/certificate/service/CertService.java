package kr.or.navi.quick.certificate.service;

import java.util.List;

import kr.or.navi.quick.certificate.vo.CertVO;
import kr.or.navi.vo.EmpVO;

public interface CertService {
	public List<CertVO> selectCertList();
	public List<CertVO> recomCertList(EmpVO vo);
}
