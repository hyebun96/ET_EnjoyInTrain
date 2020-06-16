package com.et.lostBoard;

import org.springframework.web.multipart.MultipartFile;

public class LostBoard {
	private int lostNum;
	private int listNum;
	private int lostHitCount;
	private String lostTitle;
	private String lostContent;
	private String crewId;
	private String lostCreated;
	private String originalFileName;
	private String saveFileName;
	private double fileSize;
	private int num;
	private MultipartFile upload;
	private long gap;
	
	public int getLostNum() {
		return lostNum;
	}
	public void setLostNum(int lostNum) {
		this.lostNum = lostNum;
	}
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getLostHitCount() {
		return lostHitCount;
	}
	public void setLostHitCount(int lostHitCount) {
		this.lostHitCount = lostHitCount;
	}
	public String getLostTitle() {
		return lostTitle;
	}
	public void setLostTitle(String lostTitle) {
		this.lostTitle = lostTitle;
	}
	public String getLostContent() {
		return lostContent;
	}
	public void setLostContent(String lostContent) {
		this.lostContent = lostContent;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public String getLostCreated() {
		return lostCreated;
	}
	public void setLostCreated(String lostCreated) {
		this.lostCreated = lostCreated;
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
	public double getFileSize() {
		return fileSize;
	}
	public void setFileSize(double fileSize) {
		this.fileSize = fileSize;
	}
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public long getGap() {
		return gap;
	}
	public void setGap(long gap) {
		this.gap = gap;
	}
	public int getnum() {
		return num;
	}
	public void setnum(int num) {
		this.num = num;
	}
	
}
