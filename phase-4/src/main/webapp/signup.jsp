<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Sign Up :: UNI-BUS</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h1 class="px-1">Sign Up</h1>
	<main class="px-1 py-1">
		<form class="flex border px-1 py-1" method="post" action="signupAction.jsp">
			<div>
				<label class="small" for="userEmail">Email</label>
				<input type="email" placeholder="abc@example.com" name="userEmail" maxlength="30">
			</div>
			<div>
				<label class="small" for="userFname">First Name</label>
				<input type="text" placeholder="Steve" name="userFname" maxlength="15">
			</div>
			<div>
				<label class="small" for="userLname">Last Name</label>
				<input type="text" placeholder="Smith" name="userLname" maxlength="15">
			</div>
			<div>
				<label class="small" for="userPassword">Password</label>
				<input type="password" placeholder="**********" name="userPassword" maxlength="15">
			</div>
			<div>
				<label class="small" for="userPhone">Phone Number</label>
				<input type="text" placeholder="01012345678" name="userPhone" maxlength="11">
			</div>
			
			<input class="btn" type="submit" value="Sign Up">
		</form>
	</main>
</body>
</html>