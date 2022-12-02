<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign In :: UNI-BUS</title>
</head>
<body>
	<form method="post" action="loginAction.jsp">
		<h3 style="text-align: center;">login</h3>
		<div>
			<input type="email" placeholder="email" name="userEmail" maxlength="30">
		</div>
		<div>
			<input type="password" placeholder="password" name="userPassword" maxlength="15">
		</div>
		<input type="submit" value="login">
	</form>
</body>
</html>