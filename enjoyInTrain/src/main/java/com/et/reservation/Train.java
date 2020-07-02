package com.et.reservation;

public class Train {
	private String trainCode;  //기차코드
	private String trainName;  //기차종류(이름)
	private String departureSt;  //출발역
	private String arriveSt;  //도착역
	private String departureTime;  //출발시간
	private String arriveTime;  //도착시간
	private String totalTime;  //소요시간
	
	public String getTotalTime() {
		return totalTime;
	}
	public void setTotalTime(String totalTime) {
		this.totalTime = totalTime;
	}
	public String getTrainCode() {
		return trainCode;
	}
	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
	}
	public String getTrainName() {
		return trainName;
	}
	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}
	public String getDepartureSt() {
		return departureSt;
	}
	public void setDepartureSt(String departureSt) {
		this.departureSt = departureSt;
	}
	public String getArriveSt() {
		return arriveSt;
	}
	public void setArriveSt(String arriveSt) {
		this.arriveSt = arriveSt;
	}
	public String getDepartureTime() {
		return departureTime;
	}
	public void setDepartureTime(String departureTime) {
		this.departureTime = departureTime;
	}
	public String getArriveTime() {
		return arriveTime;
	}
	public void setArriveTime(String arriveTime) {
		this.arriveTime = arriveTime;
	}
	
	
}
