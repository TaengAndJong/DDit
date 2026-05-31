package kr.or.navi.vo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(of="fsId")
public class FileSaveVO implements Serializable{
	private String fsId;
	private String proId;
	
}
