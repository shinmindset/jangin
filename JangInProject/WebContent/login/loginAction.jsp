<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "login.loginDao.LogInDao" %>
<%@ page import = "login.loginVO.LogInVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	
	String id = request.getParameter("userid");
	String pw = request.getParameter("password");
	String path = null;
	
	//코넥션 연결하기 
		Connection conn = null;
		conn = ConnectionProvider.getConnection();
		//conn.setAutoCommit(false);
		
		//1. 
		LogInVO login = new LogInVO();
		LogInDao dao = new LogInDao();
		/*
		login = dao.get(conn, login);
		if(login.getUserId() != null || !(login.getUserId().equals(""))){
			//path = "/main.jsp";
			response.sendRedirect("/main.jsp");
		}
		*/
		
		if(id.equals("") && pw.equals("")){
			response.sendRedirect("../main.jsp");
		}else{
		
		
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 실패</title>
</head>
<body>
잘못된 아이디, 패스워드 입니다.
</body>
</html>
<%
		}
%>