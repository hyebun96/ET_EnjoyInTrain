package com.et.lostBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.FileManager;
import com.et.common.dao.CommonDAO;


@Service("lostBoard.lostBoardService")
public class LostBoardServiceImpl implements LostBoardService {
	
	@Autowired
	private CommonDAO dao;
	
	@Autowired
	private FileManager fileManager;
	
	
	@Override
	public void insertLostBoard(LostBoard dto, String pathname) throws Exception {
		try {
			int seq = dao.selectOne("lostBoard.seq");
			dto.setLostNum(seq);
			dao.insertData("lostBoard.insertLostBoard", dto);
			
			// 파일 업로드
			String saveFilename=fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFilename!=null) {
				dto.setSaveFileName(saveFilename);
				dto.setOriginalFileName(dto.getUpload().getOriginalFilename());
			}
					
				insertFile(dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<LostBoard> listLostBoard(Map<String, Object> map) {
		List<LostBoard> list = null;
		try {
			list = dao.selectList("lostBoard.listLostBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("lostBoard.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	@Override
	public LostBoard readLostBoard(int num) {
		LostBoard dto = null;
		
		try {
			// 게시물 가져오기
			dto = dao.selectOne("lostBoard.readLostBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			// 조회수 증가
			dao.updateData("lostBoard.updateHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public LostBoard preReadLostBoard(Map<String, Object> map) {
		LostBoard dto = null;
		
		try {
			dto = dao.selectOne("lostBoard.preReadLostBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public LostBoard nextReadLostBoard(Map<String, Object> map) {
		LostBoard dto = null;
		
		try {
			dto = dao.selectOne("lostBoard.nextReadLostBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void updateLostBoard(LostBoard dto, String pathname) throws Exception {
		try {
			
			String saveFileName = fileManager.doFileUpload(dto.getUpload(), pathname);
			if(saveFileName != null) {
				if(dto.getSaveFileName()!=null && dto.getSaveFileName().length()!=0) {
					fileManager.doFileDelete(dto.getSaveFileName(), pathname);
				}
				
				dto.setSaveFileName(saveFileName);
				dto.setOriginalFileName(dto.getUpload().getOriginalFilename());
				
				
				insertFile(dto);
			}
			
			dao.updateData("lostBoard.updateLostBoard",	dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void deleteLostBoard(int num, String pathname, String userId) throws Exception {
		try {
			LostBoard dto = readLostBoard(num);
			if(dto==null || (! userId.equals("admin")&& !userId.equals(dto.getCrewId()))) {
				return;
			}
			fileManager.doFileDelete(dto.getSaveFileName(), pathname);
			
			dao.deleteData("lostBoard.deleteLostBoard", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public void insertReply(Reply dto) throws Exception {
		try {
			dao.insertData("lostBoard.insertReply", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("lostBoard.listReply", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		
		try {
			result = dao.selectOne("lostBoard.replyCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {

		try {
			dao.deleteData("lostBoard.deleteReply", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;
		try {
			list = dao.selectList("lostBoard.listReplyAnswer", answer);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;
		
		try {
			result = dao.selectOne("lostBoard.replyAnswerCount", answer);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public void insertFile(LostBoard dto) throws Exception {
		try {
			dao.insertData("lostBoard.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

	@Override
	public List<LostBoard> listFile(int num) {
		List<LostBoard> listFile = null;
		
		try {
			listFile = dao.selectList("lostBoard.listFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

	@Override
	public LostBoard readFile(int num) {
		LostBoard dto = null;
		
		try {
			dto = dao.selectOne("lostBoard.readFile", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("lostBoard.deleteFile", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

}