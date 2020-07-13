package com.et.crew;

import java.util.List;
import java.util.Map;
import java.util.Random;

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
			if(dto.getCrewEmail()!=null) {
				String [] ss= dto.getCrewEmail().split("@");
				dto.setCrewEmail1(ss[0]);
				dto.setCrewEmail2(ss[1]);
			}	
			
			if(dto.getCrewTel()!=null) {
				String [] tt= dto.getCrewTel().split("-");
				dto.setCrewTel1(tt[0]);
				dto.setCrewTel2(tt[1]);
				dto.setCrewTel3(tt[2]);
			}	
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
	public void updatecrewState(Crew dto) throws Exception {
		try {
			dao.updateData("crew.updatecrewState",dto);
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
	public void generatePwd(Crew dto) throws Exception {
		
		StringBuilder sb = new StringBuilder();
		Random rd = new Random();
		
		String s = "!@#$%^&*ABCDEFGHIJKLNMOPQRSTUVWYZqweasdzxcrtyfghvbnuiojklmp1234567890";
		for(int i=0; i<10; i++) {
			int n = rd.nextInt(s.length());
			sb.append(s.subSequence(n, n+1));
		}
		
		String ss = dto.getCrewId()+"님의 새로 발급된 임시 패스워드는 <b>";
		ss += sb.toString() + "<b> 입니다. <br>";
		ss += "로그인 후 반드시 패스워드를 변경 하시기 바랍니다.";
		
//		Mail mail = new Mail();
//		mail.setReceiverEmail(dto.getEmail());
//		
//		mail.setSenderEmail("rkqkdskei@gmail.com");
//		mail.setSenderName("관리자");
//		mail.setSubject("임시비밀번호 발급");
//		mail.setContent(ss);
//		
//		boolean b = mailSender.mailSend(mail);
//		
//		if(b) {
//			dto.setUserPwd(sb.toString());
//			updateMember(dto);
//		}else {
//			throw new Exception("이메일 전송중 오류가 발생했습니다.");
//		}
		
	}
}
