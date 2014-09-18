<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import = "work.workDao.WorkDao" %>
<%@ page import = "work.workDao.WorkEmpDao" %>
<%@ page import = "work.workDao.WorkItemDao" %>
<%@ page import = "work.workDao.WorkDoneDao" %>
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
%>

<%
	//파라미터 받아오기 
	String auth = request.getParameter("auth");
	String workDate = request.getParameter("workDate");
	String conName = request.getParameter("conName");
	String weather = request.getParameter("weather");
	String etc = request.getParameter("etc");

	String[] workDone = request.getParameterValues("workDone");
	String[] expWorkDone = request.getParameterValues("expWorkDone");
	
	String[] empName = request.getParameterValues("empName");
	String[] expEmpName = request.getParameterValues("expEmpName");
	
	String[] itemName = request.getParameterValues("itemName");
	String[] expItemName = request.getParameterValues("expItemName");
	/*
	System.out.println("length : "+itemName.length);
	System.out.println("a length : "+expItemName.length);
	
	for(int i=0;i<itemName.length;i++){
		System.out.println("itemName : "+itemName[i]);
	}
	*/
	//코넥션 연결하기 
	Connection conn = null;
	conn = ConnectionProvider.getConnection();
	//conn.setAutoCommit(false);
	
	//1. 현장 코드 찾아오기 
	ConstructionDao dao = new ConstructionDao();
	ConstructionVO vo = new ConstructionVO();
	
	vo.setConName(conName);
	String name = dao.get(conn, vo).getConName();
	int conCode = dao.get(conn, vo).getConCode();
	if(conCode == 0){
		vo.setConName(conName);
		dao.add(conn, vo);
		System.out.println("new conCode made");
	}
	conCode = dao.get(conn, vo).getConCode();
	System.out.println("conCode is : "+conCode);
	
	//2. work table에 값 넣기 (현장이름, 현장코드, 날짜, 날씨, 작성자, 비고 )
	WorkDao workDao = new WorkDao();
	WorkVO workVO = new WorkVO();
	workVO.setConCode(conCode);
	workVO.setWeather(weather);
	workVO.setAuth(auth);
	workVO.setWorkDate(workDate);
	workVO.setETC(etc);
	workDao.add(conn, workVO);
	System.out.println("values inserted into WORK table.");
	//work 테이블에서 익덱스 가지고 오기 
	int no = workDao.get(conn, workVO).getNo();
	System.out.println("work table indext no :"+ no);
	
	//3. 작업내용 
	WorkDoneDao workDoneDao = new WorkDoneDao();
	WorkDoneVO workDoneVO = null;
	WorkDoneVO expWorkDoneVO = null;
	//오늘 작업과 내일 예정작업의 길이 구하기.
	int wDLengthCheck =0;
	int expWDLengthChk =0;
	for(int i=0;i<workDone.length;i++){
		if(!workDone[i].equals("")){
			wDLengthCheck++;
		}
	}
	
	for(int i=0;i<expWorkDone.length;i++){
		if(!expWorkDone[i].equals("")){
			expWDLengthChk++;
		}
	}
	
	//--체크해라. 오늘작업과 내일작업의 개수가 서로 다를 때 에러가 나는지....
	if(wDLengthCheck >= expWDLengthChk){
		System.out.println("number of today work is the same or bigger than tomorrow's.");
		
		for(int i=0;i<wDLengthCheck;i++){
			workDoneVO = new WorkDoneVO();
			expWorkDoneVO = new WorkDoneVO();
			
			workDoneVO.setNoFk(no);
			workDoneVO.setConCode(conCode);
			workDoneVO.setWorkDate(workDate);
			workDoneVO.setWorkDone(workDone[i]);
			if(!expWorkDone[i].equals("")){
				workDoneVO.setExpWorkDone(expWorkDone[i]);
			}
			workDoneDao.add(conn, workDoneVO);
			System.out.println("1. values inserted into WORKDONE table.");
		}
	}else{
		System.out.println("number of tomorrow work is the same or bigger than today's.");
		for(int i=0;i<expWDLengthChk;i++){
			workDoneVO = new WorkDoneVO();
			expWorkDoneVO = new WorkDoneVO();
			
			workDoneVO.setNoFk(no);
			workDoneVO.setConCode(conCode);
			workDoneVO.setWorkDate(workDate);
			workDoneVO.setExpWorkDone(expWorkDone[i]);
			if(!workDone[i].equals("")){
				workDoneVO.setWorkDone(workDone[i]);
			}
			workDoneDao.add(conn, workDoneVO);
			System.out.println("2 .values inserted into WORKDONE table. ");
		}	
		
	}
	
	
	//4. 작업자 명단
	EmployeeDao empDao = new EmployeeDao();
	EmployeeVO empVO = new EmployeeVO();
	EmployeeVO expEmpVO = new EmployeeVO();
	WorkEmpDao workEmpDao = new WorkEmpDao();
	WorkEmpVO workEmpVO = new WorkEmpVO();
	conn = ConnectionProvider.getConnection();
	
	//오늘 작업과 내일 예정작업의 길이 구하기.
	System.out.println(" EMP INFO Search");
		int empLengthCheck =0;
		int expEmpLengthChk =0;
		for(int i=0;i<empName.length;i++){
			if(!empName[i].equals("")){
				System.out.println(empName[i]);
				empLengthCheck++;
			}
		}
		
		for(int i=0;i<expEmpName.length;i++){
			if(!expEmpName[i].equals("")){
				System.out.println(expEmpName[i]);
				expEmpLengthChk++;
			}
		}
		System.out.println("4. empLengthCheck :"+empLengthCheck);
		System.out.println("4 .expEmpLengthChk : "+expEmpLengthChk);
	
	if(empLengthCheck >= expEmpLengthChk){
		System.out.println("the number of today work imployee is the same or bigger than tommorow's.");
		for(int i=0;i<empLengthCheck;i++){
			//오늘 작업자 
			empVO.setEmpName(empName[i]);
			empVO = empDao.get(conn, empVO);
			//int empCode = empDao.get(conn, empVO).getEmpCode();
			//employee table에 직원이 코드, 이름이 없을 경우 employee테이블에 저장 
			
			workEmpVO.setConCode(conCode);
			workEmpVO.setNoFk(no);
			workEmpVO.setWorkDate(workDate);
			workEmpVO.setEmpCode(empVO.getEmpCode());
			System.out.println("empVO.getEmpCode() : "+empVO.getEmpCode());
			
			if(empVO.getEmpCode()==0){
			//if(empCode==0){
				//이거 풀어줘야함 
				empVO.setEmpName(empName[i]);
				empDao.add(conn, empVO);
				System.out.println("1 No today employee recode. insert info.");
				workEmpVO.setEmpCode(empDao.get(conn, empVO).getEmpCode());
			}
			
			
			//내일 작업 예정자 
			System.out.println("1. tomorrow workers");
			if(!expEmpName[i].equals("") || expEmpName[i] != null){
				expEmpVO.setEmpName(expEmpName[i]);
				expEmpVO = empDao.get(conn,expEmpVO);
				if(expEmpVO.getEmpCode()==0){
					//여기 풀어줘야함.
					expEmpVO.setEmpName(expEmpName[i]);
					empDao.add(conn, expEmpVO);
					System.out.println("1. No tmr employee info. insert info.");
					workEmpVO.setExpEmpCode(empDao.get(conn, expEmpVO).getEmpCode());
				}else{
					workEmpVO.setExpEmpCode(expEmpVO.getEmpCode());
				}
			}
			//오늘 작업자, 작업 예정자 저장 
			workEmpDao.add(conn, workEmpVO);
			System.out.println("saved in workEmp table.");
		}
	}
	else{
		System.out.println("today work employee is less than tmr's.");
		for(int i=0;i<expEmpLengthChk;i++){
			//내일 작업자 
			expEmpVO.setEmpName(expEmpName[i]);
			expEmpVO = empDao.get(conn, expEmpVO);

			workEmpVO.setConCode(conCode);
			workEmpVO.setNoFk(no);
			workEmpVO.setWorkDate(workDate);
			workEmpVO.setExpEmpCode(expEmpVO.getEmpCode());
			
			//employee table에 직원이 코드, 이름이 없을 경우 employee테이블에 저장 
			if(expEmpVO.getEmpCode()==0){
				//여기 풀어줘야함.
				expEmpVO.setEmpName(expEmpName[i]);
				empDao.add(conn, expEmpVO);
				System.out.println("2. No tmr emp info.");
				workEmpVO.setExpEmpCode(empDao.get(conn, expEmpVO).getEmpCode());
			}
			
			//오늘 작업 예정자 
			System.out.println("AAAAA. today workers");
			if(!empName[i].equals("") || empName[i] != null){
				empVO.setEmpName(empName[i]);
				empVO = empDao.get(conn,empVO);
				if(empVO.getEmpCode()==0){
					empVO.setEmpName(empName[i]);
					empDao.add(conn, empVO);
					System.out.println("2. No today's emp info. should insert it.");
					workEmpVO.setEmpCode(empDao.get(conn, empVO).getEmpCode());
				}else{
					workEmpVO.setEmpCode(empVO.getEmpCode());
				}
			}
			//오늘 작업자, 작업 예정자 저장 
			workEmpDao.add(conn, workEmpVO);
		}
		
	}
	
	
	//5. 자재 
	ItemDao itemDao = new ItemDao();
	ItemVO itemVO = new ItemVO();
	ItemVO expItemVO = new ItemVO();
	WorkItemDao workItemDao = new WorkItemDao();
	WorkItemVO workItemVO = new WorkItemVO();
	
	//오늘 작업과 내일 예정작업의 길이 구하기.
	int itemLengthCheck =0;
	int expItemLengthChk =0;
	for(int i=0;i<itemName.length;i++){
		if(!itemName[i].equals("")){
			System.out.println(itemName[i]);
			itemLengthCheck++;
		}
	}
			
	for(int i=0;i<expItemName.length;i++){
			if(!expItemName[i].equals("")){
				System.out.println(expItemName[i]);
				expItemLengthChk++;
			}
		}
	System.out.println("itemLengthCheck :"+itemLengthCheck);
	System.out.println("expItemLengthChk : "+expItemLengthChk);
			
	if(itemLengthCheck >= expItemLengthChk){
			System.out.println("the number of today work Item is the same or bigger than tommorow's.");
			for(int i=0;i<itemLengthCheck;i++){
				//오늘 item
				itemVO.setItemName(itemName[i]);
				itemVO = itemDao.get(conn, itemVO);
				//item table에 item 코드, 이름이 없을 경우 item 테이블에 저장 
					
				workItemVO.setConCode(conCode);
				workItemVO.setNoFk(no);
				workItemVO.setWorkDate(workDate);
				workItemVO.setItemCode(itemVO.getItemCode());
				System.out.println("itemVO.getItemCode() : "+itemVO.getItemCode());
					
				if(itemVO.getItemCode()==0){
				//if(empCode==0){
					//이거 풀어줘야함 
					itemVO.setItemName(itemName[i]);
					itemDao.add(conn, itemVO);
					System.out.println("1 No today item recode. insert info.");
					workItemVO.setItemCode(itemDao.get(conn, itemVO).getItemCode());
				}
					
					
					//내일 item 예정자 
					System.out.println("1. tomorrow Items");
					if(!expItemName[i].equals("") || expItemName[i] != null){
						expItemVO.setItemName(expItemName[i]);
						expItemVO = itemDao.get(conn,expItemVO);
						if(expItemVO.getItemCode()==0){
							//여기 풀어줘야함.
							expItemVO.setItemName(expItemName[i]);
							itemDao.add(conn, expItemVO);
							System.out.println("1. No tmr item info. insert info.");
							workItemVO.setExpItemCode(itemDao.get(conn, expItemVO).getItemCode());
						}else{
							workItemVO.setExpItemCode(expItemVO.getItemCode());
						}
					}
					//오늘 작업자, 작업 예정자 저장 
					workItemDao.add(conn, workItemVO);
					System.out.println("saved in workImp table.");
				}
			}
			else{
				System.out.println("today work item is less than tmr's.");
				for(int i=0;i<expItemLengthChk;i++){
					//내일 작업자 
					expItemVO.setItemName(expItemName[i]);
					expItemVO = itemDao.get(conn, expItemVO);

					workItemVO.setConCode(conCode);
					workItemVO.setNoFk(no);
					workItemVO.setWorkDate(workDate);
					workItemVO.setExpItemCode(expItemVO.getItemCode());
					
					//item table에 item이 코드, 이름이 없을 경우 item테이블에 저장 
					if(expItemVO.getItemCode()==0){
						//여기 풀어줘야함.
						expItemVO.setItemName(expItemName[i]);
						itemDao.add(conn, expItemVO);
						System.out.println("2. No tmr item info.");
						workItemVO.setExpItemCode(itemDao.get(conn, expItemVO).getItemCode());
					}
					
					//오늘 작업 예정자 
					System.out.println("AAAAA. today item");
					if(!itemName[i].equals("") || itemName[i] != null){
						itemVO.setItemName(itemName[i]);
						itemVO = itemDao.get(conn,itemVO);
						if(itemVO.getItemCode()==0){
							itemVO.setItemName(itemName[i]);
							itemDao.add(conn, itemVO);
							System.out.println("2. No today's item info. should insert it.");
							workItemVO.setItemCode(itemDao.get(conn, itemVO).getItemCode());
						}else{
							workItemVO.setItemCode(itemVO.getItemCode());
						}
					}
					//오늘 item, item 예정자 저장 
					workItemDao.add(conn, workItemVO);
				}
				
			}
	/*		
	if(itemLengthCheck >= expItemLengthChk){
		System.out.println("the number of today work item is the same or bigger than tommorow's.");
		
		for(int i=0;i<itemLengthCheck;i++){
			//오늘 작업자 
			itemVO.setItemName(itemName[i]);
			itemVO = itemDao.get(conn, itemVO);
			//employee table에 직원이 코드, 이름이 없을 경우 employee테이블에 저장 
			if(itemVO.getItemCode()==0){
				//이거 풀어줘야함 
				itemDao.add(conn, itemVO);
				System.out.println("1 No today Item recode. insert info.");
			}
			
			workItemVO.setConCode(conCode);
			workItemVO.setNoFk(no);
			workItemVO.setWorkDate(workDate);
			workItemVO.setItemCode(itemVO.getItemCode());
			
			//내일 작업 예정자 
			if(!expEmpName[i].equals("")){
				itemVO.setItemName(expItemName[i]);
				itemVO = itemDao.get(conn,itemVO);
				if(itemVO.getItemCode()==0){
					//여기 풀어줘야함.
					empDao.add(conn, empVO);
					System.out.println("1. No tmr Item info. insert info.");
				}
				workItemVO.setExpItemCode(itemVO.getItemCode());
			}
			//오늘 작업자, 작업 예정자 저장 
			workEmpDao.add(conn, workEmpVO);
			System.out.println("saved in workItem table.");
		}
	}else{
		System.out.println("today work item is less than tmr's.");
		for(int i=0;i<expItemLengthChk;i++){
			//내일 작업자 
			itemVO.setItemName(expItemName[i]);
			itemVO = itemDao.get(conn, itemVO);
			//item table에 item 코드, 이름이 없을 경우 item table 저장 
			if(itemVO.getItemCode()==0){
				//여기 풀어줘야함.
				itemDao.add(conn, itemVO);
				System.out.println("2. No tmr item info.");
			}
			
			workItemVO.setConCode(conCode);
			workItemVO.setNoFk(no);
			workItemVO.setWorkDate(workDate);
			workItemVO.setExpItemCode(itemVO.getItemCode());
			
			//오늘 작업 예정자 
			if(!itemName[i].equals("")){
				itemVO.setItemName(itemName[i]);
				itemVO = itemDao.get(conn,itemVO);
				if(itemVO.getItemCode()==0){
					itemDao.add(conn, itemVO);
					System.out.println("2. No today's emp info. should insert it.");
				}
				workItemVO.setItemCode(itemVO.getItemCode());
			}
			//오늘 작업자, 작업 예정자 저장 
			workItemDao.add(conn, workItemVO);
		}
		
	}
	*/
	conn.close();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>dailyWorkDone</title>
</head>
<body>
저장되었습니다.
<%= name %>
<br/>
<%= conCode %>
<br/>
<a href="dailyWorkSch.jsp">[목록 보기]</a>
</body>
</html>