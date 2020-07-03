package com.et.timetable;

import java.util.List;
import java.util.Map;

public interface TimeTableService {
	public void insertTimeTable(TimeTable dto) throws Exception;
	public void insertTrain(TimeTable dto) throws Exception;
	
	public int dataCount() throws Exception;
	public List<TimeTable> listTimeTable(Map<String, Object> map) throws Exception;
	public TimeTable readTimeTable(String scode) throws Exception;
	public void updateTimeTable(TimeTable dto) throws Exception;
	public void deleteTimeTable(String scode) throws Exception;

}
