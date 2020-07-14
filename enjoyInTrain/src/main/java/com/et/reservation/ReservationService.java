package com.et.reservation;

import java.util.List;
import java.util.Map;

public interface ReservationService {
	public int readDisCount(String dcName);
	public List<Station> listStation();
	public List<Train> listTrain(Condition dto);
	public Map<String, String> defaultSt();
	public String totalTime(Train dto);
	public Seat readSeat(Map<String, String> map);
	public List<Seat> listSeat(Map<String, String> map);
	public int readsPay(Map<String, String> map);
	public void reservation(Reservation rv, ReservedSeat seat, Map<String,String> map, UnCrew unCrew);
	public List<String> listReservedSeat(Map<String, String> map);
	public String roomFirst(Map<String, String> map);
	public List<Integer> fullSeat(Map<String, String> map);
	public List<Integer> fulltrCode(Map<String, String> map);
	public List<String> unReservedSeat(Map<String, String> map);
	public List<Reservation> readDetail(String crewId);
	public List<Reservation> listReservationDetail(int trCode);
	public List<Reservation> listSeatDetail(List<Integer> rsseatCode);
	public void refund(List<Integer> rsseatCode, int trCode, String crewId);
	public int totalPoint(String crewId);
	public int readUnCrew(UnCrew unCrew);
	public List<TrainTime> trainTime(String trainCode);
	public List<TrainPay> trainPay(Map<String, String> map);
	//admin페이지
	public List<Reservation> listAll(Map<String, Object> map);
	public List<Reservation> listAllSeat();
	
	//페이징
	public int dataCount();
}
