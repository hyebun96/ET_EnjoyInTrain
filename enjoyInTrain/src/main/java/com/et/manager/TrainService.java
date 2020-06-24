package com.et.manager;

import java.util.List;

public interface TrainService {
	public void insertTrain();				// 기차 추가
	public void insertSeat();				// 기차내 자석 추가
	public Train readTrain();				// 기차정보 DB확인
	public List<Train> listTrain();			// 기차 리스트
}
