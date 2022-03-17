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
	<h2>게시판</h2>
	<hr/>
	<div id='findZone'>
		<form name='frm_search' method='post' id='frm_search'>
			<input type='button' value='입력' id='btnInsert'/>
			<input type='text' name='findStr' value='${page.findStr}' />
			<input type='button'value='검색' id='btnSearch'/>
			
			<input type='text' name='nowPage' value='${page.nowPage}' />
			<input type='text' name='serial' />
		</form>
	</div>
	<div id='list'>
		<div id='title'>
			<span class='no'>NO</span>
			<span class='subject'>제목</span>
			<span class='mid'>작성자</span>
			<span class='mdate'>작성일</span>
			<span class='hit'>조회수</span>
		</div>
		<div id='items'>
			<c:forEach var='vo' items="${list }">
				<div class='item' onclick='brd.view(${vo.serial})'>
					<span class='no'>${vo.serial }</span>
					<span class='subject'>${vo.subject }</span>
					<span class='mid'>${vo.mid }</span>
					<span class='mdate'>${vo.mdate }</span>
					<span class='hit'>${vo.hit}</span>
				</div>
			</c:forEach>
		</div>
		<div id='btnPage'>
			<c:if test="${page.startPage>1 }">
			<input type='button' value='맨첨' id='btnFirst' onclick='brd.page(1)'/>
			<input type='button' value='이전' id='btnPrev' onclick='brd.page(${page.startPage-1})'/>
			</c:if>
			
			<c:forEach var='i' begin="${page.startPage }" end="${page.endPage }">
			<input type='button' value='${i }' onclick='brd.page(${i})' class="${(i==page.nowPage)? 'here':'' }"/>
			</c:forEach>
			
			<c:if test="${page.endPage<page.totPage }">
			<input type='button' value='다음' id='btnNext' onclick='brd.page(${page.endPage+1})'/>
			<input type='button' value='맨끝' id='btnLast' onclick='brd.page(${page.totPage})'/>
			</c:if>
		</div>
	</div>
	
</div>
</body>
</html>