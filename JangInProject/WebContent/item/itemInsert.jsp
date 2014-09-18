<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "item.itemDao.ItemDao" %>
<%@ page import = "item.itemVO.ItemVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="itemVO" class="item.itemVO.ItemVO">
	<jsp:setProperty name="itemVO" property="*" />
</jsp:useBean>
<%
	ItemDao dao = new ItemDao();
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	
	System.out.println(itemVO.getItemCode());
	System.out.println(itemVO.getItemName());
	System.out.println(itemVO.getQtt());
	
	int orderedQtt = itemVO.getQtt();
	
	int qtt = dao.get(conn, itemVO).getQtt();
	
	if(qtt>0){
		int lastQtt = orderedQtt + qtt;
		System.out.println("q>0 : "+lastQtt);
		itemVO.setQtt(lastQtt);
		dao.update(conn, itemVO);
	}else{
		System.out.println(itemVO.getQtt());
		dao.add(conn, itemVO);
	}
	
	conn.close();
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>자재 저장</title>
</head>
<body>
자재가 저장되었습니다.
<br/>
<a href="itemList.jsp">[목록 보기]</a>
</body>
</html>