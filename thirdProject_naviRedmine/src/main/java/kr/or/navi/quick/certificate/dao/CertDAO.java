package kr.or.navi.quick.certificate.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.quick.certificate.vo.CertVO;

@Mapper
public interface CertDAO {
	public List<CertVO> selectCertList();

	public List<CertVO> selectRecomCertList(@Param("map") HashMap<String, String> map);
}
