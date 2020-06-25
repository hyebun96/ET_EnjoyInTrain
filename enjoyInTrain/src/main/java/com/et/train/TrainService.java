package com.et.train;

import java.util.List;
import java.util.Map;

public interface TrainService {
	public void insertTrain(Train dto);				// 기차 추가
	public Train readTrain(String code);			// 기차정보 DB확인
	public List<Train> listTrain(Map<String, Object> map);					// 기차 리스트
	public int trainCount();
	public void insertRoom(Train dto);
	public void totalSeatCount(Train dto);
}
