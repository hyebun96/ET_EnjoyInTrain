package com.et.booking;

import java.util.List;

public interface BookingService {
	public void insertReservation(String code) throws Exception;				// 예약 하기
	public void updateReservation(String code) throws Exception;				// 예약 변경
	public void deleteReservation(String code) throws Exception;				// 예약 취소
	public List<Booking> listReservation();										// 예약 리스트(관리자 매출 관리 및 확인용)
	public Booking readReservation();											// DB값 읽어 오기
	
}
