package com.et.timeTable;

import java.util.List;
import java.util.Map;

public interface TimeTableService {
	public void insertTimeTable(TimeTable dto);				
	public List<TimeTable> listTimeTable(Map<String, Object> map);
	public int timetableCount();
	
	
//	public void updateTimeTable(TimeTable dto);
//	public void deleteTimeTable(int num);
}
