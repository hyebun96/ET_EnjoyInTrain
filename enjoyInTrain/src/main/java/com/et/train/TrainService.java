package com.et.train;

import java.util.List;
import java.util.Map;

public interface TrainService {
	public void insertRoom(Train dto);				// 기차 추가
	public List<Train> listTrain(Map<String, Object> map);					// 기차 리스트
	public int trainCount();
	public void totalSeatCount(Train dto);
}
