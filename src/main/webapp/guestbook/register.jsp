<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 입력</title>
<link rel='stylesheet' type='text/css' href='./css/guestbook.css'/>
<script src='./js/guestbook.js'></script>
</head>
<body>
<div id='guestbook'>
<form name='frm_guestbook' method='post' action='index.jsp?sub=./guestbook/register_result.jsp'>
	<h2>방명록 작성</h2>
	<hr/>
	<div id='labels'>
	<label>작성자</label>
	<input type='text' name='mid' value='hong' required="required">
	
	<label>작성일</label>
	<input type='date' name='mdate' readonly="readonly">
	</div>
	<textarea name='doc' cols='80' rows='10' placeholder='내용을 입력해주세요'></textarea><br/>
	
	<label>암호</label>
	<input type='password' name='pwd' required='required'>
	
	<input type='submit' value='작성'>

</form>
</div>
<script>
	var d = new Date();
	document.frm_guestbook.mdate.valueAsDate = d;
	guestbook();
</script>
</body>
</html>