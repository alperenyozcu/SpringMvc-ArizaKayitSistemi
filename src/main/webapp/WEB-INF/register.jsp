<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 405fu
  Date: 8.03.2022
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Arıza Kayıt Sistemi Kaydol</title>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
	<script src="https://kit.fontawesome.com/a81368914c.js"></script>
	<script type = "text/javascript" src = "https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body>
	<img class="wave" src="${pageContext.request.contextPath}/resources/img/wave.png">
	<div class="container">
		<div class="img">
		
		</div>
		<div class="login-content">
			<form id="formRegister" action="register/registered" method="post">
				<img src="${pageContext.request.contextPath}/resources/img/avatar.svg">
				<h2 class="title">Kaydol!</h2>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>Kullanıcı Adı</h5>
           		   		<input type="text" class="input" id="kullaniciadi">
           		   </div>
           		   
           		</div>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>İsim</h5>
           		   		<input type="text" class="input" id="ad">
           		   </div>
           		   
           		</div>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>Soyisim</h5>
           		   		<input type="text" class="input" id="soyad">
           		   </div>
           		   
           		</div>
           		<div class="input-div one">
           		   <div class="i">
           		   		<i class="fas fa-user"></i>
           		   </div>
           		   <div class="div">
           		   		<h5>Email</h5>
           		   		<input type="email" class="input" id="email">
           		   </div>
           		   
           		</div>
           		<div class="input-div pass">
           		   <div class="i"> 
           		    	<i class="fas fa-lock"></i>
           		   </div>
           		   <div class="div">
           		    	<h5>Şifre</h5>
           		    	<input type="password" class="input" id="sifre">
            	   </div>
            	</div>
            	
            
			<input type="submit" class="btn"  value="Kayıt Ol">
            </form>
        </div>
    </div>
    <script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>

	<script>
		$("#formRegister").submit(function (event) {
			event.preventDefault();
			$.post("${pageContext.request.contextPath}/register/registered", {"kullaniciadi": $("#kullaniciadi").val(), "ad": $("#ad").val(),
																				"soyad": $("#soyad").val(), "email": $("#email").val(), "sifre": $("#sifre").val()},
					function (data, status, xhr) {
				var result = JSON.parse(data);
				console.log("result", result);
				if (status == "success" && result.success == true) {
					$("#kullaniciadi").val("");
					$("#ad").val("");
					$("#soyad").val("");
					$("#email").val("");
					$("#sifre").val("");
					window.location.href = "${pageContext.request.contextPath}/login";
				}
			});

		});
	</script>
</body>
</html>
