package com.et.reservation;

public class ReservedSeat {
	private int rsSeatCode;  //예약좌석코드(시퀀스)
	private String seatNum;  //좌석번호
	private int trCode;  //기차예약번호
	private String seatType;  //승객유형
	private int seatPay;  //좌석 가격
	private int roomNum;  //칸번호
	private String trainCode;  //기차코드
	private int disCount;	//할인금액
	public int getDisCount() {
		return disCount;
	}
	public void setDisCount(int disCount) {
		this.disCount = disCount;
	}
	public int getRsSeatCode() {
		return rsSeatCode;
	}
	public void setRsSeatCode(int rsSeatCode) {
		this.rsSeatCode = rsSeatCode;
	}
	public String getSeatNum() {
		return seatNum;
	}
	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}
	public int getTrCode() {
		return trCode;
	}
	public void setTrCode(int trCode) {
		this.trCode = trCode;
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
	public int getRoomNum() {
		return roomNum;
	}
	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}
	public String getTrainCode() {
		return trainCode;
	}
	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
	}
	
}
