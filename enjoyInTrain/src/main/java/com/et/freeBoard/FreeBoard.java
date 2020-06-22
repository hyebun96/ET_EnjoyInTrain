package com.et.freeBoard;
/*
약어 fb	영문	번역
테이블명	freeBoard	자유게시판 테이블
컬럼명	fbNum		자유게시판 번호
		crewCode	회원 코드
		fbContent	자유게시판 내용
		fbTitle		자유게시판 제목
		fbCreated	자유게시판 작성일
		fbHitCount	자유게시판 조회수
		fbLikeCount	자유게시판 좋아요
시퀀스	freeboard_seq	
참조		crew		고객 테이블
 */

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FreeBoard {
	private int listNum; 		//리스트번호
	private String crewName;	//회원이름
	private String crewId;		//회원아이디(키)
	private int fbNum;			//게시판번호 num
	private String fbContent; 	//내용
	private String fbTitle; 	//제목
	private String fbCreated;  	//작성일
	private int fbHitCount; 	//조회수
	private int fbLikeCount;	//좋아요갯수
	private int replyCount;		//댓글갯수
	
	private int fbFileNum;  //파일번호
	private String originalFileName; //원본파일이름  
	private String saveFileName;	 //파일올릴때저장이름
	private long fileSize;			 //파일크기
	private int fileCount;			//파일갯수
	private List<MultipartFile> upload; // <input type='file' name='upload' ..
	
	private long gap;

	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public int getFbNum() {
		return fbNum;
	}
	public void setFbNum(int fbNum) {
		this.fbNum = fbNum;
	}
	public String getFbContent() {
		return fbContent;
	}
	public void setFbContent(String fbContent) {
		this.fbContent = fbContent;
	}
	public String getFbTitle() {
		return fbTitle;
	}
	public void setFbTitle(String fbTitle) {
		this.fbTitle = fbTitle;
	}
	public String getFbCreated() {
		return fbCreated;
	}
	public void setFbCreated(String fbCreated) {
		this.fbCreated = fbCreated;
	}
	public int getFbHitCount() {
		return fbHitCount;
	}
	public void setFbHitCount(int fbHitCount) {
		this.fbHitCount = fbHitCount;
	}
	public int getFbLikeCount() {
		return fbLikeCount;
	}
	public void setFbLikeCount(int fbLikeCount) {
		this.fbLikeCount = fbLikeCount;
	}
	public int getReplyCount() {
		return replyCount;
	}
	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}
	public int getFbFileNum() {
		return fbFileNum;
	}
	public void setFbFileNum(int fbFileNum) {
		this.fbFileNum = fbFileNum;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public int getFileCount() {
		return fileCount;
	}
	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public long getGap() {
		return gap;
	}
	public void setGap(long gap) {
		this.gap = gap;
	}
	
}	
	


