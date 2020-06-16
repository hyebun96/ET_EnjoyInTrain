package com.et.lostBoard;

import java.util.List;
import java.util.Map;


public interface LostBoardService {
	public void insertLostBoard(LostBoard dto, String pathname) throws Exception;
	public List<LostBoard> listLostBoard(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	public LostBoard readLostBoard(int num);
	public void updateHitCount(int num) throws Exception;
	public LostBoard preReadLostBoard(Map<String, Object> map);
	public LostBoard nextReadLostBoard(Map<String, Object> map);
	public void updateLostBoard(LostBoard dto, String pathname) throws Exception;
	public void deleteLostBoard(int num, String pathname, String userId) throws Exception;
	
	public void insertReply(Reply dto) throws Exception;
	public List<Reply> listReply(Map<String, Object> map);
	public int replyCount(Map<String, Object> map);
	public void deleteReply(Map<String, Object> map) throws Exception;
	
	public List<Reply> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertFile(LostBoard dto) throws Exception;
	public List<LostBoard> listFile(int num);
	public LostBoard readFile(int num);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
}
