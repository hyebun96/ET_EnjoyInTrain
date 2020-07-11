package com.et.admin.trainsales;

public class TrainSales {
	private String trDate; //예약 날짜
	private String trPayDate;  //결제 날짜
	private int disCount; //할인금액
	private int count; //발급건수
	private int seatPay; //좌석금액(할인금액적용됨)
	
	public String getTrDate() {
		return trDate;
	}
	public void setTrDate(String trDate) {
		this.trDate = trDate;
	}
	public String getTrPayDate() {
		return trPayDate;
	}
	public void setTrPayDate(String trPayDate) {
		this.trPayDate = trPayDate;
	}
	public int getDisCount() {
		return disCount;
	}
	public void setDisCount(int disCount) {
		this.disCount = disCount;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getSeatPay() {
		return seatPay;
	}
	public void setSeatPay(int seatPay) {
		this.seatPay = seatPay;
	}
	
	
}
