<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>로그인 페이지</title>
<script language="javascript">
	function Login() {
		if (checkId()) {
			saveLogin(document.loginForm.userid.value);
			var form = document.forms['loginForm'];
			form.submit();
		}
	}
	
	//로그인정보체크
	function checkId() {
		with (document.forms[0]) {
			if (userid.value.replace(/ /g, "") == "") {
				alert("아이디를 입력하세요");
				return false;
			}
			if (password.value.replace(/ /g, "") == "") {
				alert("패스워드를 입력하세요");
				return false;
			}
		}
		return true;
	}

	// 로그인 정보 저장
	function confirmSave(checkbox) {
		var isRemember;
		// 로그인 정보 저장한다고 선택할 경우
		if (checkbox.checked) {
			isRemember = confirm("이 PC에 로그인 정보를 저장하시겠습니까? \n공공장소에서는 개인정보가 유출될 수 있으니 주의해주십시오.");
			if (!isRemember) {
				checkbox.checked = false;
			}
		}
	}

	// 쿠키값 가져오기
	function getnull(key) {
		var cook = document.cookie + ";";
		var idx = cook.indexOf(key, 0);
		var val = "";

		if (idx != -1) {
			cook = cook.substring(idx, cook.length);
			begin = cook.indexOf("=", 0) + 1;
			end = cook.indexOf(";", begin);
			val = unescape(cook.substring(begin, end));
		}
		return val;
	}

	// 쿠키값 설정
	function setnull(name, value, expiredays) {
		var today = new Date();
		today.setDate(today.getDate() + expiredays);
		document.cookie = name + "=" + escape(value) + "; path=/; expiress="
				+ today.toGMTString() + ";"
	}

	// 쿠키에서 로그인 정보 가져오기
	function getLogin() {
		var frm = document.loginForm;

		// userid 쿠키에서 id 값을 가져온다.
		var id = getnull("mandoUserid");

		// 가져온 쿠키값이 있으면
		if (id != "") {
			document.loginForm.userid.value = id;
			document.loginForm.password.focus();
		}
	}

	// 쿠키에 로그인 정보 저장
	function saveLogin(id) {
		if (id != "") {
			// userid 쿠키에 id 값을 7일간 저장
			setnull("mandoUserid", id, 7);
		} else {
			// userid 쿠키 삭제
			setnull("mandoUserid", id, -1);
		}
	}

	//엔터키
	function enterkey() {
		if (event.keyCode == 13) {
			Login();
		}
	}
</script>
</head>
<body onload="getLogin()" class="login_body" onkeydown="enterkey()">
	<form name="loginForm" method="post" action="loginAction.jsp">
		<input type="hidden" name="no_company" value="" />
		<div id="wrap_login">
			<div id="login">
				<div id="login_form_id">
					<td>아이디</td>
					<input type="text" name="userid" id="number" value="" size="15"	class="forms_input01">
				</div>
				<div id="login_form_pw">
					<td>패스워드</td>
					<input type="password" name="password" id="number" value=""	size="15" class="forms_input01">
				</div>
				<div id="login_form_button">
					<input type="button" value="확인" alt="회원로그인" border="0" style="cursor: pointer;" onclick="Login();"/>
				</div>
			</div>
		</div>
	</form>
</body>
</html>