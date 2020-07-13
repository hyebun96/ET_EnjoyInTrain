package com.et.travel;

import java.util.List;
import java.util.Map;

public interface TravelService {
	public List<Category> listCategory();
	public List<Partner> listPartner();
	public List<Station> listStation();
	
	public List<StationLine> listStationLine(Map<String, Object> map);
	public List<StationLine> listStationLine2(Map<String, Object> map);
	public List<Travel> listTravel(Map<String, Object> map);
	
	public void insertPromotionDetail(Travel dto,String path) throws Exception;
	public void updatePromotionDetail(Travel dto,String path) throws Exception;
	public void deletePromotionDetail(String pmCode) throws Exception;

	public Travel readTravel(String pmCode);
	public StationLine readPromotion(String trainCode);
	public List<Promotion> startList(Travel dto);
	public List<Promotion> endList(Travel dto);
	
	public List<Photo> listPhoto(String pmCode);
	public List<Photo> listPhoto2(String pmCode);

	public List<Travel> travelRankList();
	
	public void deleteFile(Map<String, Object> map) throws Exception;
	public void deleteContentFile(Map<String, Object> map) throws Exception;

	public Photo readFile(int fileNum);
	public Photo readContentFile(int fileNum);
	
	public void deleteTrain(int trainCode) throws Exception;
	
	public void insertPromotionAdd(Promotion dto) throws Exception;
	
	public List<Travel> randomMain() throws Exception;
	public List<Travel> deadLine() throws Exception;
	
	public int priceGet(Map<String, Object> map) throws Exception;
	
	public List<Promotion> pmCount(List<Promotion> list);
	
	public List<Chart> areaChart();
	public List<Chart> promotionChart();
}
