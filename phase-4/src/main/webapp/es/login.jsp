<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="style.css" />
<title>Página de Acceso :: UniBus</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<h1 class="px-1">Iniciar Sesión</h1>
	<main class="mx-auto max-w px-1 py-2">
		<form method="post" class="flex border px-1 py-1" action="loginAction.jsp">
			<div>
				<label class="small" for="userEmail">Email</label>
				<input type="email" placeholder="abc@example.com" name="userEmail" maxlength="30">
			</div>
			<div>
				<label class="small" for="userPassword">Contraseña</label>
				<input type="password" placeholder="**********" name="userPassword" maxlength="15">
			</div>
			<input class="btn" type="submit" value="Entrar">
		</form>
	</main>
	<jsp:include page="footer.jsp" />
</body>
</html>