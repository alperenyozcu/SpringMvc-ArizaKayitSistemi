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

    <style>
        .pagination {
            display: inline-block;
            margin-top: 1em;
            margin-bottom: 1.5em;
        }

        .pagination a {
            color: black;
            float: left;
            padding: 8px 16px;
            text-decoration: none;
        }

        .pagination a.active {
            background-color: #4CAF50;
            color: white;
        }

        .pagination a:hover:not(.active) {background-color: #ddd;}
    </style>
    <script>
        var start = 0;
        var limit = 5;
        var totalCount = 0;
        var totalPages = 0;
        var activePage = 1;
        var rowsPerCount = 5;
    </script>

</head>
<body style="background: #ececec;">

<%--SESSION USER--%>
<% User sessionUser = (User) request.getSession().getAttribute("user");%>

<div>
    <%@include file='../../template.jsp' %>
</div>


<div style="margin-left:20%; padding: 10px;">

    <div class="w3-col">

        <div class="w3-row-padding">

            <%--            POST GÜNCELLEME         --%>
            <div class="w3-col m12">
                <div class="w3-card w3-round w3-white w3-margin-top">
                    <input type="hidden" id="faultRecord" value='${faultRecord}'/>

                    <div class="w3-container">
                        <script>
                            var faultrecord = $('#faultRecord').val();
                            faultrecord = JSON.parse(faultrecord);
                        </script>
                        <form id="form" action="${pageContext.request.contextPath}/post/update" method="post">
                            <div>
                                <input onkeyup="handleChangePost(this)" id="title" required
                                       style="width: 100%; margin: 10px 0;" class="w3-border w3-padding" type="text"
                                       placeholder="Başlık">
                            </div>
                            <div>
                                <textarea onkeyup="handleChangePost(this)" id="context" required
                                          style="width: 100%; margin: 10px 0;" class="w3-border w3-padding" rows="10"
                                          placeholder="İçerik"></textarea>
                            </div>
                            <div class="form-check w3-margin-top w3-margin-bottom">
                                <input class="form-check-input" onchange="handleChangePostIsResolved(this)" type="checkbox" id="isResolved" />
                                <label class="form-check-label" for="isResolved">Çözüldü</label>
                            </div>

<%--                            ADMIN KULLANICI İÇİN IS EXPIRED ALANI--%>
                            <div id="isExpiredContainer" class="form-check w3-margin-top w3-margin-bottom adminEnabled">
                                <input class="form-check-input" onchange="handleChangePostIsExpired(this)" type="checkbox" id="isExpired" />
                                <label class="form-check-label" for="isExpired">Zaman Aşımı</label>
                            </div>

                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Güncelle
                            </button>
                            <button id="deletePostButton" onclick="deletePost(this)" type="button" class="w3-button w3-theme adminEnabled"><i class="fa fa-trash"></i> &nbsp;Sil
                            </button>
                        </form>

                        <script>
                            $("#title").val(faultrecord.title);
                            $("#context").val(faultrecord.context);
                            $('#isResolved').prop('checked', faultrecord.isResolved);
                            $('#isExpired').prop('checked', faultrecord.isExpired);
                        </script>
                    </div>
                </div>
            </div>


            <%--            YORUMLAR VE YORUM YAPMA ALANI           --%>
            <div class="w3-col m12" id="commentContainer">

            </div>


            <div class="w3-col m12">
                <div class="pagination">
                    <%--        <a href="#">&laquo;</a>--%>
                    <%--        <a href="#">&raquo;</a>--%>
                </div>
                <%--                YORUM YAPMA ALANI           --%>
                <div class="w3-card w3-round w3-white w3-margin-top w3-margin-left w3-margin-bottom">
                    <div class="w3-container">
                        <form id="formComment">
                            <div>
                                <textarea id="commentContext" required style="width: 100%; margin: 10px 0;"
                                          class="w3-border w3-padding" rows="3" placeholder="Yorum Yaz..."></textarea>
                            </div>
                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Yorum
                                Yap
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>


    </div>


</div>

<script>

    $(document).ready(function () {
        var sessionRole = '<%= sessionUser.getRole().toString()%>';
        if (sessionRole == "ADMIN"){
            $(".adminEnabled").show();
            $("#title").removeAttr('disabled');
            $("#context").removeAttr('disabled');
        }
        else if (sessionRole == "USER"){
            $(".adminEnabled").hide();
            $("#title").removeAttr('disabled');
            $("#context").removeAttr('disabled');
        }else {
            $(".adminEnabled").hide();
            $("#title").attr('disabled','disabled');
            $("#context").attr('disabled','disabled');
        }

        getThisPostComments();
        if (faultrecord.isResolved || faultrecord.isExpired){
            $("#formComment").hide();
            $("#form input, #form button, #form textarea").prop("disabled", true);
            $("#deleteComment").prop("disabled", true);
        }
    })

    $("#form").submit(function (event) {
        event.preventDefault();
        var strObj = JSON.stringify(faultrecord);
        $.post("${pageContext.request.contextPath}/post/update", {"strFaultRecord": strObj}, function (data, status, xhr) {
            data = JSON.parse(data);
            if (status == "success" && data.success == true) {
                alert("GÜNCELLEME BAŞARILI");
                var role = '<%= sessionUser.getRole().toString()%>';
                window.location.href = "${pageContext.request.contextPath}/" +( role=="ADMIN" ? "admin/home" : (role == "PERSONNEL" ? "personel/home" : "user/home"));
            }
        });

    });

    $("#formComment").submit(function (event) {
        event.preventDefault();
        $.post("${pageContext.request.contextPath}/comment/save", {
            "commentContext": $("#commentContext").val(),
            "faultRecordID": faultrecord.id
        }, function (data, status, xhr) {
            data = JSON.parse(data);
            if (status == "success" && data.success == true) {
                $("#commentContext").val("")
                getThisPostComments()
            }
        });

    });

    function deletePost(event){
        $.post("${pageContext.request.contextPath}/post/delete/" + faultrecord.id, {}, function (data, status, xhr) {
            var result = JSON.parse(data);
            if (result.success == true) {
                alert("Silme Başarılı");
                var role = '<%= sessionUser.getRole().toString()%>';
                window.location.href = "${pageContext.request.contextPath}/" +( role=="ADMIN" ? "admin/home" : "user/home");
            }else {
                alert("Silerken bir hata oluştu")
            }
        });
    }

    function deleteComment(event, commentID){
        $.post("${pageContext.request.contextPath}/comment/delete/" + commentID, {}, function (data, status, xhr) {
            var result = JSON.parse(data);
            if (result.success == true) {
                getThisPostComments()
            }else {
                alert("Silerken bir hata oluştu");
            }
        });
    }

    function handleChangePost(event) {
        faultrecord[event.id] = event.value;
    }

    function handleChangePostIsResolved(event) {
        faultrecord["isResolved"] = event.checked;
    }

    function handleChangePostIsExpired(event) {
        faultrecord["isExpired"] = event.checked;
    }

    function getThisPostComments() {

        $('#commentContainer').empty()

        $.get("${pageContext.request.contextPath}/comment/getByPost?postID=" + faultrecord.id +"&start=" + start + "&limit=" + limit, function (result) {
            var role = '<%= sessionUser.getRole().toString()%>';
            var r = JSON.parse(result);
            var data = r.data;

            totalCount = r.totalCount;
            if (totalCount < limit)
                totalPages = 1
            else
                totalPages = (totalCount%(limit) ==  0) ? (totalCount/(limit)) : (parseInt(totalCount/(limit)) + 1);
            $('.pagination').empty();
            if (activePage != 1)
                $('.pagination').append('<a onclick="handleBackPagination()">&laquo;</a>')
            for (let i = 1; i < totalPages + 1; i++) {
                $('.pagination').append(' <a onclick="handlePagination(this)"' + (i == activePage ? ('class="active"') : '') + ' >'+i+'</a>')
            }
            if (activePage != totalPages)
                $('.pagination').append('<a onclick="handleForwardPagination()">&raquo;</a>')

            data.map(item =>
                $('#commentContainer').append(
                    '<div class="w3-card w3-round w3-white w3-margin-top w3-margin-left">' +
                    '<div class="w3-container">' +
                    (
                        (role == "ADMIN" && !faultrecord.isResolved && !faultrecord.isExpired) ?
                            ('<div>' +
                            '<p style="width: 100%; margin: 5px 0; text-align: right; font-size: 18px; color: red;"><i onclick="deleteComment(this, '+item.id+')" id="deleteComment" style="cursor: pointer;" class="fa fa-trash"></i></p>' +
                            '</div>') : ''
                    ) +
                    '<div>' +
                    '<p style="width: 100%; margin: 10px 0;" class="w3-padding" rows="3"> ' + item.context + ' </p>' +
                    '</div>' +
                    ' <div>' +
                    ' <hr>' +
                    ' <p class="w3-right-align"> ' + item.user.ad + ' ' + item.user.soyad + ' </p>' +
                    ' <p class="w3-right-align"><small> ' + item.creationTime + ' </small></p>' +
                    '</div>' +
                    '</div> ' +
                    '</div>'
                )
            )
        });
    }

    function handlePagination(event){
        activePage = parseInt(event.innerHTML);
        start = (activePage - 1) * limit;
        getThisPostComments();
    }

    function handleBackPagination(){
        activePage -= 1;
        start = (activePage - 1) * limit;
        getThisPostComments();
    }

    function handleForwardPagination(){
        activePage += 1;
        start = (activePage - 1) * limit;
        getThisPostComments();
    }
</script>
</body>


</html>
