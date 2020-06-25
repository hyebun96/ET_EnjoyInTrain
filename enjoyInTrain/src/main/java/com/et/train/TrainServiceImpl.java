package com.et.train;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("manager.trainService")
public class TrainServiceImpl implements TrainService{

	@Autowired
	private CommonDAO dao;

	@Override
	public void insertTrain(Train dto) {
		try {
			dao.insertData("train.insertTrain", dto);
			
			int total=0;
			if(dto.getRoomNames()!=null) {
				for(int i=0; i<dto.getRoomNums().size(); i++) {
					dto.setRoomNum(dto.getRoomNums().get(i));
					dto.setRoomGrade(dto.getRoomNames().get(i));
					dto.setSeatRow(dto.getSeatRows().get(i));
					dto.setSeatColumn(dto.getSeatColumns().get(i));
					insertRoom(dto);
					total+=dto.getSeatRow()*dto.getSeatColumn();
				}
				dto.setTrainSeatCount(total);
				totalSeatCount(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public Train readTrain(String code) {
		Train dto = null;
		try {
			dto = dao.selectOne("train.readTrain", code);
		} catch (Exception e) {
		}
		return dto;
	}

	@Override
	public List<Train> listTrain(Map<String, Object> map) {
		List<Train> list = null;
		try {
			list = dao.selectList("train.listTrain", map);
		} catch (Exception e) {
		}
		return list;
	}

	@Override
	public int trainCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("train.trainCount");
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return result;
	}

	@Override
	public void insertRoom(Train dto) {
		try {
			dao.insertData("train.insertRoom", dto);
		} catch (Exception e) {
		}
		
	}

	@Override
	public void totalSeatCount(Train dto) {
		try {
			dao.updateData("train.totalSeatCount",dto);
		} catch (Exception e) {
			// TODO: handle exception
		}
		
	}

}
