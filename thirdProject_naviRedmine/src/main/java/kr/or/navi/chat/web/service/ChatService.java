package kr.or.navi.chat.web.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.or.navi.vo.ChatRoomVO;
import kr.or.navi.vo.ChatUserVO;
import kr.or.navi.vo.ChatVO;
import kr.or.navi.vo.EmpVO;

public interface ChatService {
	public List<EmpVO> chatEmpList(String empId);
	public void createPrivateRoom(ChatRoomVO roomVO);
	public void addChatUser(String roomId, String empId);
	public String checkRoom(@Param("findId") String findId, @Param("userId") String userId);
	public List<ChatVO> getMessage(String roomId);
	public int addMessage(ChatVO chatVO);
	
}
