package com.et.booking;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("booking.bookingService")
public class BookingServiceImpl implements BookingService{
	
	@Autowired
	private CommonDAO dao;

	@Override
	public int insertReservation(Booking dto) throws Exception {
		int seq = 0;
		String reservationNumber = null;
		try {
			seq = dao.selectOne("booking.seq");
			dto.setPrCode(seq);
			reservationNumber = dao.selectOne("booking.reservationNumber");
			dto.setReservationNumber(reservationNumber);
			dao.insertData("booking.insertReservation", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return seq;
	}

	@Override
	public List<Booking> readPromotionDetail(Map<String, Object> map) {
		List<Booking> list = null;
		try {
			list = dao.selectList("booking.readTravel", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public void updateReservation(Booking dto) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteReservation(String code) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public List<Booking> listReservation() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Booking readReservation(Map<String, Object> map) {
		Booking dto = null;
		try {
			dto = dao.selectOne("booking.readReservation", map);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return dto;
	}

	@Override
	public Booking readCrew(Map<String, Object> map) {
		Booking dto = null;
		try {
			dto=dao.selectOne("booking.readCrew", map);
		} catch (Exception e) {
		}
		return dto;
	}


}
