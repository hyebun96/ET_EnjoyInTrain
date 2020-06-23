package com.et.booking;

public class Booking {
	private String pmCode;			// 상품코드
	private String pmTitle;			// 상품명
	private String pmStartDate;		// 시작일
	private String pmEndDate;		// 종료일
	private int pmMaxCount;			// 최대인원
	private String pmGrade;			// 이용인원 구분(성인,유아 등등..)
	private int pmCount; 			// 예약인원
	private String pmTrainName; 	// 기차명
	private String pmStartStation;	// 출발역
	private String pmEndStation;	// 도착역
	private String pmSeatGrade;		// 객실등급
	private String pmSeat;			// 좌석
	private String crewId;			// 회원 아이디
	private String crewName;		// 회원 이름
	private String crewEmail;		// 회원 이메일
	private String crewTel;			// 회원 전화번호
	private String crewBirth;		// 회원 생년월일
	private int check;				// 약관동의
	private String paymentDate;		// 결제기한일
	
	public String getPmCode() {
		return pmCode;
	}
	public void setPmCode(String pmCode) {
		this.pmCode = pmCode;
	}
	public String getPmTitle() {
		return pmTitle;
	}
	public void setPmTitle(String pmTitle) {
		this.pmTitle = pmTitle;
	}
	public String getPmStartDate() {
		return pmStartDate;
	}
	public void setPmStartDate(String pmStartDate) {
		this.pmStartDate = pmStartDate;
	}
	public String getPmEndDate() {
		return pmEndDate;
	}
	public void setPmEndDate(String pmEndDate) {
		this.pmEndDate = pmEndDate;
	}
	public int getPmMaxCount() {
		return pmMaxCount;
	}
	public void setPmMaxCount(int pmMaxCount) {
		this.pmMaxCount = pmMaxCount;
	}
	public String getPmGrade() {
		return pmGrade;
	}
	public void setPmGrade(String pmGrade) {
		this.pmGrade = pmGrade;
	}
	public int getPmCount() {
		return pmCount;
	}
	public void setPmCount(int pmCount) {
		this.pmCount = pmCount;
	}
	public String getPmTrainName() {
		return pmTrainName;
	}
	public void setPmTrainName(String pmTrainName) {
		this.pmTrainName = pmTrainName;
	}
	public String getPmStartStation() {
		return pmStartStation;
	}
	public void setPmStartStation(String pmStartStation) {
		this.pmStartStation = pmStartStation;
	}
	public String getPmEndStation() {
		return pmEndStation;
	}
	public void setPmEndStation(String pmEndStation) {
		this.pmEndStation = pmEndStation;
	}
	public String getPmSeatGrade() {
		return pmSeatGrade;
	}
	public void setPmSeatGrade(String pmSeatGrade) {
		this.pmSeatGrade = pmSeatGrade;
	}
	public String getPmSeat() {
		return pmSeat;
	}
	public void setPmSeat(String pmSeat) {
		this.pmSeat = pmSeat;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public String getCrewName() {
		return crewName;
	}
	public void setCrewName(String crewName) {
		this.crewName = crewName;
	}
	public String getCrewEmail() {
		return crewEmail;
	}
	public void setCrewEmail(String crewEmail) {
		this.crewEmail = crewEmail;
	}
	public String getCrewTel() {
		return crewTel;
	}
	public void setCrewTel(String crewTel) {
		this.crewTel = crewTel;
	}
	public String getCrewBirth() {
		return crewBirth;
	}
	public void setCrewBirth(String crewBirth) {
		this.crewBirth = crewBirth;
	}
	public int getCheck() {
		return check;
	}
	public void setCheck(int check) {
		this.check = check;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	
}
