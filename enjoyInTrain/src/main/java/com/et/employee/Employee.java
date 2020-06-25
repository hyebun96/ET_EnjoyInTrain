package com.et.employee;


public class Employee {
	private int listNum;
	private int emCode; //직원번호
	private String emName; //직원이름
	private String hireDate; //입사일
	private int emcheck; //재직여부
	private String emBirth; //생년월일
	
	private int ptCode;  //직책코드
	private String ptCategory; //직책
	
	public int getListNum() {
		return listNum;
	}
	public void setListNum(int listNum) {
		this.listNum = listNum;
	}
	public int getEmCode() {
		return emCode;
	}
	public void setEmCode(int emCode) {
		this.emCode = emCode;
	}
	public String getEmName() {
		return emName;
	}
	public void setEmName(String emName) {
		this.emName = emName;
	}
	public String getHireDate() {
		return hireDate;
	}
	public void setHireDate(String hireDate) {
		this.hireDate = hireDate;
	}
	public int getEmcheck() {
		return emcheck;
	}
	public void setEmcheck(int emcheck) {
		this.emcheck = emcheck;
	}
	public String getEmBirth() {
		return emBirth;
	}
	public void setEmBirth(String emBirth) {
		this.emBirth = emBirth;
	}
	public int getPtCode() {
		return ptCode;
	}
	public void setPtCode(int ptCode) {
		this.ptCode = ptCode;
	}
	public String getPtCategory() {
		return ptCategory;
	}
	public void setPtCategory(String ptCategory) {
		this.ptCategory = ptCategory;
	}
}
