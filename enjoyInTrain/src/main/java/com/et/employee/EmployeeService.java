package com.et.employee;

import java.util.List;
import java.util.Map;

public interface EmployeeService {
	 public List<Employee> listEmployee(Map<String, Object> map) throws Exception;
	 public int dataCount(Map<String, Object> map);
	 public void insertEmployee(Employee dto) throws Exception;
	 public List<Employee> listPosition() throws Exception;
	 public Employee readEmployee(int emCode) throws Exception;
	 public void updateEmployee(Employee dto) throws Exception;

	 public void insertCategory(Employee dto) throws Exception;
	 public void updateCategory(Map<String, Object> map) throws Exception;
	 public void deleteCategory(int ptCode) throws Exception;

}
