package com.et.suggest;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class Suggest {
	private int listNum;
	private int sgCode;
	private String sgCategory;
	private String crewId;
	private String crewName;
	private String sgContent;
	private String sgTitle;
	private String sgCreated;
	private int sgHitCount;
	private String anContent;
	private String anCreated;
	private int groupNum;
	private int dept;
	private int orderNo;
	private int parent;
	
	private int fileNum;
	private String originalFilename;
	private String saveFilename;
	private long fileSize;
	private int fileCount;
	
	private List<MultipartFile> upload;
	
	public List<MultipartFile> getUpload() {
		return upload;
	}
	public void setUpload(List<MultipartFile> upload) {
		this.upload = upload;
	}
	public int getFileNum() {
		return fileNum;
	}
	public void setFileNum(int fileNum) {
		this.fileNum = fileNum;
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
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getSgCode() {
		return sgCode;
	}
	public void setSgCode(int sgCode) {
		this.sgCode = sgCode;
	}
	public String getSgCategory() {
		return sgCategory;
	}
	public void setSgCategory(String sgCategory) {
		this.sgCategory = sgCategory;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public String getSgContent() {
		return sgContent;
	}
	public void setSgContent(String sgContent) {
		this.sgContent = sgContent;
	}
	public String getSgTitle() {
		return sgTitle;
	}
	public void setSgTitle(String sgTitle) {
		this.sgTitle = sgTitle;
	}
	public String getSgCreated() {
		return sgCreated;
	}
	public void setSgCreated(String sgCreated) {
		this.sgCreated = sgCreated;
	}
	public int getSgHitCount() {
		return sgHitCount;
	}
	public void setSgHitCount(int sgHitCount) {
		this.sgHitCount = sgHitCount;
	}
	public String getAnContent() {
		return anContent;
	}
	public void setAnContent(String anContent) {
		this.anContent = anContent;
	}
	public String getAnCreated() {
		return anCreated;
	}
	public void setAnCreated(String anCreated) {
		this.anCreated = anCreated;
	}
	public int getGroupNum() {
		return groupNum;
	}
	public void setGroupNum(int groupNum) {
		this.groupNum = groupNum;
	}
	public int getDept() {
		return dept;
	}
	public void setDept(int dept) {
		this.dept = dept;
	}
	public int getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(int orderNo) {
		this.orderNo = orderNo;
	}
	public int getParent() {
		return parent;
	}
	public void setParent(int parent) {
		this.parent = parent;
	}
}
