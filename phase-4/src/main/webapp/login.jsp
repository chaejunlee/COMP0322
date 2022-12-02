<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Sign In :: UNI-BUS</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h1 class="px-1">Sign In</h1>
	<main class="px-1 py-1">
		<form method="post" class="flex border px-1 py-1" action="loginAction.jsp">
			<div>
				<label class="small" for="userEmail">Email</label>
				<input type="email" placeholder="abc@example.com" name="userEmail" maxlength="30">
			</div>
			<div>
				<label class="small" for="userPassword">Password</label>
				<input type="password" placeholder="password" name="userPassword" maxlength="15">
			</div>
			<input class="btn" type="submit" value="Sign In">
		</form>
	</main>
</body>
</html>