package com.et.timeTable;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;
@Service("timetable.timeTableService")
public class TimeTableServiceImpl implements TimeTableService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertTimeTable(TimeTable dto) {
		
		try {
			
			dao.insertData("timeTable.insertTimeTable", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public List<TimeTable> listTimeTable(Map<String, Object> map) {
		List<TimeTable> list = null;
		
		try {
			list = dao.selectList("timeTable.listTimeTable", map);
		} catch (Exception e) {
		}
		
		return list;
	}

	

	@Override
	public int timetableCount() {
		int result = 0;
		
		try {
			result = dao.selectOne("timeTable.timeTableCount");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return result;
	}

	

}
