<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> 
<script type="text/javascript">
	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['dailyWorkList'];		
		form.name.value = "";
		form.construction.value = ""
		
	}
	
	

</script>
<title>일일 작업 일보 조회 </title>
</head>
<body>
<form action="dailyWorkList.jsp" name="DailyWorkInfo" method="post">
<table border="1" id="example">
	<div>
		<tr>
			<th>날짜 </th>
			<td><input type ="text" name="date"></td>
			<th>현장</th>
			<td><input type="text" name="construction"> </td>
		</tr>
	</div>
	<div>
			<tr>
				<td><input type="submit" value="조회하기" />
				<td><input type="button" value="초기화" onclick="javascript:fn_cancel();" ></td>
			</tr>
			<tr>
				<td><a href="../main.jsp">[전 화면으로]</a></td>
			</tr>
	</div>
</table>
</form>
</body>
</html>