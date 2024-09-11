
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Family</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <link rel="stylesheet" href="templates/css/fullcalendar.css" />
        <link rel="stylesheet" href="css/calendar.css"/>
        <link rel="stylesheet" href="css/familycalendar.css">
    </head>

    <body>

        <!-- Header -->

        <%@include file="/components/header.jsp"%>

        <!-- End Header -->

        <div class="container-fluid body-content">
            <div class="row" >

                <!-- left nav -->

                <%@include file="/components/familysidebar.jsp"%>

                <!-- End left nav -->

                <div class="col-lg-2"></div>

                <!-- Calendar -->
                <div class="col-lg-10 content-post" style="margin-bottom: 50px">
                    <div class="calendar-embedded">
                        <div id="calendar"></div>
                    </div>
                </div>      
                <!-- End Calendar -->
            </div>              
        </div>
        <input type="hidden" id="family_id" value="${family.getFamily_id()}">
        <!--UpComing Event -->       
        <div class="modal fade" id="upComingFamily" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Upcoming family event </h1>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <h5 style="padding:10px 15px " class="">Date now: ${datenow}</h5>
                    <div class="modal-body " style="height: 400px;
                         overflow-y: scroll;
                         background-color: #8080801c">

                        <c:forEach items="${loadFamilyEventUpComing}" var="elcu">
                            <div class="pop-up-up-coming-event">
                                <img src="img/${elcu.image}" width="25px" alt="alt"/><label style="margin-left: 5px">  ${elcu.name} 's event</label>
                                <div style="display: flex; justify-content: space-between">
                                    <div>
                                        <label for="name" style="font-size: 15px;font-weight: 700;">Title: ${elcu.title}</label>     
                                    </div>
                                    <div class="pop-up-up-coming-even-title">
                                        <h7>${elcu.dayafter} days left</h7>
                                    </div>
                                </div>
                                <div style="display: flex; justify-content: space-between; margin-top: 10px">
                                    <div>
                                        <label for="name" style="font-weight: 700;">Place:</label><br>
                                        <p style="margin-bottom: 0px; word-wrap: break-word; max-width: 200px">${elcu.place}</p>
                                    </div>
                                    <div style="width: 200px; text-align: left">
                                        <label for="name" style="font-weight: 700;">Description:</label><br>
                                        <p style="margin-bottom: 0px; word-wrap: break-word; max-width: 200px">${elcu.description}</p>
                                    </div>
                                </div>
                                <hr>

                            </div>                       
                        </c:forEach>

                    </div>
                </div>                
            </div>
        </div>
        <!-- End UpComing Event -->


        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>   
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/main.js"></script>
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/moment.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
        <script src="js/familycalendar.js"></script>

        <script type="application/json" id="eventsFamilyData">
            ${eventFamilyList}
        </script>


    </body>

</html>
