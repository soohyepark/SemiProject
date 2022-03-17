<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/member.js'></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
request.setAttribute("findStr", findStr);
request.setAttribute("nowPage", nowPage);
%>
<div id="member">
	<h2>회원관리</h2>
	<hr/>
	<form name="frm_member" method="post" >
		<label>아이디</label>
		<input type='text' name='mid' size='12' readonly />
		<input type='button' value='중복체크' name='btnIdCheck'/>
		<br/>
		<label>성명</label>
		<input type='text' name='irum' size='12' required="required"/>
		<br/>
		<label>암호</label>
		<input type='password' name='pwd' size='12' required="required"/>
		<label>암호확인</label>
		<input type='password' name='pwd2' size='12' />
		<output id='pwd_check'></output>
		<br/>
		<label>연락처</label>
		<input type='text' name='phone' required="required"/>
		<br/>
		<label>주소</label>
		<input type='text' size='4' readonly name='zip' />
		<input type='button' value='우편번호' name='btnZip'/>
		<br/>
		<label></label>
		<input type='text' size='60' name='address' required="required"/>
		<br/>
		<label>상세주소</label>
		<input type='text' size='60' name='address2' required="required"/>
		<br/>
		<div class='btnZone'>
			<input type='button' value='저장' name='btnSave'/>
			<input type='button' value='목록' name='btnList'/>		
		</div>
		<img src="http://placehold.it/200x250" width='200' height='250' id='photo'/>
		<input type='file' name='btnPhoto'/>
		
		<input type='hidden' name='nowPage' value='${nowPage }'/>
		<input type='hidden' name='findStr' value='${findStr }'/>
	</form>
</div>
<script>member()</script>
</body>
</html>