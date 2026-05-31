package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="roomId")
public class ChatRoomVO implements Serializable {
	private String roomId;
	private String roomName;
	private String empId;
	private String roomType;
	private String roomDelYn;
	private LocalDateTime roomCreateDt;
}
