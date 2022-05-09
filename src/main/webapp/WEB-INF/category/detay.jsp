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
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <link rel="stylesheet" href="https://www.w3schools.com/lib/w3-theme-blue-grey.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
    <link rel='stylesheet' href='https://fonts.googleapis.com/css?family=Open+Sans'>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</head>
<body style="background: #ececec;">

<div>
    <%@include file='../../template.jsp' %>
</div>


<div style="margin-left:20%; padding: 10px;">

    <div class="w3-col">

        <div class="w3-row-padding">

            <%--            POST GÜNCELLEME         --%>
            <div class="w3-col m12">
                <div class="w3-card w3-round w3-white w3-margin-top">
                    <input type="hidden" id="category" value='${category}'/>

                    <div class="w3-container">
                        <script>
                            var category = $('#category').val();
                            category = JSON.parse(category);
                        </script>
                        <form id="categoryUpdate" action="${pageContext.request.contextPath}/category/update" method="post">
                            <div>
                                <input onkeyup="handleChangeCategory(this)" id="name" required
                                       style="width: 100%; margin: 10px 0;" class="w3-border w3-padding" type="text"
                                       placeholder="Başlık">
                            </div>
                            <div>
                                <textarea onkeyup="handleChangeCategory(this)" id="description" required
                                          style="width: 100%; margin: 10px 0;" class="w3-border w3-padding" rows="5"
                                          placeholder="İçerik"></textarea>
                            </div>

                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Güncelle
                            </button>
                            <button id="deleteButton" type="button" onclick="deleteCategory(this)" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Sil
                            </button>
                        </form>

                        <script>
                            $("#name").val(category.name);
                            $("#description").val(category.description);

                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function () {

    })

    $("#categoryUpdate").submit(function (event) {
        event.preventDefault();
        var strObj = JSON.stringify(category);
        $.post("${pageContext.request.contextPath}/category/update", {"strCategory": strObj}, function (data, status, xhr) {
            data = JSON.parse(data);
            if (status == "success" && data.success == true) {
                alert("GÜNCELLEME BAŞARILI");
                window.location.href = "${pageContext.request.contextPath}/admin/kategori";
            }
        });
    });

    function handleChangeCategory(event) {
        category[event.id] = event.value;
    }
    function deleteCategory(event)
    {
        $.post("${pageContext.request.contextPath}/category/delete", {
            "categoryID": category.id
        }, function (data, status, xhr) {
            data = JSON.parse(data);
            if (status == "success" && data.success == true) {
                alert("Silme Başarılı!")
                window.location.href = "${pageContext.request.contextPath}/admin/kategori";
            }
        });
    }

</script>
</body>


</html>
