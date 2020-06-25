package com.et.booking;

public class Booking {
	private String prCode;				// 상품코드
	private String prTitle;				// 상품명
	private String prStartDate;			// 시작일
	private String prEndDate;			// 종료일
	private int prMaxCount;				// 최대인원
	private String prGrade;				// 이용인원 구분(성인,유아 등등..) / 보류
	private int prCount; 				// 예약인원
	private String prTrainName; 		// 기차명
	private String prStartStation;		// 출발역
	private String prEndStation;		// 도착역
	private String prSeatGrade;			// 객실등급
	private String prStartTrainSeat;	// 출발역 좌석
	private String prEndTrainSeat;		// 도착역 좌석
	private String crewId;				// 회원 아이디
	private String UserName;			// 예약자 이름
	private String UserEmail;			// 예약자 이메일
	private String email1;			
	private String email2;
	private String UserTel;				// 예약자 전화번호
	private String tel1;
	private String tel2;
	private String tel3;
	private String UserBirth;			// 예약자 생년월일
	private String paymentDate;			// 결제기한일
	private int payment;				// 결제 유무
	
	public String getPrCode() {
		return prCode;
	}
	public void setPrCode(String prCode) {
		this.prCode = prCode;
	}
	public String getPrTitle() {
		return prTitle;
	}
	public void setPrTitle(String prTitle) {
		this.prTitle = prTitle;
	}
	public String getPrStartDate() {
		return prStartDate;
	}
	public void setPrStartDate(String prStartDate) {
		this.prStartDate = prStartDate;
	}
	public String getPrEndDate() {
		return prEndDate;
	}
	public void setPrEndDate(String prEndDate) {
		this.prEndDate = prEndDate;
	}
	public int getPrMaxCount() {
		return prMaxCount;
	}
	public void setPrMaxCount(int prMaxCount) {
		this.prMaxCount = prMaxCount;
	}
	public String getPrGrade() {
		return prGrade;
	}
	public void setPrGrade(String prGrade) {
		this.prGrade = prGrade;
	}
	public int getPrCount() {
		return prCount;
	}
	public void setPrCount(int prCount) {
		this.prCount = prCount;
	}
	public String getPrTrainName() {
		return prTrainName;
	}
	public void setPrTrainName(String prTrainName) {
		this.prTrainName = prTrainName;
	}
	public String getPrStartStation() {
		return prStartStation;
	}
	public void setPrStartStation(String prStartStation) {
		this.prStartStation = prStartStation;
	}
	public String getPrEndStation() {
		return prEndStation;
	}
	public void setPrEndStation(String prEndStation) {
		this.prEndStation = prEndStation;
	}
	public String getPrSeatGrade() {
		return prSeatGrade;
	}
	public void setPrSeatGrade(String prSeatGrade) {
		this.prSeatGrade = prSeatGrade;
	}
	public String getPrStartTrainSeat() {
		return prStartTrainSeat;
	}
	public void setPrStartTrainSeat(String prStartTrainSeat) {
		this.prStartTrainSeat = prStartTrainSeat;
	}
	public String getPrEndTrainSeat() {
		return prEndTrainSeat;
	}
	public void setPrEndTrainSeat(String prEndTrainSeat) {
		this.prEndTrainSeat = prEndTrainSeat;
	}
	public String getCrewId() {
		return crewId;
	}
	public void setCrewId(String crewId) {
		this.crewId = crewId;
	}
	public String getUserName() {
		return UserName;
	}
	public void setUserName(String userName) {
		UserName = userName;
	}
	public String getUserEmail() {
		return UserEmail;
	}
	public void setUserEmail(String userEmail) {
		UserEmail = userEmail;
	}
	public String getEmail1() {
		return email1;
	}
	public void setEmail1(String email1) {
		this.email1 = email1;
	}
	public String getEmail2() {
		return email2;
	}
	public void setEmail2(String email2) {
		this.email2 = email2;
	}
	public String getUserTel() {
		return UserTel;
	}
	public void setUserTel(String userTel) {
		UserTel = userTel;
	}
	public String getTel1() {
		return tel1;
	}
	public void setTel1(String tel1) {
		this.tel1 = tel1;
	}
	public String getTel2() {
		return tel2;
	}
	public void setTel2(String tel2) {
		this.tel2 = tel2;
	}
	public String getTel3() {
		return tel3;
	}
	public void setTel3(String tel3) {
		this.tel3 = tel3;
	}
	public String getUserBirth() {
		return UserBirth;
	}
	public void setUserBirth(String userBirth) {
		UserBirth = userBirth;
	}
	public String getPaymentDate() {
		return paymentDate;
	}
	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}
	public int getPayment() {
		return payment;
	}
	public void setPayment(int payment) {
		this.payment = payment;
	}
	
}
