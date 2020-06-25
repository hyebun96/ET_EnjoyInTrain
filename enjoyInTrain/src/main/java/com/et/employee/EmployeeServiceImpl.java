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
		List<Employee> list=null;
		
		try {
			list = dao.selectList("employee.listEmployee", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public int dataCount(Map<String, Object> map) {
		int dataCnt =0;
		try{
			dataCnt= dao.selectOne("employee.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dataCnt;
	}

	@Override
	public void insertEmployee(Employee dto) throws Exception {
		try {
			dao.insertData("employee.insertEmployee",dto);
		}catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
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
	public Employee readEmployee(int emCode) throws Exception {
		Employee dto = null;
		
		try {
			dto = dao.selectOne("employee.readEmployee",emCode);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
		
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
	public void insertCategory(Employee dto) throws Exception {
		try {
			dao.insertData("employee.insertCategory",dto);
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
