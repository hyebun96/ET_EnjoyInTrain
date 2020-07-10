package com.et.reservation;

public class Ticket {
	private int roomNum;  		//칸번호
	private String roomGrade;   //승객유
	private String seatNum; 	//좌석번호
	private String seatType;  //승객유형
	private int seatPay; 	//좌석 가격
	private int disCount; 	//할인금액
	private int point;
	
	private String trPrice;  	//결제금액
	private String trPayDate;  //결제날짜
	private String trDate;  	//예약날짜
	
	private String startCode;  //출발역*
	private String endCode;  //도착역*
	private String trainCode;  //기차코드*
	private String trainName;  //기차종류(이름)
	
	private String trCategory;  
	private String stTime;
	private String endTime;
	private int count;
	
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getRoomGrade() {
		return roomGrade;
	}
	public void setRoomGrade(String roomGrade) {
		this.roomGrade = roomGrade;
	}
	public String getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}
	public String getSeatType() {
		return seatType;
	}
	public void setSeatType(String seatType) {
		this.seatType = seatType;
	}
	public int getSeatPay() {
		return seatPay;
	}
	public void setSeatPay(int seatPay) {
		this.seatPay = seatPay;
	}
	public int getDisCount() {
		return disCount;
	}
	public void setDisCount(int disCount) {
		this.disCount = disCount;
	}
	public String getTrPrice() {
		return trPrice;
	}
	public void setTrPrice(String trPrice) {
		this.trPrice = trPrice;
	}
	public String getTrPayDate() {
		return trPayDate;
	}
	public void setTrPayDate(String trPayDate) {
		this.trPayDate = trPayDate;
	}
	public String getTrDate() {
		return trDate;
	}
	public void setTrDate(String trDate) {
		this.trDate = trDate;
	}
	public String getStartCode() {
		return startCode;
	}
	public void setStartCode(String startCode) {
		this.startCode = startCode;
	}
	public String getEndCode() {
		return endCode;
	}
	public void setEndCode(String endCode) {
		this.endCode = endCode;
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
	public String getTrCategory() {
		return trCategory;
	}
	public void setTrCategory(String trCategory) {
		this.trCategory = trCategory;
	}
	public String getStTime() {
		return stTime;
	}
	public void setStTime(String stTime) {
		this.stTime = stTime;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
}
