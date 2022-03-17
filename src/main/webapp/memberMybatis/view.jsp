<%@page import="java.io.File"%>
<%@page import="memberMybatis.MemberVo"%>
<%@page import="memberMybatis.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>view</title>
<link rel='stylesheet' type='text/css' href='./css/member.css'>
<script src='./js/memberMybatis.js'></script>
</head>
<body>
<%
String findStr = request.getParameter("findStr");
String nowPage = request.getParameter("nowPage");
String mid = request.getParameter("mid");
MemberDao dao = new MemberDao();
MemberVo vo = dao.view(mid);

File file = new File(MemberDao.uploadPath + vo.getPhoto());
if(!file.exists()|| file.isDirectory()){
	file=null;
}

request.setAttribute("file", file);
request.setAttribute("findStr", findStr);
request.setAttribute("nowPage", nowPage);
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
		<input type='text' name='irum' value='${vo.irum }' readonly/>
		<br/>
		
		<label>연락처</label>
		<input type='text' name='phone' value='${vo.phone }' readonly/>
		<br/>
		<label>우편번호</label>
		<input type='text' size='4' readonly name='zip' value='${vo.zip }'/>
		<br/>
		<label>주소</label>
		<input type='text' size='60' name='address' value='${vo.address }' readonly/>
		<br/>
		<label>상세주소</label>
		<input type='text' size='60' name='address2' value='${vo.address2 }' readonly/>
		<br/>
		<div class='btnZone'>
			<input type='button' value='수정' name='btnModify'/>
			<input type='button' value='삭제' name='btnDelete'/>
			<input type='button' value='목록' name='btnList'/>		
		</div>
		
		<c:choose>
			<c:when test="${empty file }">
				<img src="http://placehold.it/200x250" />
			</c:when>
			<c:otherwise>
				<img src='./upload/${vo.photo }' width='200' height='250'/>
			</c:otherwise>
		</c:choose>
		<input type='file' name='photo'/>
		
		<input type='hidden' name='nowPage' value='${nowPage }'/>
		<input type='hidden' name='findStr' value='${findStr }'/>
		<input type='hidden' name='delFile' value='${vo.photo }'/>
		<input type='hidden' name='pwd'/>
	</form>
	
	<!-- 암호입력을 위한 모달창 형태로 -->
	<div id='id_check'>
		<form name='frm_pwd' method='post'>
			<div>삭제하시려면 암호를 입력하세요.</div>
			<input type='password' name='inputPwd' id='inputPwd'/>
			<input type='button' value='확인'  id='btnDelRun'/>
			<input type='button' value='취소' id='btnCancel'/>
		</form>
	</div>
</div>
<script>member()</script>
</body>
</html>