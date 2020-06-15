package com.et.crew;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("crew.crewService")
public class CrewServiceImpl implements CrewService{
	@Autowired
	private CommonDAO dao;
	
	@Override
	public Crew readCrew(String crewId) {
		Crew dto=null;
		try {
			dto=dao.selectOne("crew.readCrew",crewId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void insertCrew(Crew dto) throws Exception {
		try {
			if(dto.getCrewEmail1()!=null&&dto.getCrewEmail1().length()!=0&&
					dto.getCrewEmail2()!=null&&dto.getCrewEmail2().length()!=0) {
				dto.setCrewEmail(dto.getCrewEmail1()+"@"+dto.getCrewEmail2());
			}
			if(dto.getCrewTel1()!=null&&dto.getCrewTel1().length()!=0&&
					dto.getCrewTel2()!=null&&dto.getCrewTel2().length()!=0&&
					dto.getCrewTel3()!=null&&dto.getCrewTel3().length()!=0) {
				dto.setCrewTel(dto.getCrewTel1()+"-"+dto.getCrewTel2()+"-"+dto.getCrewTel3());
			}
			dao.insertData("crew.insertCrew", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
