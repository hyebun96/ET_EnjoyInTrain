package com.et.travel;

public class Station {
	private String sCode;		// 역 코드
	private String sName;		// 역 이름
	private String engName;		// 역 영어이름
	private String line;		// 호선
	private String lineOrder;	// 호선순서
	
	public String getsCode() {
		return sCode;
	}
	public void setsCode(String sCode) {
		this.sCode = sCode;
	}
	public String getsName() {
		return sName;
	}
	public void setsName(String sName) {
		this.sName = sName;
	}
	public String getLine() {
		return line;
	}
	public void setLine(String line) {
		this.line = line;
	}
	public String getLineOrder() {
		return lineOrder;
	}
	public void setLineOrder(String lineOrder) {
		this.lineOrder = lineOrder;
	}
	public String getEngName() {
		return engName;
	}
	public void setEngName(String engName) {
		this.engName = engName;
	}
	
	
}
