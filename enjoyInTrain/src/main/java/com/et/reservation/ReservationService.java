package com.et.reservation;

import java.util.List;
import java.util.Map;

public interface ReservationService {
	public List<Station> listStation();
	public List<Train> listTrain(Condition dto);
	public Map<String, String> defaultSt();
	public String totalTime(Train dto);
	public Seat readSeat(Map<String, String> map);
	public List<Seat> listSeat(Map<String, String> map);
	public int readsPay(Map<String, String> map);
	public void reservation(Reservation rv, ReservedSeat seat, Map<String,String> map);
	public List<String> listReservedSeat(Map<String, String> map);
	public int spRoomFirst(String tCategory);
	public List<Integer> fullSeat(Map<String, String> map);
	public List<Integer> fulltrCode(Map<String, String> map);
}
