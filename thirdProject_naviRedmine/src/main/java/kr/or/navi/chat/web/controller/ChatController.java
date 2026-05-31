package kr.or.navi.chat.web.controller;

import java.util.List;
import java.util.Map;
import java.util.Objects;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.chat.web.service.ChatService;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/chat")
public class ChatController {
    
    @Inject
    ChatService service;
    
    @Inject
    SseEmitters sseEmitters;
    
    /**
     * 채팅로그인을 처리하는 메서드
     * @param realUser 로그인을 시도하는 사용자의 EmpVO 객체
     * @param requestBody 요청 바디에 포함된 데이터를 담은 Map 객체
     * @return 로그인 성공 시 ok, 실패 시 fail을 반환
     */
    @ResponseBody
    @PostMapping("/login")
    public String chatPw(@RealUser EmpVO realUser, @RequestBody Map<String, String> requestBody) {
        String pass = realUser.getEmpPass();
        String password = requestBody.get("password"); 

        if (Objects.equals(pass, password)) {
            // 비밀번호가 일치할 경우, 로그인 알림을 전송
            sseEmitters.sendLoginNotification(realUser);
            return "ok";
        } else {
            return "fail";
        }
    }
    
    @GetMapping("/chatEmpList")
    public String chatEmpListMain(@RealUser EmpVO realUser, Model model) {
        model.addAttribute("realUser", realUser);
        // WebSocket 서버 객체를 모델에 추가하여 JSP에서 접근 가능하도록 함
        return "chat/chatEmpList";
    }
    
    @ResponseBody    
    @PostMapping("/chatEmpList")
    public List<EmpVO> chatEmpList(@RealUser EmpVO realUser) {
        String empId = realUser.getEmpId();
        List<EmpVO> chatEmpList = service.chatEmpList(empId);
        return chatEmpList;
    }
    
    
    @GetMapping("/chatRoom")
    public String openChatRoomPopup(
            @RequestParam(value = "roomId") String roomId
            , Model model
//            @RequestParam(value = "username") String username,
//            @RealUser EmpVO realUser, HttpSession session
            ) {
        
//            model.addAttribute("roomVO", session.getAttribute("roomVO"));
            model.addAttribute("roomId", roomId);
//            model.addAttribute("username", username);
            
        return "chat/popup/chatRoom";
    }
    
    @PostMapping("/chatRoom")
    public String postChatRoomPopup(
            @RequestParam(value = "roomId") String roomId,
            @RequestParam(value = "username") String username,
            HttpSession session,
            ModelMap model
    ) {
//        model.addAttribute("roomVO", session.getAttribute("roomVO"));
        model.addAttribute("roomId", roomId);
        model.addAttribute("username", username);

        return "chat/popup/chatRoom";
    }
}