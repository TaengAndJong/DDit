package kr.or.navi.admin.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.vo.BoardPostVO;

@Mapper
public interface AdminBoardDAO {

	public int deleteCheckedProject(@Param("boards") List<BoardPostVO> board);

}
