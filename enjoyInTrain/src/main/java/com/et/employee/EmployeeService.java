package com.et.employee;

import java.util.List;
import java.util.Map;

public interface EmployeeService {
	 public List<Employee> listEmployee(Map<String, Object> map) throws Exception;
	 public int dataCount(Map<String, Object> map) throws Exception;
	 public void insertEmployee(Employee dto) throws Exception;
	 public List<Employee> listPosition() throws Exception;
	 public Employee readEmployee(Employee dto) throws Exception;
	 public void updateEmployee(Employee dto) throws Exception;
	 
}
