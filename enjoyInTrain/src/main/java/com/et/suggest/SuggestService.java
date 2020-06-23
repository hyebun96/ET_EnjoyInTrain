package com.et.suggest;

import java.util.List;
import java.util.Map;

public interface SuggestService {
	public void insertSuggest(Suggest dto, String mode, String pathname) throws Exception;
	public List<Suggest> listSuggest(Map<String, Object> map);
	public Suggest readSuggest(int sgCode);
	public int dataCount();
	public void updateHitCount(int sgCode) throws Exception;
	public void deleteSuggest(int sgCode, String pathname) throws Exception;
	public void updateSuggest(Suggest dto, String pathname) throws Exception;
	public void insertFile(Suggest dto) throws Exception;
	public List<Suggest> listFile(int sgCode);
	public Suggest readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
	
	public Suggest preReadSuggest(Map<String, Object> map);
	public Suggest nextReadSuggest(Map<String, Object> map);
	
	//댓글
	public void insertComment(Comment dto) throws Exception;
	public List<Comment> listComment(Map<String, Object> map) throws Exception;
	public int commentCount(Map<String, Object> map);
	public void deleteComment(Map<String, Object> paramMap) throws Exception;

	public List<Comment> listReplyAnswer(int answer);
	public int replyAnswerCount(int answer);
	
	public void insertAn(Map<String, Object> map) throws Exception;
}	
