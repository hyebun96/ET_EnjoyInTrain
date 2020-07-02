package com.et.travel;

import java.util.List;
import java.util.Map;

public interface TravelService {
	public List<Category> listCategory();
	public List<Partner> listPartner();
	public List<Station> listStation();
	
	public int dataCount(Map<String, Object> map);
	public List<StationLine> listStationLine(Map<String, Object> map);
	public List<StationLine> listStationLine2(Map<String, Object> map);
	public List<Travel> listTravel(Map<String, Object> map);
	
	public void insertPromotion(Travel dto) throws Exception;
	public void insertPromotionDetail(Travel dto,String path) throws Exception;
	
	public Travel readTravel(String pmCode);
	public StationLine readPromotion(String trainCode);
	public List<Promotion> startList(Travel dto);
	public List<Promotion> endList(Travel dto);
	
	public List<Photo> listPhoto(String pmCode);
	public List<Photo> listPhoto2(String pmCode);
	
	public List<Travel> travelRankList();
}
