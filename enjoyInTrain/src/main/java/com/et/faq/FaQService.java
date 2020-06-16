package com.et.faq;

import java.util.List;
import java.util.Map;

public interface FaQService {
	public void insertFAQ(FAQ dto) throws Exception;	// 질문추가
	public List<FAQ> listQnA(Map<String,Object> map);	// 질문 리스트
	public int dataCount(Map<String, Object> map);		// 질문   갯수
	
	public FAQ readFAQ(int num);	// 질문 검색
	
	public void updateFAQ(FAQ dto) throws Exception; // 질문수정
	public void deleteFAQ(int num) throws Exception;	// 질문삭제
	
	public void insertCategory(Map<String, Object> map) throws Exception;
	public void updateCategory(Map<String, Object> map) throws Exception;
	public List<FAQ> listCategory();
	public void deleteCategory(int categoryNum) throws Exception;
	
}
