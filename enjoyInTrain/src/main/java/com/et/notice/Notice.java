package com.et.notice;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Notice {
	private int noticeNum;
	private String noticeContent;
	private String noticeTitle;
	private String nCreated;
	private int nHitCount;
	private int nLikeCount;
	private String emCode;
	
	
	private int noticeFileNum;
	private String originalFilename;
	private String saveFilename;
	private long fileSize;
	private int fileCount;
	
	private List<MultipartFile> upload;
	
	private long gap;

	public int getNoticeNum() {
		return noticeNum;
	}

	public void setNoticeNum(int noticeNum) {
		this.noticeNum = noticeNum;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getnCreated() {
		return nCreated;
	}

	public void setnCreated(String nCreated) {
		this.nCreated = nCreated;
	}

	public int getnHitCount() {
		return nHitCount;
	}

	public void setnHitCount(int nHitCount) {
		this.nHitCount = nHitCount;
	}

	public int getnLikeCount() {
		return nLikeCount;
	}

	public void setnLikeCount(int nLikeCount) {
		this.nLikeCount = nLikeCount;
	}

	public String getEmCode() {
		return emCode;
	}

	public void setEmCode(String emCode) {
		this.emCode = emCode;
	}

	public int getnoticeFileNum() {
		return noticeFileNum;
	}

	public void setnoticeFileNum(int noticeFileNum) {
		this.noticeFileNum = noticeFileNum;
	}

	public String getOriginalFilename() {
		return originalFilename;
	}

	public void setOriginalFilename(String originalFilename) {
		this.originalFilename = originalFilename;
	}

	public String getSaveFilename() {
		return saveFilename;
	}

	public void setSaveFilename(String saveFilename) {
		this.saveFilename = saveFilename;
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
