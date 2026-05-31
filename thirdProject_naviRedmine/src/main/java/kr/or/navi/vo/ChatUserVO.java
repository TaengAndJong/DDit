package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"roomId","empId"})
public class ChatUserVO implements Serializable{
	private String roomId;
	private String empId;
	private String empName;
	private String roomName;
	private LocalDateTime roomCreateDt;
	private String lastChat;
	private LocalDateTime lastChatSendDt;
	
	public String getroomCreateDtStr() {
		if(roomCreateDt!=null)
			return roomCreateDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
	
	public String getlastChatSendDtStr() {
		if(lastChatSendDt!=null)
			return lastChatSendDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}
