package com.et.reservation;

public class Station {
	private String sCode;
	private String sName;
	private String line;
	private int lineOrder;
	
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
	public int getLineOrder() {
		return lineOrder;
	}
	public void setLineOrder(int lineOrder) {
		this.lineOrder = lineOrder;
	}
}
