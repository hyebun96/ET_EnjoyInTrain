package com.et.suggest;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.et.common.FileManager;
import com.et.common.dao.CommonDAO;

@Service("suggest.suggestService")
public class SuggestServiceImpl implements SuggestService{
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;

	@Override
	public void insertSuggest(Suggest dto, String mode, String pathname) throws Exception {
		try {
			//카테고리 구분
			switch (dto.getSgCategory()) {
			case "1": dto.setSgCategory("불편/불만"); break;
			case "2": dto.setSgCategory("제안/건의"); break;
			case "3": dto.setSgCategory("칭찬"); break;
			case "4": dto.setSgCategory("기타"); break;
			}
			
			int seq=dao.selectOne("suggest.suggestSeq");
			dto.setSgCode(seq);
			//일반글일때
			if(mode.equals("created")) {
				dto.setGroupNum(seq);
				dto.setDept(0);
				dto.setOrderNo(0);
				dto.setParent(0);
			}else {  //답글일때
				Map<String, Object> map=new HashMap<String, Object>();
				map.put("orderNo", dto.getOrderNo());
				map.put("groupNum", dto.getGroupNum());
				dao.updateData("suggest.updateOrderNo", map);
				
				dto.setDept(dto.getDept()+1);
				dto.setOrderNo(dto.getOrderNo()+1);
			}
			
			dao.insertData("suggest.insertSuggest", dto);
			
			
			// 파일 업로드
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf:dto.getUpload()) {
					String saveFilename=fileManager.doFileUpload(mf, pathname);
					if(saveFilename==null) continue;

					String originalFilename=mf.getOriginalFilename();
					long fileSize=mf.getSize();
								
					dto.setOriginalFilename(originalFilename);
					dto.setSaveFilename(saveFilename);
					dto.setFileSize(fileSize);
								
					insertFile(dto);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
	@Override
	public void insertFile(Suggest dto) throws Exception {
		try {
			System.out.println("====="+dto.getSgCode());
			dao.insertData("suggest.insertFile", dto);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public List<Suggest> listSuggest(Map<String, Object> map) {
		List<Suggest> list=null;
		try {
			list=dao.selectList("suggest.listSuggest",map);
			for(Suggest dto:list) {
				dto.setCrewName(dao.selectOne("crew.readCrewName", dto.getCrewId()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Suggest readSuggest(int sgCode) {
		Suggest dto=null;
		try {
			dto=dao.selectOne("suggest.readSuggest", sgCode);
			dto.setCrewName(dao.selectOne("crew.readCrewName", dto.getCrewId()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public int dataCount() {
		int result=0;
		try {
			result=dao.selectOne("suggest.dataCount");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void updateHitCount(int sgCode) throws Exception{
		try {
			dao.updateData("suggest.updateHitCount",sgCode);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void deleteSuggest(int sgCode, String pathname) throws Exception {
		// 파일 지우기
		List<Suggest> listFile=listFile(sgCode);
		if(listFile!=null) {
			for(Suggest dto:listFile) {
				fileManager.doFileDelete(dto.getSaveFilename(), pathname);
			}
		}
		
		// 파일 테이블 내용 지우기
		Map<String, Object> map=new HashMap<String, Object>();
		map.put("field", "sgCode"); 
		map.put("num", sgCode);  
		deleteFile(map);

		
		dao.deleteData("suggest.deleteSuggest", sgCode);
	}

	@Override
	public void updateSuggest(Suggest dto, String pathname) throws Exception {
		switch (dto.getSgCategory()) {
		case "1": dto.setSgCategory("불편/불만"); break;
		case "2": dto.setSgCategory("제안/건의"); break;
		case "3": dto.setSgCategory("칭찬"); break;
		case "4": dto.setSgCategory("기타"); break;
		}
		
		if(! dto.getUpload().isEmpty()) {
			for(MultipartFile mf:dto.getUpload()) {
				String saveFilename=fileManager.doFileUpload(mf, pathname);
				if(saveFilename==null) continue;
				
				String originalFilename=mf.getOriginalFilename();
				long fileSize=mf.getSize();
				
				dto.setOriginalFilename(originalFilename);
				dto.setSaveFilename(saveFilename);
				dto.setFileSize(fileSize);
				
				insertFile(dto);
			}
		}

		
		dao.updateData("suggest.updateSuggest", dto);
	}

	@Override
	public void insertComment(Comment dto) throws Exception {
		int seq=dao.selectOne("suggest.sgCommentSeq");
		dto.setNum(seq);
		dao.insertData("suggest.insertComment", dto);
	}

	@Override
	public List<Comment> listComment(Map<String, Object> map) throws Exception{
		
		List<Comment> listComment=null;
		try {
			listComment=dao.selectList("suggest.listComment",map);
			for(Comment dto:listComment) {
				dto.setCrewName(dao.selectOne("crew.readCrewName", dto.getCrewId()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return listComment;
	}

	@Override
	public int commentCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("suggest.commentCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteComment(Map<String, Object> paramMap) throws Exception {
		try{
			dao.deleteData("suggest.deleteComment", paramMap);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Comment> listReplyAnswer(int answer) {
		List<Comment> list = null;
		try {
			list = dao.selectList("suggest.listReplyAnswer",answer);
			for(Comment dto:list) {
				dto.setCrewName(dao.selectOne("crew.readCrewName", dto.getCrewId()));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		try {
			result = dao.selectOne("suggest.replyAnswerCount",answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public List<Suggest> listFile(int sgCode) {
		List<Suggest> listFile=null;
		try {
			listFile=dao.selectList("suggest.listFile", sgCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;

	}
	
	@Override
	public Suggest readFile(int fileNum) {
		Suggest dto=null;
		try {
			dto=dao.selectOne("suggest.readFile", fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("suggest.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}

	}

	@Override
	public Suggest preReadSuggest(Map<String, Object> map) {
		Suggest dto=null;

		try {
			dto=dao.selectOne("suggest.preReadSuggest", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;

	}

	@Override
	public Suggest nextReadSuggest(Map<String, Object> map) {
		Suggest dto=null;

		try {
			dto=dao.selectOne("suggest.nextReadSuggest", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void insertAn(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("suggest.insertAn", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
