<%@page import="member.MemberVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>core_foreach.jsp</title>
</head>
<body>
<%
	Map<String, Object> mapData = new HashMap<String, Object>();
	mapData.put("name", "홍길동");
	mapData.put("today", new Date());
	int[] intArray = {1,2,3,4,5,6,};
	
	request.setAttribute("mapData", mapData);
	request.setAttribute("intArray", intArray);
	
	List<MemberVo> list = new ArrayList<MemberVo>();
	MemberVo v1 = new MemberVo();
	v1.setMid("hong");
	v1.setAddress("부산");
	
	MemberVo v2 = new MemberVo();
	v2.setMid("kim");
	v2.setAddress("서울");
	
	list.add(v1);
	list.add(v2);
	request.setAttribute("list", list);
%>
<h3>1~100 홀수의 합</h3>
<c:forEach var='i' begin='1' end='100' step='2'>
	<c:set var='sum' value='${sum+i }'/>
</c:forEach>
<li>결과 : ${sum }</li>

<h3>구구단</h3>
<c:set var='dan'>5</c:set>
<c:forEach var='i' begin='1' end='9'>
	<li>${dan }*${i } = ${dan*i }</li>
</c:forEach>

<h3>정수형 배열</h3>
<c:forEach var='i' items='${intArray }' begin='2' end='4' varStatus="status">
	${status.index } - ${status.count } => ${i }<br/>
</c:forEach>

<h3>배열 전체 출력</h3>
<c:forEach var='i' items='${intArray }'>
	<li> ${i }</li>
</c:forEach>

<h3>map 값 출력</h3>
<c:forEach var='i' items='${mapData }'>
	<li>${i.key } - ${i.value }</li>
</c:forEach>

<h3>List 데이터 출력</h3>
<c:forEach var='vo' items='${list }'>
	<li>${vo.mid } [${vo.address }]</li>
</c:forEach>
</body>
</html>