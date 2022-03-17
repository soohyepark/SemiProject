<%@page import="member.MemberVo"%>
<%@page import="member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/member.js'></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
String mid = request.getParameter("mid");
MemberDao dao = new MemberDao();
MemberVo vo = dao.view(mid);

request.setAttribute("nowPage", nowPage);
request.setAttribute("findStr", findStr);
request.setAttribute("vo", vo);

%>
<div id="member">
	<h2>회원관리</h2>
	<hr/>
	<form name="frm_member" method="post">
		<label>아이디</label>
		<input type='text' name='mid' value='${vo.mid }' size='12' readonly/>
		<br/>
		<label>성명</label>
		<input type='text' name='irum' value='${vo.irum }' required="required"/>
		<br/>
		<label>연락처</label>
		<input type='text' name='phone' value='${vo.phone }' required="required"/>
		<br/>
		<label>주소</label>
		<input type='text' size='4' readonly name='zip' value='${vo.zip }'/>
		<input type='button' value='우편번호' name='btnZip'/>
		<br/>
		<label></label>
		<input type='text' size='60' name='address' value='${vo.address }' readonly/>
		<br/>
		<label>상세주소</label>
		<input type='text' size='60' name='address2' value='${vo.address2 }'required="required"/>
		<br/>
		<div class='btnZone'>
			<input type='button' value='수정후 저장' name='btnUpdate'/>
			<input type='button' value='목록' name='btnList'/>		
		</div>
		
		<c:choose>
			<c:when test="${empty vo.photo }">
				<img src="http://placehold.it/200x250" width='200' height='250' id='photo'/>
			</c:when>
			<c:otherwise>
				<img src='./upload/${vo.photo }' width='200' height='250' id='photo'/>
			</c:otherwise>
		</c:choose>
		
		
		
		<input type='file' name='btnPhoto'/>
		<input type='hidden' name='nowPage' value='${nowPage }'/>
		<input type='hidden' name='findStr' value='${findStr }'/>
		<input type='hidden' name='pwd' />
		<input type='hidden' name='delFile' value='${vo.photo }'/>
		
	</form>
<!-- 암호입력을 위한 모달창 형태로 -->
	<div id='id_check'>
		<form name='frm_pwd' method='post'>
			<div>수정하시려면 암호를 입력하세요.</div>
			<input type='password' name='inputPwd' id='inputPwd'/>
			<input type='button' value='확인'  id='btnPwd'/>
			<input type='button' value='취소' id='btnCancel'/>
		</form>
	</div>
</div>

<script>member()</script>
</body>
</html>