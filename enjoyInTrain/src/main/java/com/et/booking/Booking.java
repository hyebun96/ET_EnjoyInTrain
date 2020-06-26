package com.et.booking;

public class Booking {
	private int prCode;				// 상품코드 	ge
	private String pmCode;
	private String pmTitle;				// 프로모션 상품명
	private String pmDate;			// 프로모션 시작일(맵퍼에서 받아오지 않음) get
	private int pmPrice;				// 프로모션 가격
	private int pmMaxCount;				// 최대인원
	private String prGrade;				// 이용인원 구분(성인,유아 등등..) / 보류
	private int prPersonal; 				// 예약인원 get
	private String startTrain; 			// 기차명	get
	private String endTrain;			//		get
	
	// 가는 기차
	private String startStation;		// 출발하는 역 @	
	private String endStation;			// 출발하는 역 @	
	
	// 오는 기차
	private String startStation2;	// 출발하는 역 @	
	private String endStation2;		// 도착하는 역 @
	
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
	public int getPrCode() {
		return prCode;
	}
	public void setPrCode(int prCode) {
		this.prCode = prCode;
	}
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
	public String getPmDate() {
		return pmDate;
	}
	public void setPmDate(String pmDate) {
		this.pmDate = pmDate;
	}
	public int getPmPrice() {
		return pmPrice;
	}
	public void setPmPrice(int pmPrice) {
		this.pmPrice = pmPrice;
	}
	public int getPmMaxCount() {
		return pmMaxCount;
	}
	public void setPmMaxCount(int pmMaxCount) {
		this.pmMaxCount = pmMaxCount;
	}
	public String getPrGrade() {
		return prGrade;
	}
	public void setPrGrade(String prGrade) {
		this.prGrade = prGrade;
	}
	public int getPrPersonal() {
		return prPersonal;
	}
	public void setPrPersonal(int prPersonal) {
		this.prPersonal = prPersonal;
	}
	public String getStartTrain() {
		return startTrain;
	}
	public void setStartTrain(String startTrain) {
		this.startTrain = startTrain;
	}
	public String getEndTrain() {
		return endTrain;
	}
	public void setEndTrain(String endTrain) {
		this.endTrain = endTrain;
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
	public String getStartStation2() {
		return startStation2;
	}
	public void setStartStation2(String startStation2) {
		this.startStation2 = startStation2;
	}
	public String getEndStation2() {
		return endStation2;
	}
	public void setEndStation2(String endStation2) {
		this.endStation2 = endStation2;
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
