package com.et.crew;

import java.util.List;
import java.util.Map;

public interface CrewService {
	public Crew readCrew(String crewId);
	public void insertCrew(Crew dto) throws Exception;
	public void updateCrew(Crew dto) throws Exception;
	
	public int dataCount(Map<String, Object> map);
	public List<Crew> listCrew(Map<String, Object> map);
	
	public void updatecrewState(Crew dto)throws Exception;
	public List<Crew> listCrewState(String crewId);
	public Crew readCrewState(String crewId);
	
	public void generatePwd(Crew dto) throws Exception;
	public void updatePwd(Crew dto) throws Exception;
	
	public String readCrew2(Crew dto);
}
