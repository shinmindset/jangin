<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "construction.constructionDao.ConstructionDao" %>
<%@ page import = "construction.constructionVO.ConstructionVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="constructionVO" class="construction.constructionVO.ConstructionVO">
	<jsp:setProperty name="constructionVO" property="*" />
</jsp:useBean>
<%
	ConstructionDao dao = new ConstructionDao();
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	
	dao.add(conn, constructionVO);
	
	conn.close();
	
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>현장 저장</title>
</head>
<body>
현장 정보가 저장되었습니다. 
<br/>
<a href="constructionList.jsp">[목록 보기]</a>
</body>
</html>