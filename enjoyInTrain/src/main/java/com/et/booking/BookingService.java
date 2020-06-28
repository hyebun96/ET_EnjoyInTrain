package com.et.booking;

import java.util.List;
import java.util.Map;

public interface BookingService {
	public void insertReservation(Booking dto) throws Exception;				// 예약 하기
	public List<Booking> readPromotionDetail(Map<String, Object> map);										// 프로모션 읽어오기
	public void updateReservation(Booking dto) throws Exception;				// 예약 변경
	public void deleteReservation(String code) throws Exception;				// 예약 취소
	public List<Booking> listReservation();										// 예약 리스트(관리자 매출 관리 및 확인용)
	public Booking readReservation();											// DB값 읽어 오기
	public Booking readCrew(Map<String, Object> map);													// 예약자 정보 불러오기
	
	
}
