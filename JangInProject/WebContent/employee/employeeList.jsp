<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "employee.employeeDao.EmployeeDao" %>
<%@ page import = "employee.employeeVO.EmployeeVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String code = request.getParameter("eCode");
	int eCode=0;
	String eName = request.getParameter("eName");
	
	EmployeeDao dao = new EmployeeDao();
	EmployeeVO vo = new EmployeeVO();
	
	vo.setEmpCode(eCode);
	vo.setEmpName(eName);
	
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	Iterator it = null;
	
	if (code != null && eName == null) {
		eCode = Integer.parseInt(code);
		vo.setEmpCode(eCode);
		vo = dao.get(conn, vo);
		List<EmployeeVO> lt = new ArrayList<EmployeeVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code == null && eName != null){
		vo = dao.get(conn, vo);
		List<EmployeeVO> lt = new ArrayList<EmployeeVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code != null && eName != null){
		eCode = Integer.parseInt(code);
		vo.setEmpCode(eCode);
		vo = dao.get(conn, vo);
		List<EmployeeVO> lt = new ArrayList<EmployeeVO>();
		lt.add(vo);
		it = lt.iterator();
	}else{
		it = dao.getList(conn).iterator();
	}
%>
<html>
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>직원 조회 </title>
<script type="text/javascript">
// 조회버튼 클릭
	function fn_search(){
		var form = document.forms['EmployeeInfo'];
		if(form.empCodeSch.value != "" && form.empNameSch.value ==""){
			form.action = 'employeeList.jsp?eCode='+form.empCodeSch.value;
		}else if(form.empCodeSch.value == "" && form.empNameSch.value !=""){
			form.action = 'employeeList.jsp?eName='+form.empNameSch.value;
		}
		else if(form.empCodeSch.value != "" && form.empNameSch.value !=""){
			form.action = 'employeeList.jsp?eCode='+form.empCodeSch.value+'&eName='+form.empNameSch.value;
		}
		form.submit();
	}

	

	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['EmployeeInfo'];		
		form.empCodeSch.value = "";
		form.empNameSch.value = ""
		
	}
	
	

</script>
</head>
<body>
<form name="EmployeeInfo" method="post">
<div class="search">
		<table border="1">
			<tr>		  
		    <th>사원번호</th>
		    <td><input name="empCodeSch" type="text"/ ></td>
		    <th>이름</th>
		    <td><input name="empNameSch" type="text"	 /></td>
		  </tr>
		  <tr>
		  	<th></th>
		    <td>
		    </td>
		    <th ></th>
		    <td></td>
		  </tr>
		</table>
	</div>
</form>
	<div class="btn">
			<tr>
				<td><input type="button" value="조회" onclick="javascript:fn_search();"></td>
				<td><input type="button" value="초기화" onclick="javascript:fn_cancel();" ></td>
				<td><a href="../main.jsp">[전 화면으로]</a></td>
			</tr>
	</div>
<div>
<table border="1">

	<tr>
		<td>사원번호</td>
		<td>이름</td>
		<td>생년월일</td>
		<td>직책</td>
		<td>연락처</td>
		<td>현장명</td>
		<td>현장코드</td>
		<td>날짜</td>
	</tr>
<%
	while(it.hasNext()){
		vo = (EmployeeVO)it.next();
		if(vo.getEmpCode()!=0){
%>
	<tr>
		<td><%=vo.getEmpCode() %></td>
		<td><%=vo.getEmpName() %></td>
		<td></td>
		<td><%= vo.getEmpPosition() %></td>
		<td><%= vo.getEmpTel() %></td>
		<td></td>
		<td></td>
		<td></td>
	</tr>
<%	
		}
	}
%>	
</table>
</div>
</body>
</html>