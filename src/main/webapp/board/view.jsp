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
	<h2>게시물 상세보기</h2>
	<hr/>
	<form name='frm_board' method='post' id='frm_board'>
		<label>작성자</label>
		<input type='text' name='mid' value='${vo.mid }'/>
		<br/>
		<label>제목</label>
		<input type='text' name='subject' size='90' value='${vo.subject }'/>
		<br/>
		<label>내용</label>
		<div id="doc">${vo.doc }</div>
		<br/>
		
		<c:if test="${not empty vo.attList }">
			<label>파일첨부</label>
			<div class="attZone">
				<ul>
				<c:forEach var="att" items="${vo.attList }">
					<li><a href="./upload/${att.attFile }" download="${att.attFile}">${att.attFile }</a></li>
				</c:forEach>
				</ul>
			</div>
		
		</c:if>
		
		<br/>
		<div id='btnZone'>
			<input type='button' value='수정' id='btnModify'/>
			<input type='button' value='삭제' id='btnDelete'/>
			<input type='button' value='댓글달기' id='btnRepl'/>
			<input type='button' value='목록' id='btnList'/>
		</div>
		
		<input type='hidden' name='findStr' value='${page.findStr}' />
		<input type='hidden' name='nowPage' value='${page.nowPage}' />
		<input type='hidden' name='serial' value='${vo.serial}' />
		<input type='hidden' name='grp' value='${vo.grp}' />
		<input type='hidden' name='seq' value='${vo.seq}' />
		<input type='hidden' name='deep' value='${vo.deep}' />
		<input type='hidden' name='deep' value='${vo.hit}' />
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
</body>
</html>