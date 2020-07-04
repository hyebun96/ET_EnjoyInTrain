package com.et.booking;

import java.util.List;
import java.util.Map;

import com.et.reservation.Condition;
import com.et.reservation.Seat;
import com.et.reservation.Train;

public interface BookingService {
	public int insertReservation(Booking dto) throws Exception;					// 예약 하기
	public List<Booking> readPromotionDetail(Map<String, Object> map);										// 프로모션 읽어오기
	public void deleteReservation(Map<String, Object> map) throws Exception;				// 예약 취소
	public List<Booking> listReservation();										// 예약 리스트(관리자 매출 관리 및 확인용)
	public List<Booking> readReservation(Map<String, Object> map);					// DB값 읽어 오기
	public Booking readCrew(Map<String, Object> map);							// 예약자 정보 불러오기
	public Booking readTrian(Map<String , Object> map);							// 기차 정보 불러오기
	public Booking readtrainlist(Booking dto);								// 하행선 읽어오기 
	public Seat readSeat(Map<String, String> map);
	public List<Seat> listSeat(String trainCategory);
	public int readsPay(Map<String, String> map);
	public List<Train> listTrain(Condition dto);
	public String totalTime(Train dto);
	public List<Booking> readForCancle(Map<String , Object> map);
	public String readStartStation(String Station);
	public String readEndStation(String Station);
}
