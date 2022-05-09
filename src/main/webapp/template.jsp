<%@ page import="com.ileriJava.model.User" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 405fu
  Date: 27.03.2022
  Time: 23:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Arıza Kayıt Sistemi</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css"
          integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
    <style>

        .linear {
            background-image: linear-gradient(to top, rgba(0, 0, 0, 1), rgba(128, 128, 128, 1));
        }

    </style>

</head>
<body style="background: #ececec;">


<div class="w3-sidebar bg-dark text-center" style="width:20%">

    <% User user = (User) request.getSession().getAttribute("user");%>

    <c:choose>
        <c:when test="${user.getRole().toString()=='USER'}">
        <a href="${pageContext.request.contextPath}/user/home"
           class="d-block text-decoration-none text-white text-uppercase mt-4 mb-5">
            <h3 style="color: white;">
                <%=
                user != null ? user.getAd() + " " + user.getSoyad() : ""
                %>
            </h3>

            <img src="${pageContext.request.contextPath}/resources/img/avatar.svg" width="200">

        </a>

        </c:when>
        <c:when test="${user.getRole().toString()=='ADMIN'}">
        <a href="${pageContext.request.contextPath}/admin/home"
           class="d-block text-decoration-none text-white text-uppercase mt-4 mb-5">
            <h3>
                <%=
                user != null ? user.getAd() + " " + user.getSoyad() : ""
                %>
            </h3>

            <img src="${pageContext.request.contextPath}/resources/img/avatar.svg" width="200">

        </a>

        </c:when>
        <c:when test="${user.getRole().toString()=='PERSONNEL'}">
            <a href="${pageContext.request.contextPath}/personel/home"
               class="d-block text-decoration-none text-white text-uppercase mt-4 mb-5">
                <h3>
                    <%=
                    user != null ? user.getAd() + " " + user.getSoyad() : ""
                    %>
                </h3>

                <img src="${pageContext.request.contextPath}/resources/img/avatar.svg" width="200">

            </a>

        </c:when>
    </c:choose>



        <div class="text-left px-2">

            <ul class="list-group list-unstyled">


                <c:choose>
                    <c:when test="${user.getRole().toString()=='USER'}">
                        <li><a href="${pageContext.request.contextPath}/user/home" class="list-group-item bg-dark text-white border-0">Anasayfa</a>
                        </li>
<%--                        <li><a href="/user/edu" class="list-group-item bg-dark text-white border-0">Education</a></li>--%>
<%--                        <li><a href="/user/experience"--%>
<%--                               class="list-group-item bg-dark text-white border-0">Experience</a></li>--%>
<%--                        <li><a href="/user/reference" class="list-group-item bg-dark text-white border-0">Reference</a>--%>
<%--                        </li>--%>
<%--                        <li><a href="/user/hobi" class="list-group-item bg-dark text-white border-0">Hobbies</a></li>--%>
<%--                        <li><a href="/user/skill" class="list-group-item bg-dark text-white border-0">Skills</a></li>--%>

                    </c:when>
                    <c:when test="${user.getRole().toString()=='ADMIN'}">

                        <li><a href="${pageContext.request.contextPath}/admin/home"
                               class="list-group-item bg-dark text-white border-0">Başlıklar</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/personel"
                               class="list-group-item bg-dark text-white border-0">Personel İşlemleri</a></li>
                        <li><a href="${pageContext.request.contextPath}/admin/kategori"
                               class="list-group-item bg-dark text-white border-0">Kategori İşlemleri</a></li>

                    </c:when>

                    <c:when test="${user.getRole().toString()=='PERSONNEL'}">

                        <li><a href="${pageContext.request.contextPath}/personel/home"
                               class="list-group-item bg-dark text-white border-0">Anasayfa</a></li>

                        <script>
                            var personel = {};
                            $.get("${pageContext.request.contextPath}/personel/getByUserID/" + ${user.getId()}, function (data) {
                                var result = JSON.parse(data);

                                if (result.success == true){

                                    personel = result.data;
                                    result.data.categories.map(category => {
                                        console.log("category", category);
                                        $('#lastListElement').before(
                                            '<li><a href="${pageContext.request.contextPath}/personel/category?categoryID='+category.id+'"' +
                                            'class="list-group-item bg-dark text-white border-0">'+category.name+'</a></li>'
                                        );
                                    })
                                }
                            });
                        </script>

                    </c:when>
                </c:choose>
                <li id="lastListElement"><a id="logout" tabindex="0" style="cursor: pointer;"
                       class="list-group-item bg-dark text-white border-0">Log Out</a></li>
            </ul>


        </div>

</div>

<script>
    $("#logout").click(function () {
        $.post("${pageContext.request.contextPath}/logout", {}, function (data, status, xhr) {
            var result = JSON.parse(data);
            if (status == "success" && result.success == true) {
                window.location.href = "${pageContext.request.contextPath}/login";
            }
        });
    });
</script>
</body>
</html>
