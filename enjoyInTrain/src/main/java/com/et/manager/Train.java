package com.et.manager;

public class Train {
	private String trainCode;					// 기차코드
	private String trainName;					// 기차명
	private String seatCode;					// 좌석 코드
	private String romCode;						// 칸 코드
	
	public String getSeatCode() {
		return seatCode;
	}
	public void setSeatCode(String seatCode) {
		this.seatCode = seatCode;
	}
	public String getRomCode() {
		return romCode;
	}
	public void setRomCode(String romCode) {
		this.romCode = romCode;
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
	
	
}
