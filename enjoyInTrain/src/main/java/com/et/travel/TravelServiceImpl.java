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
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("travel.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
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
	public void insertPromotion(Travel dto) throws Exception {
		try {
			for(int i=0; i<dto.getStartCode().length; i++) {
				dto.setStCode(dto.getStartCode()[i]);
				dao.insertData("travel.insertPromotionStart", dto);				
			}
			
			for(int i=0; i<dto.getEndCode().length;  i++) {
				dto.setEdCode(dto.getEndCode()[i]);
				dao.insertData("travel.insertPromotionEnd", dto);				
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
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
			
			for(Promotion vo : startList) {
				startList = dao.selectList("travel.startlist2", vo);
				break;
			}
			
			
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
			
			for(Promotion vo : endList) {
				endList = dao.selectList("travel.endlist2", vo);
				break;
			}
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

	
}
