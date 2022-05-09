<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Arıza Kayıt Sistemi</title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js">
    </script>
    <style>
        .pagination {
            display: inline-block;
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

<div>
    <%@include file='../../template.jsp' %>
</div>


<div style="margin-left:20%; padding: 10px;">



    <div class="w3-col">

        <div class="w3-row-padding">
            <div class="w3-col m12">
                <div class="w3-card w3-round w3-white">
                    <div class="w3-container">



                    </div>
                </div>
            </div>
        </div>



    </div>
    <div id="postContainer">

    </div>
    <div class="pagination">
        <%--        <a href="#">&laquo;</a>--%>
        <%--        <a href="#">&raquo;</a>--%>
    </div>
</div>

<script>

    $(document).ready(function () {
        getAllPost();

    });



    function getAllPost() {
        $('#postContainer').empty();

        $.get("${pageContext.request.contextPath}/post/getAllPersonelPost?start=" + start + "&limit=" + limit, function (data) {
            var result = JSON.parse(data);
            if(result.success==true)
            {

                totalCount = result.totalCount;
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


                var recordList=result.data;
                recordList.map(record =>
                    $('#postContainer').append(
                        '<div class="w3-container w3-card w3-white w3-round w3-margin"><br>' +
                        '<span class="w3-right w3-opacity">' + record.creationTime + '</span>' +
                        '<h4>' + (record.isResolved ?  '[ÇÖZÜLDÜ] ' : (record.isExpired ? '[ZAMAN AŞIMI]' : '')) + record.title + '</h4><br>' +
                        '<hr class="w3-clear">' +
                        '<p>' + (record.context?.length > 400 ? record.context.substr(0, 397) + '...': record.context) + '</p>' +
                        '<div class="w3-row-padding" style="margin:0 -16px">' +
                        '<div class="w3-half">' + '</div><div class="w3-half">' +
                        '</div></div>' +
                        '<a href="${pageContext.request.contextPath}/post/detay/' + record.id + '"><button type="button" class="w3-button w3-theme-d1 w3-margin-bottom"><i class="fa fa-thumbs-up"></i> &nbsp;Detay</button></a>' +
                        // '<button type="button" class="w3-button w3-theme-d2 w3-margin-bottom"><i class="fa fa-comment"></i> &nbsp;Düzenle</button>' +
                        '</div>'
                    )
                )
            }

        });
    }

    function handlePagination(event){
        activePage = parseInt(event.innerHTML);
        start = (activePage - 1) * limit;
        getAllPost();
    }

    function handleBackPagination(){
        activePage -= 1;
        start = (activePage - 1) * limit;
        getAllPost();
    }

    function handleForwardPagination(){
        activePage += 1;
        start = (activePage - 1) * limit;
        getAllPost();
    }
</script>
</body>
</html>
