<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "item.itemDao.ItemDao" %>
<%@ page import = "item.itemVO.ItemVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 입력</title>
<script type="text/javascript">	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['ItemInfo'];		
		form.itemName.value = "";
		form.qtt.value = ""
		
	}
</script>

</head>
<body>
<form action="itemInsert.jsp" name="ItemInfo" method="post">
<div>
<table border="1">
	<tr>
		<td>자재명</td>
		<td>수량</td>
	</tr>
	<tr>
		<td><input type="text" name="itemName"></td>
		<td><input type="text" name="qtt"></td>
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