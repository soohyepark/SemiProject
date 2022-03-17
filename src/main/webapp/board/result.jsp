<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<link rel='stylesheet' type='text/css' href='./css/board.css'>
<script src='./js/board.js'></script>
</head>
<body>
<div id='board'>
	<h2>게시물 저장결과</h2>
	<hr/>
	<div id='msg'>${msg }</div>
	<div id='btnZone'>
			<form name='frm_board' method='post' id='frm_board'>
			<input type='button' value='목록' id='btnList'/>
			<input type='text' name='findStr' value='${page.findStr}' />
			<input type='text' name='nowPage' value='${page.nowPage}' />
			</form>
		</div>
</div>
</body>
</html>