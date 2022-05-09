<%--
  Created by IntelliJ IDEA.
  User: furkancelik
  Date: 2.05.2022
  Time: 19:18
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

                    <input type="hidden" id="personel" value='${personel}'/>
                    <div class="w3-container">

                        <script>
                            var personel = $('#personel').val();
                            personel = JSON.parse(personel);
                        </script>

                        <form id="formUpdatePersonel" action="${pageContext.request.contextPath}/personel/update" method="post">
                            <div>
                                <input onkeyup="handleChangePersonel(this)" required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Kullanıcı Adı" id="kullaniciAdi">
                            </div>
                            <div>
                                <input onkeyup="handleChangePersonel(this)" required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Ad" id="ad">
                            </div>
                            <div>
                                <input onkeyup="handleChangePersonel(this)" required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                       type="text" placeholder="Soyad" id="soyad">
                            </div>
                            <div>
                                <p>Personelin ilgileneceği kategori/kategorileri seçiniz</p>
                                <select multiple required style="width: 100%; margin: 10px 0;" class="w3-border w3-padding"
                                        placeholder="Kategori Seç" id="category">
                                </select>
                            </div>
                            <button type="submit" class="w3-button w3-theme"><i class="fa fa-pencil"></i> &nbsp;Güncelle
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script>

    var categoryList = [];

    $(document).ready(function () {
        $("#kullaniciAdi").val(personel.user.kullaniciAdi);
        $("#ad").val(personel.user.ad);
        $('#soyad').val(personel.user.soyad)
        var personelCategoryIDs = [];
        personel.categories.map(category => personelCategoryIDs.push(category.id))

        $.get("${pageContext.request.contextPath}/category/getAll", function (data) {
            var result = JSON.parse(data);
            if (result.success == true) {
                var list = result.data;
                categoryList = result.data;

                list.map(item =>
                    $('#category').append('<option '+ (personelCategoryIDs.indexOf(item.id) > -1 ? 'selected' : '')  +' value="' + item.id + '">' + item.name + '</option>')
                );
            }
        });
    });

    $("#formUpdatePersonel").submit(function (event) {
        event.preventDefault();
        var strPersonel = JSON.stringify(personel);

        $.post("${pageContext.request.contextPath}/personel/update", {
            "strPersonel": strPersonel
        }, function (data, status, xhr) {
            var result = JSON.parse(data);
            if (result.success == true) {
                alert("Güncelleme Başarılı")
                window.location.href = "${pageContext.request.contextPath}/admin/personel";
            }else{
                alert("Bir Hata Oluştu");
            }
        });

    });

    $("#category").change(function() {
        var arrSelectCategoryIDs = $(this).val();
        var newCategories = categoryList.filter(category => arrSelectCategoryIDs.indexOf(category.id.toString()) > -1);
        console.log("newCategories", newCategories);
        personel.categories = newCategories;
        console.log("new personel", personel);
    });

    function handleChangePersonel(event){
        personel.user[event.id] = event.value;
    }
</script>
</body>
</html>
