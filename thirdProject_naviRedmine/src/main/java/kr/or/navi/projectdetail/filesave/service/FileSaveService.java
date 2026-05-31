package kr.or.navi.projectdetail.filesave.service;

import java.io.IOException;
import java.util.List;

import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;

import kr.or.navi.common.paging.PaginationInfo;
import kr.or.navi.vo.FileSaveFileVO;
import kr.or.navi.vo.FileSaveNoticeVO;


public interface FileSaveService {
	public List<FileSaveNoticeVO> retrieveFileSaveNotice(PaginationInfo paging, String proId);
	public FileSaveNoticeVO retrieveFileSaveVO(String fsnId);
	public int removeFileSave(String fsnId);
	public int modifyFileSave(FileSaveNoticeVO updateFs) throws IOException;
	public int createFileSave(FileSaveNoticeVO insertFs) throws IOException;
	public List<FileSaveFileVO> retriveFileSaveFileList(String fsnId);
	public ResponseEntity<Resource> downloadFile(String fsnId) throws IOException;
	public int removeFileSaveFile(String fsnId) throws IOException;
}
