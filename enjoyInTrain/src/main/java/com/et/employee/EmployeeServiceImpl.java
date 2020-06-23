package com.et.employee;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.et.common.dao.CommonDAO;

@Service("employee.employeeService")
public class EmployeeServiceImpl implements EmployeeService{
	
	@Autowired
	private CommonDAO dao;
	
	
	@Override
	public List<Employee> listEmployee(Map<String, Object> map) throws Exception {
		List<Employee> list = dao.selectList("employee.listEmployee", map);
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) throws Exception {
		int dataCnt = dao.selectOne("employee.dataCount", map);
		return dataCnt;
	}

	@Override
	public void insertEmployee(Employee dto) throws Exception {
			dao.insertData("employee.insertEmployee",dto);
	}

	@Override
	public List<Employee> listPosition() throws Exception {
		List<Employee> list= null;
		try {
			 list = dao.selectList("employee.listPosition");
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return list;
	}

	@Override
	public Employee readEmployee(Employee dto) throws Exception {
		return  dao.selectOne("employee.readEmployee",dto);
		
	}

	@Override
	public void updateEmployee(Employee dto) throws Exception {
		try {
			dao.updateData("employee.updateEmployee",dto);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void insertCategory(Map<String, Object> map) throws Exception {
		try {
			dao.insertData("employee.insertCategory",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	@Override
	public void updateCategory(Map<String, Object> map) throws Exception {
		try {
			dao.updateData("employee.updateCategory",map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}


	@Override
	public void deleteCategory(int ptCode) throws Exception {
		try {
		dao.deleteData("employee.deleteCategory",ptCode);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
