package kr.or.navi.chat.server;

import java.io.IOException;
import java.io.StringReader;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.json.Json;
import javax.json.JsonObject;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import org.springframework.stereotype.Component;

import kr.or.navi.chat.server.config.ServerAppConfig;
import kr.or.navi.chat.web.service.ChatService;
import kr.or.navi.mypage.service.MypageService;
import kr.or.navi.vo.ChatRoomVO;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@ServerEndpoint(value = "/usersServerEndpoint", configurator = ServerAppConfig.class)
public class UsersServerEndPoint {
    @Inject
    private ChatService chatService;
    
    @Inject
    private MypageService myService;

    @OnOpen
    public void onOpen(Session userSession) {
        // 클라이언트와의 WebSocket 연결이 열렸을 때 실행되는 로직
        log.info("WebSocket 연결이 열렸습니다. 세션 ID: {}", userSession.getId());
    }
    @OnClose
    public void onClose(Session userSession) {
        // 클라이언트와의 WebSocket 연결이 닫혔을 때 실행되는 로직
        log.info("WebSocket 연결이 닫혔습니다. 세션 ID: {}", userSession.getId());
    }
    @OnError
    public void onError(Session userSession, Throwable throwable) {
        // WebSocket 연결 중 오류가 발생했을 때 실행되는 로직
        log.error("WebSocket 오류 발생. 세션 ID: {}", userSession.getId(), throwable);
    }
    
    /**
     * 클라이언트로부터 메시지를 받는 메서드
	 * @param message 클라이언트로부터 받은 메시지
	 * @param userSession 현재 세션에 대한 정보
	 * @throws IOException 입력 및 출력과 관련된 예외가 발생할 수 있음
	 * @throws EncodeException 인코딩 관련 예외가 발생할 수 있음
     */
    @OnMessage
    public void handleMessage(String message, Session userSession) throws IOException, EncodeException {
    	String username = (String) userSession.getUserProperties().get("Username");
        // JSON 형식의 메시지를 파싱합니다.
        JsonObject jsonObject = Json.createReader(new StringReader(message)).readObject();
        String connectionType = null;
        if (jsonObject.containsKey("connectionType")) {
            connectionType = jsonObject.getString("connectionType");
        } else {
            log.error("메시지에 연결 타입이 포함되어 있지 않습니다.");
        }
        // 만약 연결 타입이 채팅 연결이라면,
        if ("chatConnection".equals(connectionType)) {
            // 연결하는 사용자 이름을 가져옴
            String connectingUser = jsonObject.getString("connectingUser");
            String userId = jsonObject.getString("userId");
        	 // 선택한 사용자의 정보를 가져옴
            List<EmpVO> userList = chatService.chatEmpList(connectingUser);
            // 사용자 정보가 존재하는지 확인
            if (userList != null && !userList.isEmpty()) {
	            // 해당 사용자의 채팅방 ID를 가져오거나 새로 생성
	            String roomId = getOrCreateChatRoom(connectingUser, userId);
	            // 클라이언트에게 채팅방 정보를 전송
	            sendRoomInfoToClient(roomId, userSession);
            } else {
                log.error("채팅을 시작할 수 없습니다. 사용자 정보를 찾을 수 없습니다.");
            }
        }
    }

    /**
     * 사용자의 채팅방을 가져오거나 새로 생성하는 메서드
	 * @param connectingUser 채팅을 시작하는 사용자의 ID
	 * @param userId 채팅에 참여하는 상대방의 ID
	 * @return 생성된 또는 이미 존재하는 채팅방의 ID
     */
    private String getOrCreateChatRoom(String connectingUser, String userId) {
        // 이미 해당 사용자의 채팅방이 존재하는지 확인
        String roomId = chatService.checkRoom(connectingUser, userId);
        if (roomId != null) { // 채팅방이 이미 존재하면 해당 roomId를 반환
            return roomId;
        } else {
            // 해당 사용자의 정보를 데이터베이스에서 조회
            EmpVO empInfo = myService.selectOne(connectingUser);
            // 사용자 정보가 없는 경우
            if (empInfo == null) {
                log.error("사용자 정보를 찾을 수 없습니다.");
                return null;
            }

            // 새로운 채팅방 VO 객체를 생성하고 이름을 설정
            ChatRoomVO roomVO = new ChatRoomVO();
            // 새로운 채팅방의 이름을 구성
            String roomName = empInfo.getEmpName() + empInfo.getPsName() + "(" + empInfo.getDeptName() + ")";
            roomVO.setRoomName(roomName);
            // 데이터베이스에 새로운 채팅방을 생성하고 ID를 받아옴
            chatService.createPrivateRoom(roomVO);
            roomId = roomVO.getRoomId();
            
         // 채팅방이 성공적으로 생성되었는지 확인
            if (roomId != null) {
                // 채팅방에 사용자들을 추가
                chatService.addChatUser(roomId, connectingUser);
                chatService.addChatUser(roomId, userId);
            } else {
                log.error("채팅방을 생성할 수 없습니다.");
            }
            return roomId;
        }
    }

    /**
     * 클라이언트에게 채팅방 정보를 전송하는 메서드
     * @param roomId 전송할 채팅방의 ID
     * @param userSession 현재 사용자 세션에 대한 정보
     * @throws IOException 입출력 예외가 발생할 수 있음
     */
    private void sendRoomInfoToClient(String roomId, Session userSession) throws IOException {
        // JSON 형식으로 채팅방 정보를 구성
        JsonObject roomInfo = Json.createObjectBuilder()
                .add("roomId", roomId)
                .build();
        // 클라이언트에게 채팅방 정보를 전송
        userSession.getBasicRemote().sendText(roomInfo.toString());
    }
}