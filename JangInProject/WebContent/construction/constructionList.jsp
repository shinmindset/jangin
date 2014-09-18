<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "construction.constructionDao.ConstructionDao" %>
<%@ page import = "construction.constructionVO.ConstructionVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	String code = request.getParameter("cCode");
	int eCode=0;
	String eName = request.getParameter("cName");
	
	ConstructionDao dao = new ConstructionDao();
	ConstructionVO vo = new ConstructionVO();
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	
	Iterator it = null;
	
	if (code != null && eName == null) {
		eCode = Integer.parseInt(code);
		vo.setConCode(eCode);
		vo = dao.get(conn, vo);
		List<ConstructionVO> lt = new ArrayList<ConstructionVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code == null && eName != null){
		vo.setConName(eName);
		vo = dao.get(conn, vo);
		List<ConstructionVO> lt = new ArrayList<ConstructionVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code != null && eName != null){
		eCode = Integer.parseInt(code);
		vo.setConCode(eCode);
		vo.setConName(eName);
		vo = dao.get(conn, vo);
		List<ConstructionVO> lt = new ArrayList<ConstructionVO>();
		lt.add(vo);
		it = lt.iterator();
	}else{
		it = dao.getList(conn).iterator();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>현장 조회</title>
<script type="text/javascript">
// 조회버튼 클릭
	function fn_search(){
		var form = document.forms['ConstructionInfo'];
		if(form.conCodeSch.value != "" && form.conNameSch.value ==""){
			form.action = 'constructionList.jsp?cCode='+form.conCodeSch.value;
		}else if(form.conCodeSch.value == "" && form.conNameSch.value !=""){
			form.action = 'constructionList.jsp?cName='+form.conNameSch.value;
		}
		else if(form.conCodeSch.value != "" && form.conNameSch.value !=""){
			form.action = 'constructionList.jsp?cCode='+form.conCodeSch.value+'&cName='+form.conNameSch.value;
		}
		form.submit();
	}

	

	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['ContructionInfo'];		
		form.conCodeSch.value = "";
		form.conNameSch.value = ""
		
	}
</script>
</head>
<body>
<form name="ConstructionInfo" method="post">
<div class="search">
		<table border="1">
			<tr>		  
		    <th>현장코드</th>
		    <td><input name="conCodeSch" type="text"/ ></td>
		    <th>현장명</th>
		    <td><input name="conNameSch" type="text"/></td>
		  </tr>
		  <tr>
		  	<th></th>
		    <td>
		    </td>
		    <th ></th>
		    <td>
		    </td>
		  </tr>
		</table>
	</div>
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
			<td>현장코드</td>
			<td>현장명</td>
			<td>시작일</td>
			<td>종료일</td>
			<td>시작예정일</td>
			<td>종료예정일</td>
		</tr>	
<%
	while(it.hasNext()){
		vo = (ConstructionVO)it.next();
		if(vo.getConCode() !=0){
%>
	<tr>
		<td><%=vo.getConCode() %></td>
		<td><%=vo.getConName() %></td>
		<td><%=vo.getStartDate() %></td>
		<td><%=vo.getEndDate() %></td>
		<td><%=vo.getExpStartDate() %></td>
		<td><%=vo.getExpEndDate() %></td>
	</tr>
<%
		}
	}
%>
	</table>
</div>
</form>
</body>
</html>