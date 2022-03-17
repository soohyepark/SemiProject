<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- include libraries(jQuery, bootstrap) -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>

<link rel='stylesheet' type='text/css' href='./css/board.css'>
<script src='./js/board.js'></script>
<script>
$(function(){
	summer();
})
</script>
</head>
<body>
<div id='board'>
	<h2>게시물 작성하기</h2>
	<hr/>
	<form name='frm_board' method='post' id='frm_board'>
		<label>작성자</label>
		<input type='text' name='mid' value='hong'/>
		<br/>
		<label>제목</label>
		<input type='text' name='subject' size='90' value='공지사항입니다.'/>
		<br/>
		<label>내용</label>
		<textarea id='summernote' rows="10" cols="80" name='doc'></textarea>
		
		<label>암호</label>
		<input type='password' name='pwd' value='1111'/>
		<br/>
		
		<input type='text' name='findStr' value='${page.findStr}' />
		<input type='text' name='nowPage' value='${page.nowPage}' />
	</form>
	
	<form name='frm_upload' id='frm_upload' method='post'>
		<label>파일첨부</label>
		<input type='file' name='attFile' multiple="multiple"/>
		<input type='text' name='findStr' value='${page.findStr}' />
		<input type='text' name='nowPage' value='${page.nowPage}' />
		<br/>
	</form>
		<div id='btnZone'>
			<input type='button' value='저장' id='btnSave'/>
			<input type='button' value='목록' id='btnList'/>
		</div>
</div>

</body>
</html>