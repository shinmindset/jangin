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
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>현장 입력</title>
<script type="text/javascript">

	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['ContructionInfo'];		
		form.conName.value = "";
		form.startDate.value = ""
		form.endDate.value = ""
		form.expStartDate.value = ""
		form.expEndDate.value = ""
	}
</script>
</head>
<body>
<form action="constructionInsert.jsp" name="ConstructionInfo" method="post">
<div>
	<table border="1">
		<tr>
			<td>현장명</td>
			<td>시작일</td>
			<td>종료일</td>
			<td>시작예정일</td>
			<td>종료예정일</td>
		</tr>	
	<tr>
		<td><input type="text" name="conName"></td>
		<td><input type="text" name="startDate"></td>
		<td><input type="text" name="endDate"></td>
		<td><input type="text" name="expStartDate"></td>
		<td><input type="text" name="expEndDate"></td>
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