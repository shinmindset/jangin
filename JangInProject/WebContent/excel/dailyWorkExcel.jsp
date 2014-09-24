<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "java.util.Date" %>
<%@ page import = "work.workDao.WorkDao" %>
<%@ page import = "work.workVO.WorkVO" %>
<%@ page import = "work.workVO.WorkDoneVO" %>
<%@ page import = "work.workVO.WorkEmpVO" %>
<%@ page import = "work.workVO.WorkItemVO" %>
<%@ page import = "excel.excelVO.ExcelVO" %>
<%@ page import = "employee.employeeDao.EmployeeDao" %>
<%@ page import = "employee.employeeVO.EmployeeVO" %>
<%@ page import = "item.itemDao.ItemDao" %>
<%@ page import = "item.itemVO.ItemVO" %>
<%@ page import = "construction.constructionDao.ConstructionDao" %>
<%@ page import = "construction.constructionVO.ConstructionVO" %>
<%@ page import = "jdbc.connection.ConnectionProvider" %>
<%@ page import = "com.mysql.jdbc.Connection" %>
<%@ page import = "java.util.Iterator" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.util.ArrayList" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");
	
	String workDate = request.getParameter("workDate");
	String construction = request.getParameter("construction");
	String weather = request.getParameter("weather");
	String author = request.getParameter("author");
	String etc = request.getParameter("etc");
	
	String[] workDone = request.getParameterValues("workDone");
	String[] expWorkDone = request.getParameterValues("expWorkDone");
	String[] empName = request.getParameterValues("empName");
	String[] expEmpName = request.getParameterValues("expEmpName");
	String[] itemName = request.getParameterValues("itemName");
	String[] expItemName = request.getParameterValues("expItemName");
	
	int length =0;
	if(workDone.length >= empName.length ){
		length = workDone.length;
	}else{
		length = empName.length;
	}
	if(itemName.length >= length){
		length = itemName.length;
	}
	
	List<ExcelVO> list = new ArrayList<ExcelVO>();
	ExcelVO[] excelVO = new ExcelVO[length];
	
	for(int i=0;i<=length-1;i++){
		System.out.println("i : "+i);
		
		excelVO[i] = new ExcelVO();
		
		if(i==0){
			excelVO[0].setAuthor(author);
			excelVO[0].setConstruction(construction);
			excelVO[0].setWeather(weather);
			excelVO[0].setWorkDate(workDate);
			excelVO[0].setEtc(etc);
		}
		
		if(i<workDone.length){
			excelVO[i].setWorkDone(workDone[i]);
		}
		if(i<expWorkDone.length){
			excelVO[i].setExpWorkDone(expWorkDone[i]);
		}
		if(i<empName.length){
			excelVO[i].setEmpName(empName[i]);
		}
		if(i<expEmpName.length){
			excelVO[i].setExpEmpName(expEmpName[i]);
		}
		if(i<itemName.length){
			excelVO[i].setItemName(itemName[i]);
		}
		if(i<expItemName.length){
			excelVO[i].setExpItemName(expItemName[i]);
		}
	}
	

	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy_MM_dd_HH_mm_ss");

	String today = formatter.format(new java.util.Date());

	String file_name = "dailyWork_"+today;

	String ExcelName  = new String(file_name.getBytes("8859_1"),"UTF-8")+".xls";

	response.setContentType("application/vnd.ms-excel"); 

	response.setHeader("Content-Disposition", "attachment; filename="+ExcelName); 
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>엑셀 다운로드</title>
</head>
<body>
<table border=1>
<tr bgcolor="#CACACA">
<th>날짜 </th>
<th>작성자</th>
<th>날씨</th>
<th>작업내용</th>
<th>내일작업계획</th>
<th>오늘작업자</th>
<th>내일작업자</th>
<th>오늘자재반입/구매내역</th>
<th>내일자재반입/구매예정내역</th>
<th>현장특기사항</th>
</tr>
<%
for(int i=0;i<=length-1;i++){
	String getWorkDate="";
	if(excelVO[i].getWorkDate()!=null){
		getWorkDate=excelVO[i].getWorkDate();
	}
	String getAuthor="";
	if(excelVO[i].getAuthor()!=null){
		getAuthor=excelVO[i].getAuthor();
	}
	String getWeather="";
	if(excelVO[i].getWeather()!=null){
		getWeather=excelVO[i].getWeather();
	}
	String getWorkDone="";
	if(excelVO[i].getWorkDone()!=null){
		getWorkDone=excelVO[i].getWorkDone();
	}
	String getExpWorkDone="";
	if(excelVO[i].getExpWorkDone()!=null){
		getExpWorkDone=excelVO[i].getExpWorkDone();
	}
	String getEmpName="";
	if(excelVO[i].getEmpName()!=null){
		getEmpName=excelVO[i].getEmpName();
	}
	String getExpEmpName="";
	if(excelVO[i].getExpEmpName()!=null){
		getExpEmpName=excelVO[i].getExpEmpName();
	}
	String getItemName="";
	if(excelVO[i].getItemName()!=null){
		getItemName=excelVO[i].getItemName();
	}
	String getExpItemName="";
	if(excelVO[i].getExpItemName()!=null){
		getExpItemName=excelVO[i].getExpItemName();
	}
	String getEtc="";
	if(excelVO[i].getEtc()!=null){
		getEtc=excelVO[i].getEtc();
	}
%>       
<tr>
<td><%=getWorkDate %></td>
<td><%=getAuthor %></td>
<td><%=getWeather %></td>
<td><%=getWorkDone %></td>
<td><%=getExpWorkDone %></td>
<td><%=getEmpName %></td>
<td><%=getExpEmpName %></td>
<td><%=getItemName %></td>
<td><%=getExpItemName %></td>
<td><%=getEtc %> %></td>
</tr>
<%
	}
%>
</table>
</body>
</html>