package com.et.qna;

import java.util.List;
import java.util.Map;

import com.et.faq.FAQ;


public interface QnAService {
	public void insertQnA(QnA dto) throws Exception;	// 질문추가
	public List<QnA> listQnA(Map<String,Object> map);	// 질문 리스트
	public List<QnA> listAdminQnA(Map<String,Object> map);	// 질문 리스트
	public int dataCount(Map<String, Object> map);		// 질문   갯수
	
	public QnA readQnA(int num);	// 질문 검색
	public void updateHitCount(int num) throws Exception; //조회수 증가
	
	public QnA preReadQnA(Map<String, Object> map);		// 이전질문
	public QnA nextReadQnA(Map<String, Object> map);	// 다음질문
	
	public void updateQnA(QnA dto) throws Exception; // 질문수정
	public void deleteQnA(Map<String, Object> map) throws Exception;	// 질문삭제
	
	public List<QnA> listCategory();
	
	public List<FAQ> readFAQ(int group) throws Exception;
	
}
