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
	<h2>게시물 수정하기</h2>
	<hr/>
	<form name='frm_board' method='post' id='frm_board'>
		<label>작성자</label>
		<input type='text' name='mid' value='${vo.mid }' readonly="readonly"/>
		<br/>
		<label>제목</label>
		<input type='text' name='subject' size='90' value='${vo.subject }'/>
		<br/>
		<label>내용</label>
		<textarea rows="10" cols="80" name='doc' id="summernote">${vo.doc }</textarea>
		<br/>
		
		<c:if test="${not empty vo.attList }">
			<label>파일첨부</label>
			<div class="attZone">
				<c:forEach var="att" items="${vo.attList }">
				<div>
					<span>${att.attFile }</span>
					<label><input type="checkbox" name="delFile" value="${att.attFile }"/>삭제</label>
				</div>
				</c:forEach>
			</div>	
		</c:if>
		
		<label>암호</label>
		<input type='password' name='pwd' value='1111'/>
		<input type='text' name='serial' value='${vo.serial}' />
		<br/>
	</form>
	
		<form name='frm_upload' id='frm_upload' method='post'>
		<label>파일첨부</label>
		<input type='file' name='attFile' multiple="multiple"/>
		<br/>
		
		<input type='text' name='findStr' value='${page.findStr}' />
		<input type='text' name='nowPage' value='${page.nowPage}' />
		<input type='text' name='serial' value='${vo.serial}' />
		<input type='text' name='grp' value='${vo.grp}' />
		<input type='text' name='seq' value='${vo.seq}' />
		<input type='text' name='deep' value='${vo.deep}' />
		</form>
		
		<div id='btnZone'>
			<input type='button' value='수정후 저장' id='btnModifySave'/>
			<input type='button' value='목록' id='btnList'/>
		</div>
		
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
</body>
</html>