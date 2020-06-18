package com.et.freeBoard;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.et.common.FileManager;
import com.et.common.dao.CommonDAO;

@Service("freeBoard.freeBoardService")
public class FreeBoardServiceImpl implements FreeBoardService {

	@Autowired
	private CommonDAO dao;

	@Autowired
	private FileManager fileManager;

//게시글 추가
	@Override
	public void insertBoard(FreeBoard dto, String pathname) throws Exception {
		try {

			int seq = dao.selectOne("freeBoard.seq");
			dto.setFbNum(seq);

			dao.insertData("freeBoard.insertBoard", dto);

			// 파일업로드
			if (!dto.getUpload().isEmpty()) {
				for (MultipartFile mf : dto.getUpload()) {
					String saveFileName = fileManager.doFileUpload(mf, pathname);
					if (saveFileName == null) {
						continue;
					}

					String originalFileName = mf.getOriginalFilename();
					long FileSize = mf.getSize();

					dto.setOriginalFileName(originalFileName);
					dto.setSaveFileName(saveFileName);
					dto.setFileSize(FileSize);

					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

//게시글 리스트
	@Override
	public List<FreeBoard> listBoard(Map<String, Object> map) {
		List<FreeBoard> list = null;

		try {
			list = dao.selectList("freeBoard.listBoard", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

//게시글데이터 갯수	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;

		try {
			result = dao.selectOne("freeBoard.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return result;
	}

//게시글 보기	
	@Override
	public FreeBoard readBoard(int num) {
		FreeBoard dto = null;
		
		try {
			dto=dao.selectOne("freeBoard.readBoard",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}

	
//게시글 조회 개수	
	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("freeBoard.updateHitCount",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		
	}

//이전글	
	@Override
	public FreeBoard preReadBoard(Map<String, Object> map) {
		FreeBoard dto = null;
		
		try {
			dto=dao.selectOne("freeBoard.preReadBoard",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

//다음글	
	@Override
	public FreeBoard nextReadBoard(Map<String, Object> map) {
		FreeBoard dto = null;
		try {
			dto=dao.selectOne("freeBoard.nextReadBoard",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

//수정	
	@Override
	public void updateBoard(FreeBoard dto, String pathname) throws Exception {
		try {
			dao.updateData("freeBoard.updateBoard",dto);
			
			if(! dto.getUpload().isEmpty()) {
				for(MultipartFile mf: dto.getUpload()) {
					String saveFileName = fileManager.doFileUpload(mf, pathname);
					if(saveFileName==null) {
						continue;
					}
					String originalFileName = mf.getOriginalFilename();
					long fileSize = mf.getSize();
					
					dto.setOriginalFileName(originalFileName);
					dto.setSaveFileName(saveFileName);
					dto.setFileSize(fileSize);
					
					insertFile(dto);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

//게시글 삭제	
	@Override
	public void deleteBoard(int num, String pathname, String crewId) throws Exception {
		try {
			FreeBoard dto = readBoard(num);
			if(dto ==null || (!crewId.equals("admin") && !crewId.equals(dto.getCrewId()))) {
				return;
			}
			
			fileManager.doFileDelete(dto.getSaveFileName(),pathname);
			
			dao.deleteData("freeBoard.deleteBoard",num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

//파일추가
	@Override
	public void insertFile(FreeBoard dto) throws Exception {
		try {
			dao.insertData("freeBoard.insertFile", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

//파일 리스트
	@Override
	public List<FreeBoard> listFile(int num) {
		List<FreeBoard> listFile = null;

		try {
			listFile = dao.selectList("freeBoard.listFile", num);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return listFile;
	}

//파일보기	
	@Override
	public FreeBoard readFile(int fileNum) {
		FreeBoard dto = null;
		
		try {
			dto=dao.selectOne("freeBoard.readFile",fileNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

//파일 삭제	
	@Override
	public void deleteFile(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("freeBoard.deleteFile",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
//게시글 좋아요
	@Override
	public void insertBoardLike(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("freeBoard.insertBoardLike",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
	
//게시글 좋아요 개수
	@Override
	public int boardLikeCount(int num) {
		int result = 0;
		try {
			result=dao.selectOne("freeBoard.boardLikeCount",num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

//댓글추가 
	@Override
	public void insertReply(Reply dto) throws Exception {
	
		try {
			dao.insertData("freeBoard.insertReply",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	
	}

//댓글리스트	
	@Override
	public List<Reply> listReply(Map<String, Object> map) {
		List<Reply> list = null;
		
		try {
			list = dao.selectList("freeBoard.listReply",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

//댓글 개수	
	@Override
	public int replyCount(Map<String, Object> map) {
		int result = 0;
		try {
			result=dao.selectOne("freeBoard.replyCount",map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

//댓글 삭제	
	@Override
	public void deleteReply(Map<String, Object> map) throws Exception {

	}

	@Override
	public List<Reply> listReplyAnswer(int answer) {
		List<Reply> list = null;

		return list;
	}

	@Override
	public int replyAnswerCount(int answer) {
		int result = 0;

		return result;
	}

	@Override
	public void insertReplyLike(Map<String, Object> map) throws Exception {

	}

	@Override
	public Map<String, Object> replyLikeCount(Map<String, Object> map) {

		return null;
	}
}
