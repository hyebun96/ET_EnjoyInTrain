package com.et.reservation;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("reservation.reservationService")
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<Station> listStation() {
		List<Station> list=null;
		try {
			list=dao.selectList("reservation.listStation");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

}
