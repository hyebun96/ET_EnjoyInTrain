package com.et.qna;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;
import com.et.faq.FAQ;

@Service("qna.qnaService")
public class QnAServiceImp implements QnAService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertQnA(QnA dto) throws Exception {
		try {
			dao.insertData("qna.insertQnA", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<QnA> listQnA(Map<String, Object> map) {
		List<QnA> list = null;
		try {
			list = dao.selectList("qna.listQnA", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int result = 0;
		try {
			result = dao.selectOne("qna.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public QnA readQnA(int num) {
		QnA dto = null;
		try {
			dto = dao.selectOne("qna.readQnA", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateHitCount(int num) throws Exception {
		try {
			dao.updateData("qna.updateHitCount", num);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public QnA preReadQnA(Map<String, Object> map) {
		QnA dto = null;
		try {
			dto = dao.selectOne("qna.preReadQnA", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public QnA nextReadQnA(Map<String, Object> map) {
		QnA dto = null;
		try {
			dto = dao.selectOne("qna.nextReadQnA", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateQnA(QnA dto) throws Exception {
		try {
			dao.updateData("qna.updateQnA", dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteQnA(Map<String, Object> map) throws Exception {
		try {
			dao.deleteData("qna.deleteQnA", map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<QnA> listCategory() {
		List<QnA> listCategory = null;
		try {
			listCategory = dao.selectList("qna.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public List<FAQ> readFAQ(int group) throws Exception {
		List<FAQ> list = null;
		try {
			list = dao.selectList("qna.listFaQ", group);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public List<QnA> listAdminQnA(Map<String, Object> map) {
		List<QnA> list= null;
		try {
			list = dao.selectList("qna.listAdminQnA", map);
		} catch (Exception e) {
			e.printStackTrace();
		}		
		return list;
	}
	
}
