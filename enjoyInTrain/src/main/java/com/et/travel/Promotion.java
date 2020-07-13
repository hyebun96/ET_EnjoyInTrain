package com.et.travel;

public class Promotion {
	private String pmCode;		// 프로모션코드
	private String trainCode;	// 기차 코드
	private String trainName;	// 기차 이름
	private String startStation;	// 출발역
	private String endStation;		// 도착역
	private String startTime;		// 출발역시간
	private String endTime;			// 도착역시간
	
	private int pmCount;			// 남은 좌석 수
	private String reservationDate;
	
	public String getPmCode() {
		return pmCode;
	}
	public void setPmCode(String pmCode) {
		this.pmCode = pmCode;
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
	public String getStartStation() {
		return startStation;
	}
	public void setStartStation(String startStation) {
		this.startStation = startStation;
	}
	public String getEndStation() {
		return endStation;
	}
	public void setEndStation(String endStation) {
		this.endStation = endStation;
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
	public int getPmCount() {
		return pmCount;
	}
	public void setPmCount(int pmCount) {
		this.pmCount = pmCount;
	}
	public String getReservationDate() {
		return reservationDate;
	}
	public void setReservationDate(String reservationDate) {
		this.reservationDate = reservationDate;
	}
	
	
}
