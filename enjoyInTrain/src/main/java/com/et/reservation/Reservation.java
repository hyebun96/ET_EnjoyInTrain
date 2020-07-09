package com.et.reservation;

public class Reservation {
	//trainreservation테이블
	private int trCode;  //기차예약코드*
	private int trPrice;  //결제금액
	private int trPointprice;  //포인트사용금액
	private String trPayDate;  //결제날짜
	private String trDate;  //예약날짜*
	private String crewId;  //아이디
	private int dcCode;  //개인할인코드
	
	//trreservation테이블
	private String startCode;  //출발역*
	private String endCode;  //도착역*
	private String trainCode;  //기차코드*
	
	//내역
	private String trCategory;
	private String stTime;
	private String endTime;
	private int count;
	
	private String seatType;
	private int roomNum;
	private String seatNum;
	private int rsseatCode;
	
	private int point;
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public int getRsseatCode() {
		return rsseatCode;
	}
	public void setRsseatCode(int rsseatCode) {
		this.rsseatCode = rsseatCode;
	}
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
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
	public String getTrCategory() {
		return trCategory;
	}
	public void setTrCategory(String trCategory) {
		this.trCategory = trCategory;
	}
	public int getTrCode() {
		return trCode;
	}
	public void setTrCode(int trCode) {
		this.trCode = trCode;
	}
	public int getTrPrice() {
		return trPrice;
	}
	public void setTrPrice(int trPrice) {
		this.trPrice = trPrice;
	}
	public int getTrPointprice() {
		return trPointprice;
	}
	public void setTrPointprice(int trPointprice) {
		this.trPointprice = trPointprice;
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
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public int getDcCode() {
		return dcCode;
	}
	public void setDcCode(int dcCode) {
		this.dcCode = dcCode;
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
	
}
