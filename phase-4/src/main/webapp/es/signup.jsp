<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Registarse :: UniBus</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h1 class="px-1">Registarse</h1>
	<main class="mx-auto max-w px-1 py-2">
		<form class="flex border px-1 py-1" method="post" action="signupAction.jsp">
			<div>
				<label class="small" for="userEmail">Correos</label>
				<input type="email" placeholder="abc@example.com" name="userEmail" maxlength="30">
			</div>
			<div>
				<label class="small" for="userFname">Nombre</label>
				<input type="text" placeholder="Steve" name="userFname" maxlength="15">
			</div>
			<div>
				<label class="small" for="userLname">Apellidos</label>
				<input type="text" placeholder="Smith" name="userLname" maxlength="15">
			</div>
			<div>
				<label class="small" for="userPassword">Contraseña</label>
				<input type="password" placeholder="**********" name="userPassword" maxlength="15">
			</div>
			<div>
				<label class="small" for="userPhone">Número de Teléfono</label>
				<input type="text" placeholder="01012345678" name="userPhone" maxlength="11">
			</div>
			
			<input class="btn" type="submit" value="Registar">
		</form>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>