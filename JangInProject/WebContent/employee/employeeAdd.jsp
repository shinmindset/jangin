<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "employee.employeeDao.EmployeeDao" %>
<%@ page import = "employee.employeeVO.EmployeeVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>직원 조회 </title>
<script type="text/javascript">
// 조회버튼 클릭
	function fn_insert(){
		var form = document.forms['EmployeeInfo'];
		if(form.empNameSch.value !=""){
			form.action = 
		}
		
		form.submit();
	}

	

	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['EmployeeInfo'];		
		form.empName.value="";
		form.empBirth.value="";
		form.empPosition.value="";
		form.empConstName.value="";
		form.empConstCode.value="";
		form.empDate.value="";
	}
	
	

</script>
</head>
<body>
<form action="employeeInsert.jsp" name="EmployeeInfo" method="post">
<div>
<table border="1">

	<tr>
		<td>이름</td>
		<td>생년월일</td>
		<td>직책</td>
		<td>연락처</td>
		<td>현장명</td>
		<td>현장코드</td>
		<td>날짜</td>
	</tr>
	<tr>
		<td><input type="text" name="empName"></td>
		<td><input type="text" name="empBirth"></td>
		<td><input type="text" name="empPosition"></td>
		<td><input type="text" name="empTel"></td>
		<td><input type="text" name="empConstName"></td>
		<td><input type="text" name="empConstCode"></td>
		<td><input type="text" name="empDate"></td>
	</tr>	
	<tr>
	<td><input type="submit" value="저장하기" />
	<td><input type="button" value="초기화" onclick="javascript:fn_cancel();" ></td>
				<td><a href="../main.jsp">[전 화면으로]</a></td>
	</tr>
</table>
</div>
</form>
</body>
</html>