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
<%
	String code = request.getParameter("iCode");
	int eCode=0;
	String eName = request.getParameter("iName");
	
	ItemDao dao = new ItemDao();
	ItemVO vo = new ItemVO();
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	
	Iterator it = null;
	
	if (code != null && eName == null) {
		eCode = Integer.parseInt(code);
		vo.setItemCode(eCode);
		vo = dao.get(conn, vo);
		List<ItemVO> lt = new ArrayList<ItemVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code == null && eName != null){
		vo.setItemName(eName);
		vo = dao.get(conn, vo);
		List<ItemVO> lt = new ArrayList<ItemVO>();
		lt.add(vo);
		it = lt.iterator();
	}else if(code != null && eName != null){
		eCode = Integer.parseInt(code);
		vo.setItemCode(eCode);
		vo.setItemName(eName);
		vo = dao.get(conn, vo);
		List<ItemVO> lt = new ArrayList<ItemVO>();
		lt.add(vo);
		it = lt.iterator();
	}else{
		it = dao.getList(conn).iterator();
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 조회</title>
<script type="text/javascript">
// 조회버튼 클릭
	function fn_search(){
		var form = document.forms['ItemInfo'];
		if(form.itemCodeSch.value != "" && form.itemNameSch.value ==""){
			form.action = 'itemList.jsp?iCode='+form.itemCodeSch.value;
		}else if(form.itemCodeSch.value == "" && form.itemNameSch.value !=""){
			form.action = 'itemList.jsp?iName='+form.itemNameSch.value;
		}
		else if(form.itemCodeSch.value != "" && form.itemNameSch.value !=""){
			form.action = 'itemList.jsp?iCode='+form.itemCodeSch.value+'&iName='+form.itemNameSch.value;
		}
		form.submit();
	}

	

	// 초기화버튼 클릭
	function fn_cancel(){
		var form = document.forms['ItemInfo'];		
		form.itemCodeSch.value = "";
		form.itemNameSch.value = ""
		
	}
</script>

</head>
<body>
<form name="ItemInfo" method="post">
<div class="search">
		<table border="1">
			<tr>		  
		    <th>자재코드</th>
		    <td><input name="itemCodeSch" type="text"/ ></td>
		    <th>자재명</th>
		    <td><input name="itemNameSch" type="text"	 /></td>
		  </tr>
		  <tr>
		  	<th></th>
		  	<td></td>
		    <th></th>
		    <td></td>
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
		<td>자재코드</td>
		<td>자재명</td>
		<td>수량</td>
	</tr>
<%
	while(it.hasNext()){
		vo = (ItemVO)it.next();
		if(vo.getItemCode()!=0){
%>
	<tr>
		<td><%=vo.getItemCode() %></td>
		<td><%=vo.getItemName() %></td>
		<td><%=vo.getQtt() %></td>
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