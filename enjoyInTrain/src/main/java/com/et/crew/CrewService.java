package com.et.crew;

public interface CrewService {
	public Crew readCrew(String crewId);
	public void insertCrew(Crew dto) throws Exception;
}
