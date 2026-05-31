package kr.or.navi.alarm.dao;

import org.apache.ibatis.annotations.Mapper;

import kr.or.navi.vo.BoardPostVO;
import kr.or.navi.vo.EmpVO;

@Mapper
public interface AlramBoardMapper {
	public BoardPostVO selectBaordPost(String bpId);
	public EmpVO selectAdmin();
}
