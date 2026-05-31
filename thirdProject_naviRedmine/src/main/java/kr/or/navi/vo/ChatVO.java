package kr.or.navi.vo;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import kr.or.navi.chat.server.model.Message;
import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="chatId")
public class ChatVO implements Message {
	private String chatId;
	private String roomId;
	private String senderId;
	private String empName;
	private String chatCn;
	private LocalDateTime chatSendDt;
	
	public String getChatSendDtdStr() {
		if(chatSendDt!=null)
			return chatSendDt.format(DateTimeFormatter.ISO_DATE);
		return null;
	}
}
