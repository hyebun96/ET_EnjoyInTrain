package com.et.admin.trainsales;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service(".admin.trainsales.trainSalesService")
public class TrainSalesServiceImpl implements TrainSalesService{
	
	@Autowired
	private CommonDAO dao;
	
	@Override
	public List<TrainSales> listDay(Map<String, Object> map) {
		List<TrainSales> list = null;
		
		try {
			list = dao.selectList("trainsales.listDay",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<TrainSales> listMonth(Map<String, Object> map) {
		List<TrainSales> listM = null;
		
		try {
			listM = dao.selectList("trainsales.listMonth",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listM;
	}

	@Override
	public List<TrainSales> listYear(Map<String, Object> map) {
		List<TrainSales> listY = null;
		
		try {
			listY =dao.selectList("trainsales.listYear",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listY;
	}
}
