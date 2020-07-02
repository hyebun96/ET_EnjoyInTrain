package com.et.reservation;

public class Condition {
	private String startSt;
	private String endSt;
	private String day;
	private String time;
	private String path;
	private int adult;
	private int child;
	private int senior;
	private int disabled1;
	private int disabled2;
	private String seat;
	private String seat2;
	private String tCategory;
	private int total;
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public String gettCategory() {
		return tCategory;
	}
	public void settCategory(String tCategory) {
		this.tCategory = tCategory;
	}
	private int route;
	
	public int getRoute() {
		return route;
	}
	public void setRoute(int route) {
		this.route = route;
	}
	public String getStartSt() {
		return startSt;
	}
	public void setStartSt(String startSt) {
		this.startSt = startSt;
	}
	public String getEndSt() {
		return endSt;
	}
	public void setEndSt(String endSt) {
		this.endSt = endSt;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public int getAdult() {
		return adult;
	}
	public void setAdult(int adult) {
		this.adult = adult;
	}
	public int getChild() {
		return child;
	}
	public void setChild(int child) {
		this.child = child;
	}
	public int getSenior() {
		return senior;
	}
	public void setSenior(int senior) {
		this.senior = senior;
	}
	public int getDisabled1() {
		return disabled1;
	}
	public void setDisabled1(int disabled1) {
		this.disabled1 = disabled1;
	}
	public int getDisabled2() {
		return disabled2;
	}
	public void setDisabled2(int disabled2) {
		this.disabled2 = disabled2;
	}
	public String getSeat() {
		return seat;
	}
	public void setSeat(String seat) {
		this.seat = seat;
	}
	public String getSeat2() {
		return seat2;
	}
	public void setSeat2(String seat2) {
		this.seat2 = seat2;
	}
}
