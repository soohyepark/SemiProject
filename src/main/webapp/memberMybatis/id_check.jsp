<%@page import="memberMybatis.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>id_check</title>
<style>
	#id_check{
		width:350px;
		margin:0 auto;
		padding:20px;
		border:3px solid #69f;
		border-radius:8px;
		text-align:center;
	}
	#id_check #id_check_result{
		display:inline-block;
		margin-top:15px;
		width:100%;
		height:45px;
		line-height:45px;
		padding:5px;
		text-align:center;
		background-color:#eef;
	}
</style>
</head>
<body>
<div id='id_check'>
	<form name='frm_id_check' method='post'>
		<label>아이디</label>
		<input type='text' name='checkId' value='${param.checkId }'/>
		<input type='submit' value='아이디체크'/>
		<br/>
		<output id='id_check_result'></output>
		
	</form>
</div>
<%
	String msg = "사용가능";
	if(request.getMethod().equals("POST")){
		String checkId = request.getParameter("checkId");
		MemberDao dao = new MemberDao();
		boolean b = dao.idCheck(checkId);
	
		out.print("<script>");
		out.print(" var rst = document.getElementById('id_check_result');");
		if(b){// 사용가능
			out.print(" rst.style.color = '#00f' ;");
			out.print(" rst.innerHTML = '사용가능' ;");
			out.print(" opener.frm_member.mid.value = frm_id_check.checkId.value;");
		}else{// 사용불가
			out.print(" rst.style.color = '#f00' ;");
			out.print(" rst.innerHTML = '사용불가' ;");
			out.print(" opener.frm_member.mid.value = '' ;");
		}
		out.print("</script>");
	}
%>

</body>
</html>