<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>form</title>
</head>
<body>
<h3>request 객체 테스트</h3>
<form name="request_test" action="viewParameter.jsp" method="post">
이름 : <input type="text" name="name"><br/>
주소 : <input type="text" name="address"><br/>
좋아하는 동물 :
	<label><input type="checkbox" name="pet" value="dog">강아지</label>
	<label><input type="checkbox" name="pet" value="cat">고양이</label>
	<label><input type="checkbox" name="pet" value="pig">돼지</label>
<br/>
<input type="submit" value="전송">
</form>
</body>
</html>