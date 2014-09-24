<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> 
<%@ page import = "work.workDao.WorkDao" %>
<%@ page import = "work.workVO.WorkVO" %>
<%@ page import = "work.workVO.WorkDoneVO" %>
<%@ page import = "work.workVO.WorkEmpVO" %>
<%@ page import = "work.workVO.WorkItemVO" %>
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
<%
	request.setCharacterEncoding("UTF-8");
	
	String workDate = request.getParameter("date");
	String construction = request.getParameter("construction");
	
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
 	
 	Iterator it = null;
 	Iterator empIt = null;
 	Iterator itemIt = null;
	
	//현장명으로 현장코드 가지고 오기 
	ConstructionDao conDao = new ConstructionDao();
	ConstructionVO conVO = new ConstructionVO();
	conVO.setConName(construction);
	
	int conCode = conDao.get(conn, conVO).getConCode();
	
	//날씨, 작성자, 비고, 날짜, 현장명 
	WorkDao workDao = new WorkDao();
 	WorkVO work = new WorkVO();
	 	
	work.setConCode(conCode);
	work.setWorkDate(workDate);
	WorkVO workVO = new WorkVO();
	workVO = workDao.get(conn, work);
	
	//작업 내용 리스트
	WorkDoneVO  workDoneVO = new WorkDoneVO();
	it = workDao.getList(conn, workVO).iterator();
	
	//작업자 리스트 
	EmployeeVO empVO = new EmployeeVO();
	WorkEmpVO workEmpVO = new WorkEmpVO();
	empIt = workDao.getWorkEmpList(conn, workVO).iterator();
	EmployeeDao empDao = new EmployeeDao();
	
	
	//자재 리스트 
	ItemVO itemVO = new ItemVO();
	WorkItemVO workItemVO = new WorkItemVO();
	itemIt = workDao.getWorkItemList(conn, workVO).iterator();
	ItemDao itemDao = new ItemDao();
%>
<script type="text/javascript">

function create_excel() { /* 엑셀로 저장하기 */
	window.location.href = "../excel/dailyWorkExcel.jsp";
}

</script>
<title>일일 작업 일보 조회 </title>
</head>
<body>
<form action="../excel/dailyWorkExcel.jsp" name="DailyWorkInfo" method="post">
<input type="hidden" name="workDate" value=<%=workDate %> />
<input type="hidden" name="construction" value=<%=construction %> />
<input type="hidden" name="weather" value=<%=workVO.getWeather()  %> />
<input type="hidden" name="author" value=<%=workVO.getAuth() %> />
<input type="hidden" name="etc" value=<%=workVO.getETC() %> />

<table border="1" id="example">
	<div>
	<tr >
		<th rowspan="2">일일 작업일보 </th>
		<th rowspan="2">날씨 </th>
		<td rowspan="2"><%=workVO.getWeather() %></td>
		<th>작성자 </th>
		<td><%=workVO.getAuth() %></td>
	</tr>
	<tr >
		<th>날짜 </th>
		<td><%=workDate %></td>
	</tr>
	</div>
	<div>
		<tr>
			<th>현장</th>
			<td colspan="4"><%=construction %> </td>
		</tr>
	</div>
	<div>
		<tr>
			<th >작업내용 </th>
			<th colspan="2">오늘작업내용 </th>
			<th colspan="2">내일작업계획 </th>
		</tr>
<%
	while(it.hasNext()){
		workDoneVO = (WorkDoneVO)it.next();
		if(workDoneVO.getNo()!=0){
		
	 	String workDone = workDoneVO.getWorkDone();
	 	String expWorkDone = workDoneVO.getExpWorkDone();
	 	
	 	if(workDone == null){
	 		workDone ="";
	 	}
	 	if(expWorkDone == null){
	 		expWorkDone ="";
	 	}
	 	
%>
	<tr class = "item1">
		<td></td>
		<td colspan="2"><input type="text" name="workDone" id="number" value="<%=workDone%>" readonly></td>
		<td colspan="2"><input type="text" name="expWorkDone" id="number" value="<%=expWorkDone %>" readonly></td>
	</tr>
<%
		}
	}
%>
	</div>
	<div>
		<tr>
			<th>작업자명단 </th>
			<th colspan="2">오늘작업자 </th>
			<th colspan="2">내일작업자 </th>
		</tr>
<%
	while(empIt.hasNext()){
		workEmpVO = (WorkEmpVO)empIt.next();
		if(workEmpVO.getNo()!=0){

			String empName = "";
			String expEmpName = "";
			
			empVO.setEmpCode(workEmpVO.getEmpCode());
			System.out.println("check 1 "+workEmpVO.getEmpCode());
			if(workEmpVO.getEmpCode() != 0){
				empName= empDao.get(conn, empVO).getEmpName();
				System.out.println(empName);
			}else{
				empName = "";
			}
			
			empVO.setEmpCode(workEmpVO.getExpEmpCode());
			System.out.println("check 2 "+workEmpVO.getExpEmpCode());

			if(workEmpVO.getExpEmpCode() != 0){
				expEmpName= empDao.get(conn, empVO).getEmpName();
			}else{
				expEmpName = "";
			}
%>
	<tr class = "item2">
		<td></td>
		<td colspan="2"><input type="text" name="empName" id="number" value="<%=empName %>" readonly></td>
		<td colspan="2"><input type="text" name="expEmpName" id="number" value="<%=expEmpName %>" readonly></td>
	</tr>
<%
		}
	}
%>
	</div>
	<div>
		<tr>
			<th>자재반입 및 구매내역 </th>
			<th colspan="2">오늘자재반입 / 구매내역 </th>
			<th colspan="2">내일자재반입 / 구매예정계획 </th>
		</tr>
<%
	while(itemIt.hasNext()){
		workItemVO = (WorkItemVO)itemIt.next();
		/*
		if(workItemVO.getNo()!=0){
			itemVO.setItemCode(workItemVO.getItemCode());
			String itemName= itemDao.get(conn, itemVO).getItemName();
			itemVO.setItemCode(workItemVO.getExpItemCode());
			String expItemName= itemDao.get(conn, itemVO).getItemName();
		*/
		if(workItemVO.getNo()!=0){

			String itemName = "";
			String expItemName = "";
			
			itemVO.setItemCode(workItemVO.getItemCode());
			if(workItemVO.getItemCode() != 0){
				itemName= itemDao.get(conn, itemVO).getItemName();
				System.out.println(itemName);
			}else{
				itemName = "";
			}
			
			itemVO.setItemCode(workItemVO.getExpItemCode());

			if(workItemVO.getExpItemCode() != 0){
				expItemName= itemDao.get(conn, itemVO).getItemName();
			}else{
				expItemName = "";
			}

%>
	<tr class = "item1">
		<td></td>
		<td colspan="2"><input type="text" name="itemName" id="number" value="<%=itemName %>" readonly></td>
		<td colspan="2"><input type="text" name="expItemName" id="number" value="<%=expItemName %>" readonly></td>
	</tr>
<%
		}
	}
%>
	</div>
	<div>
		<tr>
			<th rowspan="2">현장특기사항 </th>
			<th colspan="4">현장에서 요청사항이나  사무실 전달사항 </th>
		</tr>
<%
	String etc = workVO.getETC();
	if(etc == null || etc.equals("")){
		etc ="없음";
	}
%>
		<tr>
			<td colspan="4"><%= etc %></td>
		</tr>
	</div>
	<div>
			<tr>
				<td><input type="submit" value="엑셀출력"/>
				<td><a href="dailyWorkSch.jsp">[전 화면으로]</a></td>
			</tr>
	</div>
</table>
</form>
</body>
</html>