package com.et.travel;

public class StationLine {
	private int trainCode;		// 기차번호
	private String trainName;	// 기차이름
	private String startName;	// 시발역
	private String endName;		// 종착역
	private String startTime;	// 시간
	private String endTime;		// 시간
	
	public int getTrainCode() {
		return trainCode;
	}
	public void setTrainCode(int trainCode) {
		this.trainCode = trainCode;
	}
	public String getTrainName() {
		return trainName;
	}
	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}
	public String getStartName() {
		return startName;
	}
	public void setStartName(String startName) {
		this.startName = startName;
	}
	public String getEndName() {
		return endName;
	}
	public void setEndName(String endName) {
		this.endName = endName;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	
}
