package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of = {"chatId","readId"})
public class ChatReadVO implements Serializable{
	private String chatId;
	private String readId;
	private LocalDateTime readTime;
}
