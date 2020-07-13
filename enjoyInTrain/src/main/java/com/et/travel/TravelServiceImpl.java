package com.et.travel;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.et.common.FileManager;
import com.et.common.dao.CommonDAO;

@Service("travel.travelService")
public class TravelServiceImpl implements TravelService{
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	@Override
	public List<Category> listCategory() {
		List<Category> listCategory = null;
		try {
			listCategory = dao.selectList("travel.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public List<Partner> listPartner() {
		List<Partner> listPartner = null;
		try {
			listPartner = dao.selectList("travel.listPartner");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listPartner;
	}
	
	@Override
	public List<Station> listStation() {
		List<Station> listStation = null;
		try {
			listStation = dao.selectList("travel.listStation");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listStation;
	}

	@Override
	public List<StationLine> listStationLine(Map<String, Object> map) {
		List<StationLine> listStationLine = null;
		try {
			listStationLine = dao.selectList("travel.listStationLine", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listStationLine;
	}
	
	@Override
	public List<StationLine> listStationLine2(Map<String, Object> map) {
		List<StationLine> listStationLine = null;
		try {
			listStationLine = dao.selectList("travel.listStationLine2", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listStationLine;
	}
	
	@Override
	public List<Travel> listTravel(Map<String, Object> map) {
		List<Travel> list = null;
		try {
			list = dao.selectList("travel.listTravel", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertPromotionDetail(Travel dto, String path) throws Exception {
		try {
			dao.insertData("travel.insertPromotionDetail", dto);
			
			Photo pdto = new Photo();
			pdto.setPmCode(dto.getPmCode());

			String saveFilename = fileManager.doFileUpload(dto.getUpload(), path);
			if(saveFilename!=null) {
				pdto.setOriginalFileName(dto.getUpload().getOriginalFilename());
				pdto.setFileSize(dto.getUpload().getSize());
				pdto.setSaveFileName(saveFilename);
				dao.insertData("travel.insertPhoto", pdto);
			}	
			
			if(!dto.getUpload().isEmpty()) {				
				for(MultipartFile mpf : dto.getUploadContent()) {
					
					saveFilename = fileManager.doFileUpload(mpf, path);
					if(saveFilename!=null && mpf.getSize()!=-1) {
						pdto.setOriginalFileName(mpf.getOriginalFilename());
						pdto.setFileSize(mpf.getSize());
						pdto.setSaveFileName(saveFilename);
						dao.insertData("travel.insertContentPhoto", pdto);
					}	
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public Travel readTravel(String pmCode) {
		Travel dto = null;
		try {
			dto = dao.selectOne("travel.readTravel", pmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public StationLine readPromotion(String trainCode) {
		StationLine dto = null;
		try {
			dto = dao.selectOne("travel.readPromotion", trainCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public List<Promotion> startList(Travel dto){
		List<Promotion> startList = null;
		try {
			startList = dao.selectList("travel.startlist1", dto);
			
			Promotion vo = startList.get(0);
			startList = dao.selectList("travel.startlist2", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return startList;
	}

	@Override
	public List<Promotion> endList(Travel dto){
		List<Promotion> endList = null;
		try {
			endList = dao.selectList("travel.endlist1", dto);
			
			Promotion vo = endList.get(0);
			endList = dao.selectList("travel.endlist2", vo);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return endList;
	}

	@Override
	public List<Photo> listPhoto(String pmCode) {
		List<Photo> photoList = null;
		try {
			photoList = dao.selectList("travel.listPhoto", pmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return photoList;
	}
	
	@Override
	public List<Photo> listPhoto2(String pmCode) {
		List<Photo> photoContentList = null;
		try {
			photoContentList = dao.selectList("travel.listPhoto2", pmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return photoContentList;
	}

	@Override
	public List<Travel> travelRankList() {
		List<Travel> travelRankList = null;
		try {
			travelRankList = dao.selectList("travel.travelRank");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return travelRankList;
	}
	
	@Override
	public void deleteFile(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("travel.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteContentFile(Map<String, Object> map) throws Exception{
		try {
			dao.deleteData("travel.deleteContentFile", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public Photo readFile(int fileNum) {
		Photo dto = null;
		try {
			dto = dao.selectOne("travel.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Photo readContentFile(int fileNum) {
		Photo dto = null;
		try {
			dto = dao.selectOne("travel.readContentFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public void updatePromotionDetail(Travel dto, String path) throws Exception {
		try {
			dao.updateData("travel.updatePromotionDetail", dto);
			
			Photo pdto = new Photo();
			pdto.setPmCode(dto.getPmCode());

			String saveFilename = "";
			if(!dto.getUpload().isEmpty()) {
				saveFilename = fileManager.doFileUpload(dto.getUpload(), path);
				if(saveFilename!=null) {
					pdto.setOriginalFileName(dto.getUpload().getOriginalFilename());
					pdto.setFileSize(dto.getUpload().getSize());
					pdto.setSaveFileName(saveFilename);
					dao.insertData("travel.insertPhoto", pdto);
				}	
			}
			
			if(!dto.getUploadContent().isEmpty()) {				
				for(MultipartFile mpf : dto.getUploadContent()) {
					
					saveFilename = fileManager.doFileUpload(mpf, path);
					if(saveFilename!=null && mpf.getSize()!=-1) {
						pdto.setOriginalFileName(mpf.getOriginalFilename());
						pdto.setFileSize(mpf.getSize());
						pdto.setSaveFileName(saveFilename);
						dao.insertData("travel.insertContentPhoto", pdto);
					}	
				}
			}
		
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void deletePromotionDetail(String pmCode) throws Exception {
		try {
			dao.deleteData("travel.deletePromotion", pmCode);
			dao.deleteData("travel.deletePromotionDetail", pmCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteTrain(int trainCode) throws Exception {
		try {
			dao.deleteData("travel.deleteTrain", trainCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertPromotionAdd(Promotion dto) throws Exception {
		try {
			dao.insertData("travel.insertPromotionAdd", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<Travel> randomMain() throws Exception {
		List<Travel> list = null;
		try {
			list = dao.selectList("travel.randomMain");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Travel> deadLine() throws Exception {
		List<Travel> list = null;
		try {
			list = dao.selectList("travel.deadLine");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int priceGet(Map<String, Object> map) throws Exception {
		int price = 0;
		List<String> list = null; 
		try {
			list = dao.selectList("travel.TrainGet", map);
			
			String s1 = "";
			String s2 = "";
			
			if( list.get(0).compareTo(list.get(1)) <= 0) {
				s1 = list.get(0);
				s2 = list.get(1);
			}else {
				s1 = list.get(1);
				s2 = list.get(0);
			}
			
			map.put("s1", s1);
			map.put("s2", s2);

			price = dao.selectOne("travel.priceGet", map);				

			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return price;
	}

	@Override
	public List<Promotion> pmCount(List<Promotion> list) {
		try {
			for(Promotion dto : list) {
				int pmCount = dao.selectOne("travel.pmCount", dto);
				dto.setPmCount(pmCount);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	@Override
	public List<Chart> areaChart() {
		List<Chart> list = null;
		try {
			list = dao.selectList("travel.areaChart");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<Chart> promotionChart() {
		List<Chart> list = null;
		try {
			list = dao.selectList("travel.promotionChart");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
}
