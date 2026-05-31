package kr.or.navi.vo;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.validation.groups.Default;

import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import kr.or.navi.validate.AnoInsertGroup;
import kr.or.navi.validate.FormInsertGroup;
import kr.or.navi.validate.PhotoInsertGroup;
import kr.or.navi.validate.constraint.ValidFileSize;
import kr.or.navi.validate.constraint.ValidImageFile;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

/**
 *  게시판 정보 VO
 *
 */
@Data
@Slf4j
@EqualsAndHashCode(of="bpId")
public class BoardPostVO implements Serializable{
	private int rnum; //순번
	private String bpId; //게시글ID
	private String empId; //사원ID
	private String bpModId; //수정자ID
	private String brdId; //게시판ID
	@NotBlank(groups = {PhotoInsertGroup.class, AnoInsertGroup.class,FormInsertGroup.class,Default.class})
	private String bpTitle; //게시글 제목
	@ToString.Exclude
	@NotBlank(groups = {PhotoInsertGroup.class, AnoInsertGroup.class,FormInsertGroup.class,Default.class})
	private String bpCn; //게시글 내묭
	private LocalDateTime bpRegDt; //게시글 등록일
	private LocalDateTime bpModDt; //게시글 수정일
	private LocalDateTime bpDelDt; //게시글 삭제일
	private String bpOpYn; //게시글 공개여뷰
	private Integer bpCnt = 0; //조회수
	private String bpShrId; //나눔게시판 나눔상태ID
	private String bpShrYn; //나눔게시판 상태여부
	@NotBlank(groups = {AnoInsertGroup.class})
	private String bpNtcId; //관리자용 게시판ID
	private String empName; //사원이름
	private String bpNtcName; //관리자용 게시판별 이름
	private String cmAtt1; 
	private String cmName; 
	private String shrName; //나눔게시판 나눔상태 이름
	private String bpQnaAs; //QNA게시판 관리자답변내용
	private String bpQnaYn; //QNA게시판 답변여부
	private String qnaName; //QNA게시판 답변상태 이름
	private EmpVO emp; //사원 정보VO
	private List<BoardPostFileVO> bpFileVoList; //파일저장VO
	private MultipartFile[] bpAttchFile; //파일 업로드
	private BoardPostFileVO bpImgVo; //포토게시판 섬네일 이미지VO
	@NotNull(groups = {PhotoInsertGroup.class})
    @ValidFileSize(groups = {PhotoInsertGroup.class})
    @ValidImageFile(groups = {PhotoInsertGroup.class})
	private MultipartFile bpImgFile; //포토게시판 썸네일 이미지
	private Long fileSize; //파일사이즈
	private String modName; //수정자 이름
	private byte[] imgData; //포토게시판 섬네일 이미지데이터
	private int shareCount; //나눔게시판 나눔완료 게시글 처리 갯수
	private int totalCount; // 등록된 게시글 전체 갯수
	private String imgUuid; //포토게시판 섬네일 이미지uuid
	private String nowCheck; //새로등록된 게시글 체크
	
	
	public String getBase64Img() {
		if(imgData==null) return null;
		else 
			return Base64.getEncoder().encodeToString(imgData);
	}
	/**
	 * 조회수
	 * @return bpCnt
	 */
	public int getBpCnt() {
		 return this.bpCnt;
	}
	
	/**
	 * 관리자용 게시판ID의 공백 제거
	 * @return bpNtcId
	 */
	public String getBpNtcId() {
		if(StringUtils.isNotBlank(bpNtcId)) {
			return bpNtcId.trim();
		}
		return bpNtcId;
	}
	
	/**
	 * img를 bpImgVo에 담기
	 * @return bpImgVo
	 */
	public BoardPostFileVO getBpImgVo() {
		bpImgVo = new BoardPostFileVO();
		log.info("file : {}",bpImgFile);
		long size = 0;
		
		if(bpImgFile!=null) {
			size = bpImgFile.getSize();
		}
		if(size>0) {
			bpImgVo.setBpAttchFile(bpImgFile);
			bpImgVo.setBpId(bpId);
			
			long fileSize = bpImgFile.getSize();
			bpImgVo.setBpFileSize(convertFileSize(fileSize));
		}
		
		return bpImgVo;
	}
	
	/**
	 * 등록된 파일 Multipartfile 배열로 리스트에 저장
	 * @return bpFileVoList
	 */
	public List<BoardPostFileVO> getBpFileVoList(){
		bpFileVoList = new ArrayList<BoardPostFileVO>();
		if(bpAttchFile != null) {
			log.info("bpAttchFile : {}",bpAttchFile.length);
			for (MultipartFile file : bpAttchFile) {
				log.info("file : {}",file);
				long size = file.getSize();
				if(size>0) {
					BoardPostFileVO bpfv = new BoardPostFileVO();
					bpfv.setBpAttchFile(file);
					bpfv.setBpId(bpId);
					
					long fileSize = file.getSize();
					bpfv.setBpFileSize(convertFileSize(fileSize));
					
					bpFileVoList.add(bpfv);
				}
			}
		}
		return bpFileVoList;
	}
	
	/**
	 * BYTE 사이즈 KB, MB로 변경
	 * @param size
	 * 
	 */
	public String convertFileSize(long size) {
	    // KB 단위로 변환
	    double kbSize = (double) size / 1024;
	    if (kbSize < 1024) {
	        return String.format("%.2f KB", kbSize);
	    }

	    // MB 단위로 변환
	    double mbSize = kbSize / 1024;
	    return String.format("%.2f MB", mbSize);
	}
	
	/**
	 * 등록일 TIMESTAMP yy/mm/dd로 자르기
	 */
	public String getBpRegDtStr(){
		if(bpRegDt!=null)
		return bpRegDt.format(DateTimeFormatter.ISO_DATE);

		return null;
	}
	
	
	/**
	 * 수정일 TIMESTAMP yy/mm/dd로 자르기
	 */
	public String getBpModDtStr(){
		if(bpModDt!=null)
		return bpModDt.format(DateTimeFormatter.ISO_DATE);

		return null;
	}
	
	/**
	 * 삭제일 TIMESTAMP yy/mm/dd로 자르기
	 */
	public String getBpDelDtStr(){
		if(bpDelDt!=null)
		return bpDelDt.format(DateTimeFormatter.ISO_DATE);
		
		return null;
	}
	
	/**
	 * 나눔상태 여부 공백 제거
	 * @return bpShrYn
	 */
	public String getBpShrYn() {
		if(StringUtils.isNotBlank(bpShrYn)) {
			return bpShrYn.trim();
		}else {
			return bpShrYn;
		}
	}
	

}
