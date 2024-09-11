<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Status</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <!-- Flaticon CSS -->
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/updatestatus.css">

    </head>
    <body>
        <%@include file="/components/header.jsp"%>
        <!-- End Nav -->

        <div class="container-fluid body-content">
            <div class="row">
                <!-- left nav -->
                <div class="col-lg-12 content-post">
                    <form action="showstatus" method="post">
                        <input type="hidden" value="${statusdetail.status_id}" name="id">
                        <input type="hidden" value="${page}" name="page">
                        <div class="modal-body status-create-pop-up">
                            <div>
                                <div>
                                    <table>
                                        <tr>
                                            <td class="body-content-left-avatar" rowspan="2"><img src="img/${currentUser.image}"/>
                                            </td>
                                            <c:if test="${statusdetail.access == 0}">
                                                <td class="td-username">${currentUser.f_name} ${currentUser.l_name}</td>
                                            </c:if>
                                            <c:if test="${statusdetail.access == 1}">
                                                <td class="td-username">${currentUser.f_name} ${currentUser.l_name} shared to Family</td>
                                            </c:if>
                                        </tr>
                                        <tr>
                                            <td>${statusdetail.date.toString().substring(0,16)}</td>
                                        </tr>
                                    </table>
                                </div>
                                <textarea class="input-edit-status" name="content" rows="5"cols="60">${statusdetail.description}</textarea>
                                <img id="image" style="width:200px; border-radius: 0"  class="status-post-image" src="img/${statusdetail.img}" alt="">
                                <input type="hidden" name="uploadedImage" value="${statusdetail.img}">
                            </div>
                            <input type="file" name="image" accept="image/gif, image/jpg, image/png" value="img/${statusdetail.img}"onchange="chooseFile(this)" >
                            <div class="button-create">
                                <a href="showstatus?page=${page}" class="btn btn-danger">Return</a>
                                <button  class="btn btn-primary">Update</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- jquery-->
        <script src="templates/js/jquery.min.js"></script>
        <!-- Bootstrap js -->
        <script src="templates/js/bootstrap.min.js"></script>
        <!-- Imagesloaded js -->
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>
        <!-- Validator js -->
        <script src="templates/js/validator.min.js"></script>
        <!-- Custom Js -->
        <script src="js/main.js"></script>
        <script>
            function chooseFile(fileInput) {
                if (fileInput.files && fileInput.files[0]) {
                    var reader = new FileReader();
                    reader.onload = function (e) {
                        $('#image').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(fileInput.files[0]);
                }
            }
        </script>
    </body>
</html>