package kr.or.navi.chat.web.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.navi.chat.web.dao.ChatDAO;
import kr.or.navi.vo.ChatRoomVO;
import kr.or.navi.vo.ChatUserVO;
import kr.or.navi.vo.ChatVO;
import kr.or.navi.vo.EmpVO;

@Service
public class ChatServiceImpl implements ChatService {
	
	@Inject
	private ChatDAO cdao;
	
	@Override
	public List<EmpVO> chatEmpList(String empId) {
		return cdao.selectChatEmpList(empId);
	}
	
    @Override
    public void createPrivateRoom(ChatRoomVO roomVO) {
    	cdao.createPrivateRoom(roomVO);
    }
    
    @Override
    public void addChatUser(String roomId, String empId) {
        cdao.addChatUser(roomId, empId);
    }

	@Override
	public String checkRoom(String findId, String userId) {
		return cdao.checkRoom(findId, userId);
	}

	@Override
	public List<ChatVO> getMessage(String roomId) {
		return cdao.getMessage(roomId);
	}

	@Override
	public int addMessage(ChatVO chatVO) {
		return cdao.addMessage(chatVO);
	}

}
