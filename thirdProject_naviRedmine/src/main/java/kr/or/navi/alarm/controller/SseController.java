package kr.or.navi.alarm.controller;

import java.io.IOException;

import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import kr.or.navi.alarm.service.SseEmitters;
import kr.or.navi.security.RealUser;
import kr.or.navi.vo.EmpVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
public class SseController {
    /**
     * 알림 처리 및 sse 연결을 위한 business layer 객체
     */
    private final SseEmitters sseEmitters;  
    
    public SseController(SseEmitters sseEmitters) {  
        this.sseEmitters = sseEmitters;  
    }  
  
    /**
     * 지속적으로 session 정보를 클라이언트로 부터 요청받는 컨트롤러
     * @param empVO adapter패턴을 사용하여 principal 객체로 사용중인 empVO
     * @return session 정보를 저장후 ok 응답 발생
     */
    @GetMapping(value = "/connect", produces = MediaType.TEXT_EVENT_STREAM_VALUE)  
    public ResponseEntity<SseEmitter> connect(@RealUser EmpVO empVO) {  
    	log.info("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
        SseEmitter emitter = new SseEmitter();  
        //business layer 객체를 통해 map에 저장하는 메서드 실행
        sseEmitters.add(empVO,emitter);
        try {  
            emitter.send(SseEmitter.event()  
                    .name("connect")  
                    .data("connected!"));  
        } catch (IOException e) {  
            throw new RuntimeException(e);  
        }  
        return ResponseEntity.ok(emitter);  
    }  
    @PostMapping("/count")  
    public ResponseEntity<Void> count() {
        sseEmitters.count();
        return ResponseEntity.ok().build();  
    }  
}
