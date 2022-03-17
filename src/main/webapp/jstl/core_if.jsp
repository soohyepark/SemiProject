<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_if</title>
</head>
<body>
<h2>core if문</h2>
<c:set var ='v'>100</c:set>
<c:if test="${v eq 100 }">
	<li>v=100입니다.</li>
</c:if>

<c:set var='kor'>90</c:set>
<c:set var='eng'>80</c:set>
<c:set var='tot'>${kor+eng }</c:set>
<c:if test="${tot>100 }">
	<li>${tot }점수는 합격입니다.</li>
</c:if>
<!-- 
	w,h에 각각 고객의 몸무게와 키를 저장하고 w>100이상이거나
	h>200이상이면 탑승불가라는 메시지를 출력하도록 if문 작성
 -->
 <c:set var='w'>120</c:set>
 <c:set var='h'>170</c:set>
 <c:if test="${w ge 100 or h ge 200 }">
 	<li><font color='red'>몸무게 : ${w }, 키 : ${h }는 탑승불가입니다.</font></li>
 </c:if>


</body>
</html>