package com.et.admin.trainsales;

import java.util.List;
import java.util.Map;

public interface TrainSalesService {
	public List<TrainSales> listDay(Map<String, Object> map);	//일별
	public List<TrainSales> listMonth(Map<String, Object> map);	//월별
	public List<TrainSales> listYear(Map<String, Object> map);	//년별
	
	public TrainpersonType listType(); //승객
	
}
