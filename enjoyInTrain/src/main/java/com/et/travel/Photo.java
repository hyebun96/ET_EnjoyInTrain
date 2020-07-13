package com.et.travel;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Photo {
	private String pmCode;		// 프로모션코드
	private int fileNum;		// 파일고유번호
	private int fileContentNum;	// 파일내용고유번호
	private String saveFileName;	// 저장하는이름
	private String originalFileName;	// 기존이름
	private long fileSize;				// 파일 크기
	private List<MultipartFile> uploads;	// upload리스트
	
	public String getPmCode() {
		return pmCode;
	}
	public void setPmCode(String pmCode) {
		this.pmCode = pmCode;
	}
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
	}
	public String getSaveFileName() {
		return saveFileName;
	}
	public void setSaveFileName(String saveFileName) {
		this.saveFileName = saveFileName;
	}
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public long getFileSize() {
		return fileSize;
	}
	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}
	public List<MultipartFile> getUploads() {
		return uploads;
	}
	public void setUploads(List<MultipartFile> uploads) {
		this.uploads = uploads;
	}
	public int getFileContentNum() {
		return fileContentNum;
	}
	public void setFileContentNum(int fileContentNum) {
		this.fileContentNum = fileContentNum;
	}
	
	
	
}
