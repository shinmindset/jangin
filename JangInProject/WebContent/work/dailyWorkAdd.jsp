<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script> 
<script type="text/javascript"> 

          $(document).ready(function(){ 

                 // 항목추가 버튼 클릭시 

                 $(".addBtn").click(function(){ 


                	 	var clickedRow = $(this).parent().parent(); 

                        var cls = clickedRow.attr("class"); 

                        // tr 복사해서 마지막에 추가 

                        var newrow = clickedRow.clone(); 

                        newrow.find("td:eq(0)").remove(); 

                        newrow.insertAfter($("#example ."+cls+":last")); 

                        // rowspan 증가 

                        resizeRowspan(cls); 

                 }); 

                   

                   

                 // 삭제버튼 클릭시 

                 $(".delBtn").live("click", function(){ 

                        var clickedRow = $(this).parent().parent(); 

                        var cls = clickedRow.attr("class"); 

                          

                        // 각 항목의 첫번째 row를 삭제한 경우 다음 row에 td 하나를 추가해 준다. 

                        if( clickedRow.find("td:eq(0)").attr("rowspan") ){ 

                               if( clickedRow.next().hasClass(cls) ){ 

                                      clickedRow.next().prepend(clickedRow.find("td:eq(0)")); 

                               } 

                        } 

                        clickedRow.remove(); 

                        resizeRowspan(cls); 

                 }); 

                 // cls : rowspan 을 조정할 class ex) item1, item2, ... 

                 function resizeRowspan(cls){ 

                        var rowspan = $("."+cls).length; 

                        $("."+cls+":first td:eq(0)").attr("rowspan", rowspan); 

                 } 

          }); 

          function rem() { 

       $("#example tr:last").remove(); 

          } 

    </script> 
<title>일일 작업 일보 조회 </title>
</head>
<body>
<form action="dailyWorkInsert.jsp" name="DailyWorkInfo" method="post" >
<div>
<table border="1" id="example">
	<div>
	<tr >
		<th rowspan="2">일일 작업일보 </th>
		<th rowspan="2">날씨 </th>
		<td rowspan="2"><input type="text" name="weather"> </td>
		<th>작성자 </th>
		<td><input type ="text" name="auth"></td>
	</tr>
	<tr >
		<th>날짜 </th>
		<td><input type ="text" name="workDate"></td>
	</tr>
	</div>
	<div>
		<tr>
			<th>현장</th>
			<td colspan="4"><input type="text" name="conName"> </td>
		</tr>
	</div>
	<div>
		<tr>
			<th >작업내용 </th>
			<th colspan="2">오늘작업내용 </th>
			<th colspan="2">내일작업계획 </th>
		</tr>
		<tr class="item1">
			<td><input type="button" value="작업내용 추가" class="addBtn"></td>
			<td colspan="2"><input type = "text" name="workDone"></td>
			<td colspan="2"><input type = "text" name="expWorkDone"></td>
		</tr>
	</div>
	<div>
		<tr>
			<th>작업자명단 </th>
			<th colspan="2">오늘작업자 </th>
			<th colspan="2">내일작업자 </th>
		</tr>
		<tr class="items">
			<td><input type="button" value="작업자 추가"  class="addBtn"></td>
			<td colspan="2"><input type = "text" name="empName"></td>
			<td colspan="2"><input type = "text" name="expEmpName"></td>
		</tr>
	</div>
	<div>
		<tr>
			<th>자재반입 및 구매내역 </th>
			<th colspan="2">오늘자재반입 / 구매내역 </th>
			<th colspan="2">내일자재반입 / 구매예정계획 </th>
		</tr>
		<tr class="item3">
			<td><input type="button" value="자재반입추가" class="addBtn"></td>
			<td colspan="2"><input type = "text" name="itemName"></td>
			<td colspan="2"><input type = "text" name="expItemName"></td>
		</tr>
	</div>
	<div>
		<tr>
			<th rowspan="2">현장특기사항 </th>
			<th colspan="4">현장에서 요청사항이나  사무실 전달사항 </th>
		</tr>
		<tr>
			<td colspan="4"><input type="text" name="etc"></td>
		</tr>
	</div>
	<div>
			<tr>
				<td><input type="submit" value="저장하기" />
				<td><input type="button" value="초기화" onclick="javascript:fn_cancel();" ></td>
			</tr>
	</div>
</table>
</div>
</form>
</body>
</html>