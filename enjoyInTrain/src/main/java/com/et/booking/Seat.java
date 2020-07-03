package com.et.booking;

public class Seat {
	private int roomNum;
	private String roomGrade;
	private int seatRow;
	private int seatColumn;
	
	//예약할시
	private String seatNum;  //좌석번호
	private String seatType;  //승객유형
	
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
	public int getSeatRow() {
		return seatRow;
	}
	public void setSeatRow(int seatRow) {
		this.seatRow = seatRow;
	}
	public int getSeatColumn() {
		return seatColumn;
	}
	public void setSeatColumn(int seatColumn) {
		this.seatColumn = seatColumn;
	}
}
