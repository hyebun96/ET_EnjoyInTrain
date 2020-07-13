package com.et.booking;

public class Booking {
	// 프로모션 정보
	private int rsSeatCode;				// 예약 좌석 시퀀스
	private int trCode; 				// 기차시퀀스 코드 
	private int prCode;
	private int prSeq;					// 예약코드  
	private String pmCode;				// 프로모션 상품코드
	private String pmTitle;				// 프로모션 상품명
	private String pmStartDate;			// 프로모션 예약 시작 날짜
	private String pmEndDate;			// 프로모션 예약 종료 날짜
	private int pmPrice;				// 프로모션 가격

	// 프로모션 이용 인원
	private int adult;					// 성인
	private int adult1;					// 성인
	private int child;					// 유아
	private int child1;					// 유아
	private int oldMan;					// 경로
	private int oldMan1;				// 경로
	private int prPersonnel; 			// 예약인원 get
	private String seatType;
	
	// 가는 기차 & 오는 기차
	private String trainName;			// 가는 기차명
	private String trainName1;			// 오는 기차명
	private String trainCode;			// 가는 기차 코드 (받아오기)
	private String trainCode1;			// 오는 기차 코드 (받아오기)
	private String startCode;			// 가는 역 코드
	private String startTrain; 			// 가는 기차코드	
	private String startTime;			// 가는 기차 시간
	private String endCode;				// 오는 역 코드
	private String endTrain;			// 오는 기차코드	
	private String endTime;				// 오는 기차 시간
	private String startStation;		// 출발하는 역 @	
	private String startStation1;		// 출발하는 역 @	
	private String roomGrade;			// 객실등급
	private int roomNum;
	private int prStartRoom;			// 가는 기차 칸번호
	private String prStartTrainSeat;	// 출발역 좌석
	private String endStation;			// 출발하는 역 @
	private String endStation1;			// 출발하는 역 @
	private String prEndTrainSeat;		// 도착역 좌석
	private String prTrainSeat;
	private int prEndRoom;				// 오는 기차 칸번호
	private String seatNum;			// 좌석
	private String roomGrade1;
	private int prAddPrice;				// 객실등급에 따라 추가금액
	private int prAddPrice1;				// 객실등급에 따라 추가금액

	// 프로모션 상품
	private String product;				// 프로모션 상품
	private String productContent;		// 프로모션 상품 설명
	private String productUserCount;	// 프로모션 상품 이용인원
	
	// 예약자
	private String crewId;				// 회원 아이디
	private String crewName;			// 예약자 이름
	private String crewEmail;			// 예약자 이메일
	private String crewTel;				// 예약자 전화번호
	private String crewBirth;			// 예약자 생년월일
	private String prReservationDate;	// 예약한 날
	private int prpayment;				// 결제 유무
	private String reservationNumber;	// 예약번호
	private String prPaymentDate;		// 결제한 날
	
	// 리스트
	private int listNum;

	public int getRsSeatCode() {
		return rsSeatCode;
	}

	public void setRsSeatCode(int rsSeatCode) {
		this.rsSeatCode = rsSeatCode;
	}

	public int getTrCode() {
		return trCode;
	}

	public void setTrCode(int trCode) {
		this.trCode = trCode;
	}

	public int getPrCode() {
		return prCode;
	}

	public void setPrCode(int prCode) {
		this.prCode = prCode;
	}

	public int getPrSeq() {
		return prSeq;
	}

	public void setPrSeq(int prSeq) {
		this.prSeq = prSeq;
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

	public int getPmPrice() {
		return pmPrice;
	}

	public void setPmPrice(int pmPrice) {
		this.pmPrice = pmPrice;
	}

	public int getAdult() {
		return adult;
	}

	public void setAdult(int adult) {
		this.adult = adult;
	}

	public int getAdult1() {
		return adult1;
	}

	public void setAdult1(int adult1) {
		this.adult1 = adult1;
	}

	public int getChild() {
		return child;
	}

	public void setChild(int child) {
		this.child = child;
	}

	public int getChild1() {
		return child1;
	}

	public void setChild1(int child1) {
		this.child1 = child1;
	}

	public int getOldMan() {
		return oldMan;
	}

	public void setOldMan(int oldMan) {
		this.oldMan = oldMan;
	}

	public int getOldMan1() {
		return oldMan1;
	}

	public void setOldMan1(int oldMan1) {
		this.oldMan1 = oldMan1;
	}

	public int getPrPersonnel() {
		return prPersonnel;
	}

	public void setPrPersonnel(int prPersonnel) {
		this.prPersonnel = prPersonnel;
	}

	public String getSeatType() {
		return seatType;
	}

	public void setSeatType(String seatType) {
		this.seatType = seatType;
	}

	public String getTrainName() {
		return trainName;
	}

	public void setTrainName(String trainName) {
		this.trainName = trainName;
	}

	public String getTrainName1() {
		return trainName1;
	}

	public void setTrainName1(String trainName1) {
		this.trainName1 = trainName1;
	}

	public String getTrainCode() {
		return trainCode;
	}

	public void setTrainCode(String trainCode) {
		this.trainCode = trainCode;
	}

	public String getTrainCode1() {
		return trainCode1;
	}

	public void setTrainCode1(String trainCode1) {
		this.trainCode1 = trainCode1;
	}

	public String getStartCode() {
		return startCode;
	}

	public void setStartCode(String startCode) {
		this.startCode = startCode;
	}

	public String getStartTrain() {
		return startTrain;
	}

	public void setStartTrain(String startTrain) {
		this.startTrain = startTrain;
	}

	public String getStartTime() {
		return startTime;
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndCode() {
		return endCode;
	}

	public void setEndCode(String endCode) {
		this.endCode = endCode;
	}

	public String getEndTrain() {
		return endTrain;
	}

	public void setEndTrain(String endTrain) {
		this.endTrain = endTrain;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getStartStation() {
		return startStation;
	}

	public void setStartStation(String startStation) {
		this.startStation = startStation;
	}

	public String getStartStation1() {
		return startStation1;
	}

	public void setStartStation1(String startStation1) {
		this.startStation1 = startStation1;
	}

	public String getRoomGrade() {
		return roomGrade;
	}

	public void setRoomGrade(String roomGrade) {
		this.roomGrade = roomGrade;
	}

	public int getRoomNum() {
		return roomNum;
	}

	public void setRoomNum(int roomNum) {
		this.roomNum = roomNum;
	}

	public int getPrStartRoom() {
		return prStartRoom;
	}

	public void setPrStartRoom(int prStartRoom) {
		this.prStartRoom = prStartRoom;
	}

	public String getPrStartTrainSeat() {
		return prStartTrainSeat;
	}

	public void setPrStartTrainSeat(String prStartTrainSeat) {
		this.prStartTrainSeat = prStartTrainSeat;
	}

	public String getEndStation() {
		return endStation;
	}

	public void setEndStation(String endStation) {
		this.endStation = endStation;
	}

	public String getEndStation1() {
		return endStation1;
	}

	public void setEndStation1(String endStation1) {
		this.endStation1 = endStation1;
	}

	public String getPrEndTrainSeat() {
		return prEndTrainSeat;
	}

	public void setPrEndTrainSeat(String prEndTrainSeat) {
		this.prEndTrainSeat = prEndTrainSeat;
	}

	public String getPrTrainSeat() {
		return prTrainSeat;
	}

	public void setPrTrainSeat(String prTrainSeat) {
		this.prTrainSeat = prTrainSeat;
	}

	public int getPrEndRoom() {
		return prEndRoom;
	}

	public void setPrEndRoom(int prEndRoom) {
		this.prEndRoom = prEndRoom;
	}

	public String getSeatNum() {
		return seatNum;
	}

	public void setSeatNum(String seatNum) {
		this.seatNum = seatNum;
	}

	public String getRoomGrade1() {
		return roomGrade1;
	}

	public void setRoomGrade1(String roomGrade1) {
		this.roomGrade1 = roomGrade1;
	}

	public int getPrAddPrice() {
		return prAddPrice;
	}

	public void setPrAddPrice(int prAddPrice) {
		this.prAddPrice = prAddPrice;
	}

	public int getPrAddPrice1() {
		return prAddPrice1;
	}

	public void setPrAddPrice1(int prAddPrice1) {
		this.prAddPrice1 = prAddPrice1;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getProductContent() {
		return productContent;
	}

	public void setProductContent(String productContent) {
		this.productContent = productContent;
	}

	public String getProductUserCount() {
		return productUserCount;
	}

	public void setProductUserCount(String productUserCount) {
		this.productUserCount = productUserCount;
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

	public String getPrReservationDate() {
		return prReservationDate;
	}

	public void setPrReservationDate(String prReservationDate) {
		this.prReservationDate = prReservationDate;
	}

	public int getPrpayment() {
		return prpayment;
	}

	public void setPrpayment(int prpayment) {
		this.prpayment = prpayment;
	}

	public String getReservationNumber() {
		return reservationNumber;
	}

	public void setReservationNumber(String reservationNumber) {
		this.reservationNumber = reservationNumber;
	}

	public String getPrPaymentDate() {
		return prPaymentDate;
	}

	public void setPrPaymentDate(String prPaymentDate) {
		this.prPaymentDate = prPaymentDate;
	}

	public int getListNum() {
		return listNum;
	}

	public void setListNum(int listNum) {
		this.listNum = listNum;
	}


}