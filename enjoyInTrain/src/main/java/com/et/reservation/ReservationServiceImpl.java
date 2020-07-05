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
	public List<Seat> listSeat(Map<String, String> map) {
		List<Seat> list=null;
		try {
			list=dao.selectList("reservation.listSeat", map);
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

	@Override
	public void reservation(Reservation rv, ReservedSeat seat, Map<String,String> map) {
		try {
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=rv.getTrDate();
			rv.setTrDate(trDate.substring(0,trDate.length()-3));
			
			//시작역이름(ex 용산)->역 코드로 바꾸기
			Map<String, String> model;
			model=dao.selectOne("reservation.readStation", rv.getStartCode());
			rv.setStartCode(model.get("SCODE"));
			//도착역이름(ex 용산)->역 코드로 바꾸기
			model=dao.selectOne("reservation.readStation", rv.getEndCode());
			rv.setEndCode(model.get("SCODE"));
			
			//trainreservation 시퀀스 가져오기
			int trCode=dao.selectOne("reservation.trainreservationSeq");
			rv.setTrCode(trCode);
			
			//기차예약테이블에 저장
			dao.insertData("reservation.insertReservation", rv);
			//기차예약상세테이블에 저장
			dao.insertData("reservation.insertReservationInfo", rv);
			
			
			
			//예약된좌석 테이블에 저장
			int total=Integer.parseInt(map.get("total"));
			for(int i=1; i<=total; i++) {
				ReservedSeat rvSeat=new ReservedSeat();
				
				//reservedSeat 시퀀스 가져오기
				int rsSeatCode=dao.selectOne("reservation.reservedSeatSeq");
				
				rvSeat.setRsSeatCode(rsSeatCode);
				rvSeat.setSeatNum(map.get("seatNum"+i));
				rvSeat.setTrCode(trCode);
				rvSeat.setSeatType(map.get("seatType"+i));
				rvSeat.setSeatPay(Integer.parseInt(map.get("seatPay"+i)));
				rvSeat.setRoomNum(Integer.parseInt(map.get("roomNum")));
				rvSeat.setTrainCode(map.get("trainCode"));
				dao.insertData("reservation.insertReservedSeat", rvSeat);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//날짜, 기차코드, 칸번호에 해당하는 예약된 좌석 가져오기
	@Override
	public List<String> listReservedSeat(Map<String, String> map) {
		List<String> rvlist=new ArrayList<>();
		try {
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=map.get("day");
			map.put("trDate", trDate.substring(0,trDate.length()-3));
			
			//해당 기차의 출발역과 도착역 각각의 lineOrder를 가져오기
			Map<String, Object> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			map.put("stLineOrder", model.get("LINEORDER").toString());  //출발역 lineOrder
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			map.put("endLineOrder", model.get("LINEORDER").toString());  //도착역 lineOrder
			
			List<String> list=dao.selectList("reservation.listReservedSeat", map);
			
			//좌석번호(ex 10B -> 23) 이런식으로 바꿔줌
			for(String seat:list) {
				String column=seat.substring(0,seat.length()-1);
				String row=seat.substring(column.length());
				int rr=0;
				int cc=Integer.parseInt(map.get("seatColumn"));
				switch (row) {
					case "A": rr=0; break;
					case "B": rr=1; break;
					case "C": rr=2; break;
					case "D": rr=3; break;
				}
				int aa=Integer.parseInt(column)+(cc*rr);
				rvlist.add(Integer.toString(aa));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rvlist;
	}

	@Override
	public String roomFirst(Map<String, String> map) {
		String result="";
		try {
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=map.get("day");
			map.put("trDate", trDate.substring(0,trDate.length()-3));
			
			//해당 기차의 출발역과 도착역 각각의 lineOrder를 가져오기
			Map<String, Object> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			map.put("stLineOrder", model.get("LINEORDER").toString());  //출발역 lineOrder
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			map.put("endLineOrder", model.get("LINEORDER").toString());  //도착역 lineOrder
			
			//좌석 정원초과인 칸 가져오기
			List<String> fullList=dao.selectList("reservation.fullSeat", map);
			//일반실 혹은 특실의 모든 칸 가져오기
			List<String> roomList=dao.selectList("reservation.readRoom", map);
			
			for(String room:roomList) {
				int i;
				for(i=0; i<fullList.size(); i++) {
					if(room.equals(fullList.get(i))) {
						break;
					}
				}
				//모든 정원초과 칸과 같지 않으면 맵에 저장
				if(i==fullList.size()) {
					result=room;
					return result;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//정원초과인 칸 가져오기
	@Override
	public List<Integer> fullSeat(Map<String, String> map) {
		List<Integer> fullSeatlist=null;
		try {
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=map.get("day");
			map.put("trDate", trDate.substring(0,trDate.length()-3));
			
			//해당 기차의 출발역과 도착역 각각의 lineOrder를 가져오기
			Map<String, Object> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			map.put("stLineOrder", model.get("LINEORDER").toString());  //출발역 lineOrder
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			map.put("endLineOrder", model.get("LINEORDER").toString());  //도착역 lineOrder
			
			fullSeatlist=dao.selectList("reservation.fullSeat", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fullSeatlist;
	}

	//모든 칸이 정원초과인 기차코드 가져오기(일반실, 특실 따로 가져와야함)
	@Override
	public List<Integer> fulltrCode(Map<String, String> map) {
		List<Integer> fulltrCode=null;
		try {
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=map.get("day");
			map.put("trDate", trDate.substring(0,trDate.length()-3));
			
			//하행인지 상행인지 가져오기. 리스트는 하행기준으로 역이름을 가져오므로 
				//넘겨준 출발역이 리스트의 첫번째역과 같으면 하행, 같지 않으면 상행
			List<String> route=dao.selectList("reservation.searchRoute", map); //
			if(route.get(0).equals(map.get("startSt"))) {
				map.put("route", "1");  //하행
			}else {
				map.put("route", "0");	//상행
			}
			
			//해당 기차의 출발역과 도착역 각각의 lineOrder를 가져오기
			Map<String, Object> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			map.put("stLineOrder", model.get("LINEORDER").toString());  //출발역 lineOrder
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			map.put("endLineOrder", model.get("LINEORDER").toString());  //도착역 lineOrder
			
			fulltrCode=dao.selectList("reservation.fulltrCode", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return fulltrCode;
	}
}
