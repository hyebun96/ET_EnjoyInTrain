package com.et.timetable;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("timetable.timeTableService")
public class TimeTableServiceImpl implements TimeTableService {
	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertTimeTable(TimeTable dto) throws Exception {
		try {
			dao.insertData("timetable.insertTimeTable", dto);
		} catch (Exception e) {
			e.printStackTrace();
			
			throw e;
		}
	}

	@Override
	public int dataCount() throws Exception {
		int result=0;
		try {
			result=dao.selectOne("timetable.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<TimeTable> listTimeTable(Map<String, Object> map) throws Exception {
		List<TimeTable> list=null;
		try {
			list=dao.selectList("timetable.listTimeTable", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public TimeTable readTimeTable(String scode) throws Exception {
		TimeTable dto=null;
		try {
			dto=dao.selectOne("timetable.readTimeTable", scode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateTimeTable(TimeTable dto) throws Exception {
		try {
			dao.updateData("timetable.updateTimeTable", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteTimeTable(String scode) throws Exception {
		try {
			dao.deleteData("timetable.deleteTimeTable", scode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	
}
