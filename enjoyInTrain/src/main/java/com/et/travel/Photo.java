package com.et.travel;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Photo {
	private String pmCode;
	private int fileNum;
	private int fileContentNum;
	private String saveFileName;
	private String originalFileName;
	private long fileSize;
	private List<MultipartFile> uploads;
	
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
