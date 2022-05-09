<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 405fu
  Date: 8.03.2022
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" contentType="text/html;charset=UTF-8" language="java" %>
<html lang="tr">
<head>
    <title>Arıza Kayıt Sistemi</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
    <link href="https://fonts.googleapis.com/css?family=Poppins:600&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a81368914c.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
</head>
<body>
<img class="wave" src="${pageContext.request.contextPath}/resources/img/wave.png">
<div class="container">
    <div class="img">

    </div>
    <div class="login-content">
        <form id="formLogin" action="${pageContext.request.contextPath}/login" method="post">
            <img src="${pageContext.request.contextPath}/resources/img/avatar.svg">
            <h2 class="title">Hoşgeldiniz!</h2>
            <div class="input-div one">
                <div class="i">
                    <i class="fas fa-user"></i>
                </div>
                <div class="div">
                    <h5>E-mail</h5>
                    <input required type="email" class="input" id="email">
                </div>
            </div>
            <div class="input-div pass">
                <div class="i">
                    <i class="fas fa-lock"></i>
                </div>
                <div class="div">
                    <h5>Şifre</h5>
                    <input required type="password" class="input" id="password">
                </div>
            </div>
            <p style="display: none;" id="loginMessage"></p>
            <input type="submit" class="btn" value="Giriş Yap">
            <a href="register"><input type="button" class="btn" value="Kayıt Ol"></a>
        </form>
    </div>
</div>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.js"></script>

<script>
    $("#formLogin").submit(function (event){

        event.preventDefault();
        $("#loginMessage").hide();
        $.post("${pageContext.request.contextPath}/login", {"email": $("#email").val(), "password": $("#password").val()},
            function (data, status, xhr){
                var result = JSON.parse(data);

                $("#loginMessage").text(result.message);
                $("#loginMessage").show();

                if (result.success == true){
                    if(result.role=="ADMIN")
                    {
                        window.location.href = "${pageContext.request.contextPath}/admin/home";
                    }
                    else if (result.role=="USER"){
                        window.location.href = "${pageContext.request.contextPath}/user/home";
                    }
                    else if (result.role=="PERSONNEL"){
                        window.location.href = "${pageContext.request.contextPath}/personel/home";
                    }
                }



            });
    });
</script>
</body>
</html>
