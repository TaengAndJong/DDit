package kr.or.navi.boardFile.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.List;

import javax.servlet.annotation.MultipartConfig;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.vo.BoardPostFileVO;
import lombok.extern.slf4j.Slf4j;
//
//@Slf4j
//@Controller
//@MultipartConfig
public class FileUploadController {
	
//	private final File saveFolder = new File("d:/saveFile");
//
//	@GetMapping("/board/prais")
//	public String praisFile(Model model) {
//		return "board/prais";
//	}
//	@PostMapping("/board/prais_add")
//	public String uploadFile(MultipartFile file) {
//		File saveFile = new File(saveFolder, file.getOriginalFilename());
//		
//		InputStream is = file.getInputStream();
//		FileOutputStream fos = new FileOutputStream(saveFile) {
////			byte[] buffer = new byte[1024];
////			int position;
////			while((position = is.read(buffer)) != -1) {
////				fos.write(buffer, 0, position);
//			}
//		}
//		return 
//	}
}
