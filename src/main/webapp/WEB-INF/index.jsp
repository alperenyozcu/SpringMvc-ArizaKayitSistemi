<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: 405fu
  Date: 8.03.2022
  Time: 20:40
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%--<%@ page pageEncoding="UTF-8" %>--%>
<html>
<head>
    <title>Arıza Kayıt Sistemi</title>
</head>
<body>

<div><%@include file='../template.jsp'%></div>
<h1>LIST ITEMS</h1>
<c:forEach items="${list}" var="item">
    <div>
        <h2>
            <c:out value="${item}"/>
        </h2>
    </div>
</c:forEach>

</body>
</html>
