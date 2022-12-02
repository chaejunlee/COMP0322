<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up :: UNI-BUS</title>
</head>
<body>
	<form method="post" action="signupAction.jsp">
		<h3 style="text-align: center;">Signup</h3>
		<div>
			<input type="email" placeholder="email" name="userEmail" maxlength="30">
		</div>
		<div>
			<input type="text" placeholder="fname" name="userFname" maxlength="15">
		</div>
		<div>
			<input type="text" placeholder="lname" name="userLname" maxlength="15">
		</div>
		<div>
			<input type="password" placeholder="password" name="userPassword" maxlength="15">
		</div>
		<div>
			<input type="text" placeholder="phone number" name="userPhone" maxlength="11">
		</div>
		
		<input type="submit" value="signup">
	</form>
</body>
</html>