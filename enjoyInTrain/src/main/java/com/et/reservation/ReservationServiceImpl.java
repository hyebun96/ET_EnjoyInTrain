package com.et.reservation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("reservation.reservationService")
public class ReservationServiceImpl implements ReservationService{

	@Autowired
	private CommonDAO dao;
	
	//모든 역 가져오기
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

	//조건에 해당하는 기차목록 가져오기
	@Override
	public List<Train> listTrain(Condition dto) {
		List<Train> list=new ArrayList<>();
		try {
			//하행인지 상행인지 가져오기. 리스트는 하행기준으로 역이름을 가져오므로 
				//넘겨준 출발역이 리스트의 첫번째역과 같으면 하행, 같지 않으면 상행
			List<String> route=dao.selectList("reservation.searchRoute", dto); //
			if(route.get(0).equals(dto.getStartSt())) {
				dto.setRoute(1);  //기차코드가 홀수이면 하행이고 짝수이면 상행이다.
			}else {
				dto.setRoute(0);
			}
			String originalnameSt=dto.getStartSt();
			String originalnameEnd=dto.getEndSt();
			
			//영어역이름 가져오기
			Map<String, String> stmap=new HashMap<>();  //쿼리결과 가져와서 담는 맵
			
			String station=dto.getStartSt();
			stmap=dao.selectOne("reservation.readStation",station);
			String startSt=stmap.get("ENGNAME");
			
			station=dto.getEndSt();
			stmap=dao.selectOne("reservation.readStation",station);
			String endSt=stmap.get("ENGNAME");
			
			dto.setStartSt(startSt);
			dto.setEndSt(endSt);
			list=dao.selectList("reservation.listTrain", dto);
			for(Train tr:list) {
				tr.setDepartureSt(originalnameSt);
				tr.setArriveSt(originalnameEnd);
			}
			dto.setStartSt(originalnameSt);
			dto.setEndSt(originalnameEnd);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//예약 첫화면에 기본 출발지, 도착지 넣어주기 위해
	@Override
	public Map<String, String> defaultSt() {
		Map<String, String> map=null;
		try {
			map=new HashMap<String, String>();
			String firstSt=dao.selectOne("reservation.firstSt");
			String lastSt=dao.selectOne("reservation.lastSt");
			
			map.put("firstSt", firstSt);
			map.put("lastSt", lastSt);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return map;
	}

	//소요시간 계산
	@Override
	public String totalTime(Train dto) {
		String totalTime="";
		try {
			int time=dao.selectOne("reservation.totalTime", dto);
			String h=(time/60)<10?"0"+Integer.toString(time/60):Integer.toString(time/60);
			String m=(time%60)<10?"0"+Integer.toString(time%60):Integer.toString(time%60);
			totalTime=h+":"+m;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return totalTime;
	}

	//좌석 가져오기
	@Override
	public Seat readSeat(Map<String, String> map) {
		Seat seat=null;
		try {
			seat=dao.selectOne("reservation.readseat", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return seat;
	}

	//선택한 기차의 총 호실 정보 가져오기
	@Override
	public List<Seat> listSeat(String tCategory) {
		List<Seat> list=null;
		try {
			
			list=dao.selectList("reservation.listSeat", tCategory);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//좌석가격 가져오기
	@Override
	public int readsPay(Map<String, String> map) {
		int result=0;
		try {
			Map<String, String> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			String startCode=model.get("SCODE");
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			String endCode=model.get("SCODE");
			
			int trainCode=Integer.parseInt(map.get("trainCode"));
			if(trainCode%2==1) {  //기차코드가 홀수->하행선일 경우
				model.put("startCode", startCode);
				model.put("endCode", endCode);
			}else {  //기차코드가 짝수->상행선일 경우
				model.put("startCode", endCode);
				model.put("endCode", startCode);
			}
			
			model.put("trainCategory", map.get("tCategory"));
			if(map.get("roomGrade").equals("일반실")) {
				model.put("seatPay", "SEAT1");
			}else {
				model.put("seatPay", "SEAT2");
			}
			
			result=dao.selectOne("reservation.readsPay", model);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

}
