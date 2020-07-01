package com.et.crew;

import java.util.List;
import java.util.Map;

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
			if(dto.getCrewEmail1() != null && dto.getCrewEmail1().length()!=0 &&
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

	//회원데이터 갯수
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("crew.dataCount",map);
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	//회원리스트
	@Override
	public List<Crew> listCrew(Map<String, Object> map) {
		List<Crew> list = null;
		
		try {
			list = dao.selectList("crew.listCrew",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public void insertCrewState(Crew dto) throws Exception {
		try {
			dao.updateData("crew.insertCrewState",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<Crew> listCrewState(String crewId) {
		List<Crew> list = null;
		try {
			list = dao.selectList("crew.listCrewState",crewId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Crew readCrewState(String crewId) {
		Crew dto = null;
		
		try {
			dto= dao.selectOne("crew.readCrewState", crewId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateCrew(Crew dto) throws Exception {
		try {
			if(dto.getCrewEmail1() != null && dto.getCrewEmail1().length() != 0 
				&& dto.getCrewEmail2() != null && dto.getCrewEmail2().length() != 0) {
				dto.setCrewEmail(dto.getCrewEmail1()+"@"+dto.getCrewEmail2());
			}
			
			if(dto.getCrewTel1()!=null&&dto.getCrewTel1().length()!=0&&
					dto.getCrewTel2()!=null&&dto.getCrewTel2().length()!=0&&
					dto.getCrewTel3()!=null&&dto.getCrewTel3().length()!=0) {
				dto.setCrewTel(dto.getCrewTel1()+"-"+dto.getCrewTel2()+"-"+dto.getCrewTel3());
			}
			
			dao.updateData("crew.updateCrew", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteCrew(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("crew.deleteCrew",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
