package kr.or.navi.chat.web.dao;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.or.navi.vo.ChatRoomVO;
import kr.or.navi.vo.ChatUserVO;
import kr.or.navi.vo.ChatVO;
import kr.or.navi.vo.EmpVO;

@Mapper
public interface ChatDAO {

	public String checkRoom(@Param("findId") String findId, @Param("userId") String userId);
	public List<EmpVO> selectChatEmpList(@Param("empId") String empId);
	public void createPrivateRoom(ChatRoomVO roomVO); 
	public void addChatUser(@Param("roomId") String roomId, @Param("empId") String empId);
	public List<ChatVO> getMessage(String roomId);
	public int addMessage(ChatVO chatVO);
	public ChatUserVO sameRoom(@Param("roomId") String roomId, @Param("empName") String empName);
}
