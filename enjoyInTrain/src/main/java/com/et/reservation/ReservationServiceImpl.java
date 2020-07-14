package com.et.reservation;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.Iterator;
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
			
//			Calendar cal=Calendar.getInstance();
//			SimpleDateFormat sdf=new SimpleDateFormat("YYYY/MM/DD(EE)");
//			dto.setToday(sdf.format(cal.getTime()));
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
	public void reservation(Reservation rv, ReservedSeat seat, Map<String,String> map, UnCrew unCrew) {
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
			if(unCrew.getName()==null) {  //회원일때
				dao.insertData("reservation.insertReservation", rv);
			}else {  //비회원일때
				dao.insertData("reservation.insertReservation2", rv);
			}
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
			
			//비회원일시 비회원정보테이블에 추가
			if(unCrew.getName()!=null) {  //비회원일시
				unCrew.setTrCode(trCode);
				dao.insertData("reservation.insertUnCrew", unCrew);
			}
			
			//회원일시 포인트 내역 추가
				//포인트 적립
			Map<String, Object> memberShip=new HashMap<>();
			if(unCrew.getName()==null) {
				//포인트시퀀스 가져오기
				int memberShipSeq=dao.selectOne("reservation.memberShipSeq");
				memberShip.put("memberShipSeq", memberShipSeq);
				memberShip.put("crewId", rv.getCrewId());
				memberShip.put("trCode", rv.getTrCode());
				memberShip.put("category", "적립");
				memberShip.put("point", (int)(rv.getTrPrice()*0.05));
				dao.insertData("reservation.memberShip", memberShip);
				
				//포인트 사용
				if(rv.getPoint()!=0) {
					memberShipSeq=dao.selectOne("reservation.memberShipSeq");
					memberShip.put("memberShipSeq", memberShipSeq);
					memberShip.put("category", "사용");
					memberShip.put("point", rv.getPoint());
					dao.insertData("reservation.memberShip", memberShip);
				}
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

	//예약되어있지 않은 좌석을 원하는 개수만큼 가져오기
	@Override
	public List<String> unReservedSeat(Map<String, String> map) {
		List<String> unList=new ArrayList<>();
		try {
			int total=Integer.parseInt(map.get("total"));
			
			//날짜(ex 2020/7/2(목))->2020/7/2 형식으로 바꿔줌
			String trDate=map.get("day");
			map.put("trDate", trDate.substring(0,trDate.length()-3));
			
			//해당 기차의 출발역과 도착역 각각의 lineOrder를 가져오기
			Map<String, Object> model=new HashMap<>();
			model=dao.selectOne("reservation.readStation", map.get("startSt"));
			map.put("stLineOrder", model.get("LINEORDER").toString());  //출발역 lineOrder
			model=dao.selectOne("reservation.readStation", map.get("endSt"));
			map.put("endLineOrder", model.get("LINEORDER").toString());  //도착역 lineOrder
			List<String> reSeatList=dao.selectList("reservation.listReservedSeat",map);
			
			map.put("tCategory", map.get("trainName"));
			Seat seat=dao.selectOne("reservation.readseat",map);  ///
			
			int row=seat.getSeatRow();
			int column=seat.getSeatColumn();
			for(int i=1; i<=row*column; i++) {
				String seatNum="";
				if(unList.size()<total) {  //인원수만큼 가져온다
					//해당 기차종류, 칸의 행 열값 이용해서 A1 이런식으로 좌석표시 바꿔줌
					if(i%column!=0) {
						seatNum+=Integer.toString(i%column);
						switch (i/column) {
						case 0: seatNum+="A"; break;
						case 1: seatNum+="B"; break;
						case 2: seatNum+="C"; break;
						case 3: seatNum+="D"; break;
						}
					}else {
						seatNum+=Integer.toString(1);
						switch (i/column) {
						case 1: seatNum+="A"; break;
						case 2: seatNum+="B"; break;
						case 3: seatNum+="C"; break;
						case 4: seatNum+="D"; break;
						}
					}
					
					//바꿔준 좌석이 이미 예약된 좌석에 있는지 확인
					int j=0;
					for(String reSeat:reSeatList) {
						if(seatNum.equals(reSeat)) {
							break;
						}else {
							j++;
						}
					}
					
					if(j==reSeatList.size()) {
						unList.add(seatNum);
					} 
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return unList;
	}

	//해당 아이디의 발권내역 가져오기
	@Override
	public List<Reservation> readDetail(String crewId) {
		List<Reservation> rsList=new ArrayList<>();
		try {
			List<Reservation> list=dao.selectList("reservation.readDetail", crewId);
			for(Reservation dto:list) {
				//총 예약 인원수 가져오기
				int cnt=dao.selectOne("reservation.readCount", dto.getTrCode());
				if(cnt==0) {
				}else {
					dto.setCount(cnt);
					Map<String, String> map=dao.selectOne("reservation.readStation",dto.getStartCode());
					String stStation=map.get("ENGNAME");
					map=dao.selectOne("reservation.readStation",dto.getEndCode());
					map.put("stStation", stStation);
					map.put("endStation", map.get("ENGNAME"));
					map.put("trainCode", dto.getTrainCode());
					map=dao.selectOne("reservation.readStatinTime", map);
					dto.setStTime(map.get("STTIME"));
					dto.setEndTime(map.get("ENDTIME"));
					rsList.add(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rsList;
	}

	@Override
	public List<Reservation> listReservationDetail(int trCode) {
		List<Reservation> list=null;
		try {
			list=dao.selectList("reservation.readReservationDetail", trCode);
			for(Reservation dto:list) {
				Map<String, String> map=dao.selectOne("reservation.readStation",dto.getStartCode());
				String stStation=map.get("ENGNAME");
				map=dao.selectOne("reservation.readStation",dto.getEndCode());
				map.put("stStation", stStation);
				map.put("endStation", map.get("ENGNAME"));
				map.put("trainCode", dto.getTrainCode());
				map=dao.selectOne("reservation.readStatinTime", map);
				dto.setStTime(map.get("STTIME"));
				dto.setEndTime(map.get("ENDTIME"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//할인종류 가져오기
	@Override
	public int readDisCount(String dcName) {
		int result=0;
		try {
			result=dao.selectOne("reservation.readDisCount", dcName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//해당 아이디의 총 포인트 조회
	@Override
	public int totalPoint(String crewId) {
		int result=0;
		try {
			result=dao.selectOne("reservation.totalPoint", crewId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Reservation> listSeatDetail(List<Integer> rsseatCode) {
		List<Reservation> list=new ArrayList<>();
		try {
			for(int code:rsseatCode) {
				Reservation dto=dao.selectOne("reservation.listSeatDetail", code);
				Map<String, String> map=dao.selectOne("reservation.readStation",dto.getStartCode());
				String stStation=map.get("ENGNAME");
				map=dao.selectOne("reservation.readStation",dto.getEndCode());
				map.put("stStation", stStation);
				map.put("endStation", map.get("ENGNAME"));
				map.put("trainCode", dto.getTrainCode());
				map=dao.selectOne("reservation.readStatinTime", map);
				dto.setStTime(map.get("STTIME"));
				dto.setEndTime(map.get("ENDTIME"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	//기차표 환불
	@Override
	public void refund(List<Integer> rsseatCode, int trCode, String crewId) {
		try {
			//총금액 가져오기
			int trPrice=dao.selectOne("reservation.readTotalPrice", trCode);
			
			//기차예약에 사용한 포인트금액 가져오기
			int trPointPrice=dao.selectOne("reservation.readTrPointPrice", trCode);
			int point=trPointPrice;
			
			//취소한좌석 금액 가져와서 총금액에서 빼기
			for(int code:rsseatCode) {
				int seatPay=dao.selectOne("reservation.readSeatPrice", code);
				
				if(trPrice-seatPay<0) {
					trPointPrice=trPointPrice-(seatPay-trPrice);
					trPrice=0;
				}else {
					trPrice=trPrice-seatPay;
				}
			}
			
			//계산된 총 금액, 사용포인트금액 수정해주기
			Map<String, Object> map=new HashMap<>();
			map.put("trPrice", trPrice);
			map.put("trCode", trCode);
			map.put("trPointPrice", trPointPrice);
			dao.updateData("reservation.updateTrPrice", map);
			
			for(int code:rsseatCode) {
				dao.updateData("reservation.refund", code);
			}
			
			//포인트 다시 환불
			if(point-trPointPrice!=0) {
				point=point-trPointPrice;
				int memberShipSeq=dao.selectOne("reservation.memberShipSeq");
				map.put("memberShipSeq", memberShipSeq);
				map.put("crewId", crewId);
				map.put("category", "환불");
				map.put("point", point);
				dao.insertData("reservation.memberShip", map);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//미고객 정보 조회
	@Override
	public int readUnCrew(UnCrew unCrew) {
		int result=0;
		try {
			unCrew.setTel(unCrew.getTel1()+"-"+unCrew.getTel2()+"-"+unCrew.getTel3());
			result=dao.selectOne("reservation.readUnCrew", unCrew);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	@Override
	public List<TrainTime> trainTime(String trainCode) {
		List<TrainTime> list=new ArrayList<>();
		try {
			Map<String, String> map=dao.selectOne("reservation.trainTime", trainCode);
			Iterator<String> keys=map.keySet().iterator();
			while(keys.hasNext()) {
				String key=keys.next();
				if(map.get(key)!=null) {
					TrainTime dto=new TrainTime();
					String station=key;
					station=dao.selectOne("reservation.readStationKR", station);
					dto.setStation(station);
					
					//도착시간구하기(출발시간에서 -2분)
					String deTime[]=map.get(key).split(":");
					Calendar cal=Calendar.getInstance();
					cal.set(Calendar.HOUR_OF_DAY, Integer.parseInt(deTime[0]));
					cal.set(Calendar.MINUTE, Integer.parseInt(deTime[1]));
					cal.add(Calendar.MINUTE, -2);
					SimpleDateFormat sdf=new SimpleDateFormat("HH:mm");
					dto.setArriveTime(sdf.format(cal.getTime()));

					dto.setDepartureTime(map.get(key));
					list.add(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<TrainPay> trainPay(Map<String, String> map) {
		List<TrainPay> list=new ArrayList<>();
		try {
			Map<String, String> st=null;
			String station=map.get("startCode");
			st=dao.selectOne("reservation.readStation", station);
			map.put("startCode", st.get("SCODE"));
			station=map.get("endCode");
			st=dao.selectOne("reservation.readStation", station);
			map.put("endCode", st.get("SCODE"));
			
			int seatPay=0;
			map.put("seatPay", "SEAT1");  //일반실
			seatPay=dao.selectOne("reservation.readsPay", map);
			TrainPay dto=dao.selectOne("reservation.trainPay", seatPay);
			dto.setRoomGrade("일반실");
			list.add(dto);
			
			map.put("seatPay", "SEAT2");  //특실
			seatPay=dao.selectOne("reservation.readsPay", map);
			dto=dao.selectOne("reservation.trainPay", seatPay);
			dto.setRoomGrade("특실");
			list.add(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	//admin페이지
	@Override
	public List<Reservation> listAll(Map<String, Object> map) {
		List<Reservation> list=null;
		try {
			list=dao.selectList("reservation.listAll",map);
			for(Reservation dto:list) {
				int count=dao.selectOne("reservation.seatCount",dto.getTrCode());
				dto.setCount(count);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Reservation> listAllSeat() {
		List<Reservation> seatList=null;
		try {
			seatList=dao.selectList("reservation.listAllSeat");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return seatList;
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("reservation.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
