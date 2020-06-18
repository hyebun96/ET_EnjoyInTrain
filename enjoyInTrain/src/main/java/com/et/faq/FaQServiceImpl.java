package com.et.faq;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("faq.FaQService")
public class FaQServiceImpl implements FaQService{

	@Autowired
	private CommonDAO dao;
	
	@Override
	public void insertFAQ(FAQ dto) throws Exception {
		try {
			dao.insertData("faq.insertFaQ", dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public List<FAQ> listQnA(Map<String, Object> map) {
		List<FAQ> list = null;
		
		try {
			list = dao.selectList("faq.listFaQ", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		
		return 0;
	}

	@Override
	public FAQ readFAQ(int num) {
		FAQ dto = null;
		try {
			dto = dao.selectOne("faq.readFaQ", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void updateFAQ(FAQ dto) throws Exception {
		try {
			dao.updateData("faq.updateFaQ",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void deleteFAQ(int num) throws Exception {
		try {
			dao.deleteData("faq.deleteFaQ", num);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void insertCategory(Map<String, Object> map) throws Exception {
		
		
	}

	@Override
	public void updateCategory(Map<String, Object> map) throws Exception {
		
		
	}

	@Override
	public List<FAQ> listCategory() {
		List<FAQ> listCategory = null;
		try {
			listCategory = dao.selectList("faq.listCategory");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listCategory;
	}

	@Override
	public void deleteCategory(int categoryNum) throws Exception {
		
		
	}

	
}
