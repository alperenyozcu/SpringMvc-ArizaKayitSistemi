<%--
  Created by IntelliJ IDEA.
  User: furkancelik
  Date: 1.05.2022
  Time: 09:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<body>


<div>
    <%@include file='../../template.jsp' %>
</div>

<div style="margin-left: 20%; padding: 10px;">

    <div class="w3-col">

        <div class="w3-row-padding">
            <div class="w3-col m12">
                <div class="w3-card w3-round w3-white">
                    <div class="w3-container">

                        <%--                        KATEGORİ EKLEME--%>
                        <form id="formPersonel" action="${pageContext.request.contextPath}/personel/create" method="post">
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Kullanıcı Adı" id="kullaniciAdi">
                            </div>
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Ad" id="name">
                            </div>
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Soyad" id="surname">
                            </div>
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="E-mail" id="email">
                            </div>
                            <div>
                                <input required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="password" placeholder="Şifre" id="password">
                            </div>
                            <div>
                                <p>Personelin ilgileneceği kategori/kategorileri seçiniz</p>
                                <select multiple required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                        placeholder="Kategori Seç" id="category">
                                </select>
                            </div>
                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Kaydet
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div id="personelContainer">

        </div>
    </div>

    <div>
        <%@include file='./personelTablo.jsp' %>
    </div>

</div>


<script>

    $(document).ready(function () {
        $.get("${pageContext.request.contextPath}/category/getAll", function (data) {
            var result = JSON.parse(data);
            if (result.success == true) {
                var list = result.data;

                list.map(item =>
                    $('#category').append('<option value="' + item.id + '">' + item.name + '</option>')
                );
            }
        });
    });

    $("#formPersonel").submit(function (event) {
        event.preventDefault();
        console.log($("#category").val())
        $.post("${pageContext.request.contextPath}/personel/create", {
            "kullaniciAdi": $("#kullaniciAdi").val(),
            "name": $("#name").val(),
            "surname": $("#surname").val(),
            "email": $("#email").val(),
            "password": $("#password").val(),
            "categories": $("#category").val().toString(),
        }, function (data, status, xhr) {
            var result = JSON.parse(data);
            if (result.success){
                alert("Kayıt Başarılı");
                $("#kullaniciAdi").val("");
                $("#name").val("");
                $("#surname").val("");
                $("#email").val("");
                $("#password").val("");
                $("#category").val("");
            }
            else
                alert("Bir Hata Oluştu");
            getAllPersonel();
        });

    });

</script>

</body>
</html>
