<%@page import="java.util.Iterator"%>
<%@page import="java.util.Set"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Enumeration"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>viewParameter</title>
</head>
<body>
<h3>request test 결과</h3>
<b>request.getParameter() 메서드 사용</b><br/>
name 파라미터 = <%= request.getParameter("name") %><br/>
address 파라미터 = <%= request.getParameter("address") %><br/>
<%
String name1 = request.getParameter("name");
String address = request.getParameter("address");
out.print("<ul>");
out.print("<li>Name : "+name1);
out.print("<li>Address : "+address);
out.print("</ul>");
%>
<b>request.getParameterValues() 메서드 사용</b><br/>
<% 
	String[] values = request.getParameterValues("pet");
	if(values != null){
		for(int i=0 ; i<values.length ; i++){
			out.print(values[i]);
		}
	}
%>
<p>
<b>request.getParameterNames() 메서드 사용</b><br/>
<%
	Enumeration<String> paramEnum = request.getParameterNames();
	while(paramEnum.hasMoreElements()){
		String name = (String)paramEnum.nextElement();
%>
	<%=name %>
<%
	}
%>
<p>
<b>request.getParameterMap() 메서드 사용</b><br/>
<%
Map<String,String[]> map = request.getParameterMap();
Set<String> keys = map.keySet();
Iterator<String> it = keys.iterator();
while(it.hasNext()){
	String key = (String)it.next();
	String[] param = (String[])map.get(key);
	out.print("<li>"+key+" : "+param[0]);
}
out.print("</br>");

	Map<String,String[]> parameterMap= request.getParameterMap();
	String[] nameParam = (String[])parameterMap.get("name");
	String[] addressParam = (String[])parameterMap.get("address");
	if(nameParam != null){
%>
name = <%= nameParam[0] %>
address = <%= addressParam[0] %>
<%
	}

%>
</body>
</html>