package com.et.notice;

import java.util.List;
import java.util.Map;

public interface NoticeService {

	public void insertNotice(Notice dto, String pathname) throws Exception;
	public int dataCount(Map<String, Object> map);
	public List<Notice> listNotice(Map<String, Object> map);
	public List<Notice> listNoticeTop();
	
	// 세부내용
	public void updateHitCount(int num) throws Exception;
	public Notice readNotice(int noticeNum);
	public Notice preReadNotice(Map<String, Object> map);
	public Notice nextReadNotice(Map<String, Object> map);
	
	public void updateNotice(Notice dto, String pathname) throws Exception;
	public void deleteNotice(int num, String pathname) throws Exception;
	
	
	
	// 파일처리
	public void insertFile(Notice dto) throws Exception;
	public List<Notice> listFile(int num);
	public Notice readFile(int fileNum);
	public void deleteFile(Map<String, Object> map) throws Exception;
}
