<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "employee.employeeDao.EmployeeDao" %>
<%@ page import = "employee.employeeVO.EmployeeVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="employeeVO" class="employee.employeeVO.EmployeeVO">
	<jsp:setProperty name="employeeVO" property="*" />
</jsp:useBean>
<%
	String code = request.getParameter("eCode");
	int eCode=0;
	String eName = request.getParameter("eName");
	
	EmployeeDao dao = new EmployeeDao();
	//EmployeeVO vo = new EmployeeVO();
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	
	System.out.println(employeeVO.getEmpCode());
	System.out.println(employeeVO.getEmpName());
	System.out.println(employeeVO.getEmpTel());
	dao.add(conn, employeeVO);
	
	conn.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>직원 입력 저장</title>
</head>
<body>
직원 정보가 저장 되었습니다.
<br/>
<a href="employeeList.jsp">[목록 보기]</a>
</body>
</html>