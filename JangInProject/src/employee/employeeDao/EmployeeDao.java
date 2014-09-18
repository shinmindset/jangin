package employee.employeeDao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Collections;

import employee.employeeVO.EmployeeVO;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;



public class EmployeeDao {
	public void add(Connection c, EmployeeVO employee) throws ClassNotFoundException, SQLException {
		Date nowtime = new Date();
		String now = new SimpleDateFormat("yyyyMMdd").format(nowtime);
		
		System.out.println("employee.getEmpName() in Dao: "+employee.getEmpName());
		
		if(employee.getEmpName().equals("") || ("").equals(employee.getEmpName()) || employee.getEmpName() == null){
			System.out.println("Employee empty space ");
			return;
			
		}
		
		PreparedStatement ps = c.prepareStatement(
				"insert into employee(emp_name, emp_div,emp_tel,emp_position,insert_time) values(?,?,?,?,?)");
		ps.setString(1, employee.getEmpName());
		ps.setString(2, employee.getEmpDiv());
		ps.setString(3, employee.getEmpTel());
		ps.setString(4, employee.getEmpPosition());
		ps.setString(5, now);
		
		ps.executeUpdate();

		ps.close();
		//c.close();
	}


	public EmployeeVO get(Connection c, EmployeeVO emp) throws ClassNotFoundException, SQLException {
		int empCode = emp.getEmpCode();
		String empName = emp.getEmpName();
		
		System.out.println("empCode In empDao:"+empCode);
		System.out.println("empName In empDao:" +empName);
		
		PreparedStatement ps = null;
		
		if(empCode>0 && empName == null){
			ps = c.prepareStatement("select * from employee where emp_code = ?");
			ps.setInt(1, empCode);
		}else if(empCode == 0 && empName != null){
			ps = c.prepareStatement("select * from employee where emp_name = ?");
			ps.setString(1, empName);
		}else if(empCode > 0 && empName != null){
			ps = c.prepareStatement("select * from employee where emp_code = ? and emp_name =?");
			ps.setInt(1, empCode);
			ps.setString(2, empName);
		}
		ResultSet rs = ps.executeQuery();
		EmployeeVO employee = new EmployeeVO();
		if(!rs.next()){
			employee.setEmpCode(0);
			employee.setEmpName("");
			
		}else{
			employee.setEmpCode(rs.getInt("EMP_CODE"));
			employee.setEmpName(rs.getString("EMP_NAME"));
		}
		rs.close();
		ps.close();

		return employee;
	}
	
	
	public List<EmployeeVO> getList(Connection c) throws ClassNotFoundException, SQLException {
		
		PreparedStatement ps = c
				.prepareStatement("select * from employee ");

		ResultSet rs = ps.executeQuery();
		
		if(!rs.next()){
			return Collections.emptyList();
		}
		List<EmployeeVO> employeeList = new ArrayList<EmployeeVO>();
		do {
			EmployeeVO vo = makeSetFromResultSet(rs);
			employeeList.add(vo);
		} while (rs.next());
		return employeeList;
	
	}
	
	private EmployeeVO makeSetFromResultSet(ResultSet rs)
			throws SQLException {
		EmployeeVO empVO = new EmployeeVO();
		empVO.setEmpCode(rs.getInt("EMP_CODE"));
		empVO.setEmpName(rs.getString("EMP_NAME"));
		empVO.setEmpDiv(rs.getString("EMP_DIV"));
		empVO.setEmpPosition(rs.getString("EMP_POSITION"));
		empVO.setEmpTel(rs.getString("EMP_TEL"));
		return empVO;
	}
}
