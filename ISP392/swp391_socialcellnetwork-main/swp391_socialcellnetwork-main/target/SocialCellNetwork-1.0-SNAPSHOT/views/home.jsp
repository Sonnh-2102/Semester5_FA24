
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="en">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Home</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <link rel="stylesheet" href="templates/css/fullcalendar.css" />
        <link rel="stylesheet" href="css/home.css">
        <link rel="stylesheet" href="css/calendar.css"/>

        <!-- Link Swiper's CSS -->
        <link rel="stylesheet" href="templates/css/swiper-budle.css">
    </head>


    <body>

        <!-- Header -->

        <%@include file="/components/header.jsp"%>
        <input type="hidden" name="process" id="process" value="${process}"> 

        <!-- End Header -->

        <div class="container-fluid body-content">
            <div class="row" >

                <!-- left nav -->

                <%@include file="/components/sidebar.jsp"%>

                <!-- End left nav -->

                <div class="col-lg-2"></div>

                <!-- Calendar -->
                <div class="col-lg-10 content-post" style="margin-bottom: 50px">

                    <input type="hidden" name="process" id="process" value="${processUpdate}"> 
                    <div class="calendar-embedded">
                        <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                            <li class="nav-item" role="presentation">
                                <button class="nav-link active" id="pills-home-tab" data-bs-toggle="pill" data-bs-target="#pills-home" type="button" role="tab" aria-controls="pills-home" aria-selected="true">Calendar</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-profile-tab" data-bs-toggle="pill" data-bs-target="#pills-profile" type="button" role="tab" aria-controls="pills-profile" aria-selected="false">All Event</button>
                            </li>
                            <li class="nav-item" role="presentation">
                                <button class="nav-link" id="pills-contact-tab" data-bs-toggle="pill" data-bs-target="#pills-contact" type="button" role="tab" aria-controls="pills-contact" aria-selected="false">My Event</button>
                            </li>
                        </ul>
                        <div class="tab-content" id="pills-tabContent">
                            <div class="tab-pane fade show active" id="pills-home" role="tabpanel" aria-labelledby="pills-home-tab" tabindex="0"><div id="calendar"></div></div>
                            <!--homepage2-->
                            <div class="tab-pane fade" id="pills-profile" role="tabpanel" aria-labelledby="pills-profile-tab" tabindex="0">
                                <div class="select-month-option-find">
                                    Select month: <input id="allevent_month"type="month" name="month"/>
                                    <button onclick="searchAllEventByMonth()"><i class="fas fa-search"></i></button>
                                </div>
                                <div class="body-mine">
                                    <div class="body-table all-merged-event">
                                        <table>
                                            <thead>
                                                <tr class="table-header">
                                                    <th>
                                                        Date
                                                    </th>
                                                    <th></th>
                                                    <th>
                                                        <p>Creater</p>
                                                        <p>Title </p>
                                                        <p>Description</p>
                                                    </th>
                                                </tr>    
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">2/9</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Quốc Khánh</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">20/3</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Quốc Tế Hạnh Phúc</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">21/9</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Quốc Tế Hòa Bình</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">1/5</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Quốc tế Lao Động</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">6/6</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày truyền thống người cao tuổi Việt Nam</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>

                                </div>


                                <!--pop-up-alleventdetail-->
                                <div class="modal fade" id="view-event-detail" aria-hidden="true"
                                     aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">

                                            <div class="edit-event-detail-popper">
                                                <div class="edit-event-detail-popper-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="edit-event-detail-popper-header-body view-allevent-detail">
                                                    <!--                                                    <table>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-cube" style="color: blue"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <div>
                                                                                                                        <p style="font-weight: 600; font-size: 23px">Hello</p>
                                                                                                                        <p>1 March 2024, 11:30pm - 2 March 2024, 12:30am</p>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-map-marker-alt"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    HaNoi - Hola
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-bell"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    10 minutes before
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-calendar-week"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    Pham Phong
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <!--homepage3-->
                            <div class="tab-pane fade" id="pills-contact" role="tabpanel" aria-labelledby="pills-contact-tab" tabindex="0">
                                <div class="select-month-option-find">
                                    Select month: <input id="month"type="month" name="month"/>
                                    <button onclick="searchEventByMonth()"><i class="fas fa-search"></i></button>
                                </div>
                                <div class="body-mine">
                                    <div class="body-table my-event">
                                        <table>
                                            <thead>
                                                <tr class="table-header">
                                                    <th>
                                                        Date
                                                    </th>
                                                    <th></th>
                                                    <th>
                                                        <p>Creater</p>
                                                        <p>Title </p>
                                                        <p>Description</p>
                                                    </th>
                                                </tr>    
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">28/6</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Gia Đình Việt Nam</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">2/5</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Của Mẹ</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">8/3</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Quốc Tế Phụ Nữ</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">20/10</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Phụ Nữ Việt Nam</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div>
                                                            <h4 class="no-padding-margin">3/6</h4>
                                                            <p style="font-size: 15px">(02/31)</p>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                    <td>
                                                        <div style="cursor: pointer;" >
                                                            <p> </p>
                                                            <p><i class="fas fa-circle" style="color: green"></i> Ngày Của Cha</p>
                                                            <p></p>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </tbody>


                                        </table>
                                    </div>

                                </div>
                                <!--popup-myevent-detail-->
                                <div class="modal fade" id="myevent" aria-hidden="true"
                                     aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">

                                            <div class="edit-event-detail-popper">
                                                <div class="edit-event-detail-popper-header">
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="edit-event-detail-popper-header-body view-myevent-detail">
                                                    <!--                                                    <table>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-cube" style="color: blue"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <div>
                                                                                                                        <p style="font-weight: 600; font-size: 23px">Hello</p>
                                                                                                                        <p>1 March 2024, 11:30pm - 2 March 2024, 12:30am</p>
                                                                                                                    </div>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-map-marker-alt"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    HaNoi - Hola
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-bell"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    10 minutes before
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td>
                                                                                                                    <i class="fas fa-calendar-week"></i>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    Pham Phong
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                        </table>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>      
                <!-- End Calendar -->
            </div>              
        </div>

        <!-- Event -->       
        <div class="modal fade" id="upComing" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg" >
                <div class="modal-content" >
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Upcoming Event </h1>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <h5 style="padding:10px 15px " class="">Date now: ${datenow}</h5>
                    <div class="modal-body " style="height: 400px;
                         overflow-y: scroll;
                         background-color: #8080801c">

                        <c:forEach items="${eventListComingUp}" var="elcu">
                            <div class="pop-up-up-coming-event">
                                <img src="img/${elcu.image}" width="40px" alt="alt"/><label style="margin-left: 5px;font-size: 20px">  ${elcu.name} 's event</label>
                                <div style="display: flex; justify-content: space-between">
                                    <div>
                                        <label for="name" style="font-size: 20px;font-weight: 700;">Title: ${elcu.title}</label>     
                                    </div>
                                    <div class="pop-up-up-coming-even-title">
                                        <h6>${elcu.dayafter} days left</h6>
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
        <!-- End Event -->

        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>   
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/main.js"></script>
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/moment.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
        <script src="templates/js/swipter-bundle.js"></script>
        <script src="js/calendar.js"></script>
        <script>
                                        var process = document.getElementById("process");

                                        if (process.value === "updatephone") {
                                            showSuccess("Phone number updated successfully!");
                                        }

                                        function searchEventByMonth() {
                                            var selectedMonth = document.getElementById("month").value;

                                            if (!selectedMonth) {
                                                alert("Please select a month before searching.");
                                                return;
                                            }
                                            var myevent = document.getElementsByClassName("my-event")[0];
                                            myevent.innerHTML = "";
                                            $.ajax({
                                                url: '/SocialCellNetwork/filterevent',
                                                type: 'POST',
                                                data: {
                                                    month: selectedMonth
                                                },
                                                success: function (data) {
                                                    console.log("Successful");

                                                    myevent.innerHTML = data;
                                                },
                                                error: function (xhr) {

                                                    console.log("Error:", xhr.statusText);
                                                }
                                            });
                                        }
                                        ;

                                        function searchAllEventByMonth() {
                                            var selectedMonth = document.getElementById("allevent_month").value;
                                            if (!selectedMonth) {
                                                alert("Please select a month before searching.");
                                                return;
                                            }
                                            var allmergedevent = document.getElementsByClassName("all-merged-event")[0];
                                            allmergedevent.innerHTML = "";
                                            $.ajax({
                                                url: '/SocialCellNetwork/filterallevent',
                                                type: 'POST',
                                                data: {
                                                    month: selectedMonth
                                                },
                                                success: function (data) {
                                                    console.log("Successful");

                                                    allmergedevent.innerHTML = data;
                                                },
                                                error: function (xhr) {

                                                    console.log("Error:", xhr.statusText);
                                                }
                                            });
                                        }
                                        ;
                                        function openEventdetail(eventid) {
                                            console.log("test");
                                            var allEventDetail = document.getElementsByClassName("view-allevent-detail")[0];
                                            allEventDetail.innerHTML = "";
                                            $.ajax({
                                                url: '/SocialCellNetwork/filterallevent',
                                                type: 'GET',
                                                data: {
                                                    eventid: eventid.toString()
                                                },
                                                success: function (data) {
                                                    console.log("Successful");
                                                    allEventDetail.innerHTML = data;
                                                    $('#view-event-detail').modal('show');
                                                },
                                                error: function (xhr) {

                                                    console.log("Error:", xhr.statusText);
                                                }
                                            });
                                        }
                                        ;
                                        function openMyEventdetail(eventid) {
                                            console.log("test122");
                                            var myEventDetail = document.getElementsByClassName("view-myevent-detail")[0];
                                            myEventDetail.innerHTML = "";
                                            $.ajax({
                                                url: '/SocialCellNetwork/filterevent',
                                                type: 'GET',
                                                data: {
                                                    eventid: eventid.toString()
                                                },
                                                success: function (data) {
                                                    console.log("Successful");
                                                    myEventDetail.innerHTML = data;
                                                    $('#myevent').modal('show');
                                                },
                                                error: function (xhr) {

                                                    console.log("Error:", xhr.statusText);
                                                }
                                            });
                                        }
                                        ;
                                        function showSuccess(text) {
                                            var alerttext = document.getElementById('alert-text');
                                            alerttext.innerHTML = text;
                                            var alertDiv = document.querySelector(".login-success-alert").cloneNode(true);
                                            alertDiv.classList.remove("d-none");
                                            var progressBar = alertDiv.querySelector(".progress-bar");
                                            var width = 0;
                                            var shouldStop = false;

                                            var interval = setInterval(function () {
                                                if (width >= 100 || shouldStop) {
                                                    clearInterval(interval);

                                                    setTimeout(function () {
                                                        alertDiv.classList.add("d-none");
                                                        alertDiv.remove();
                                                    }, 1000);
                                                } else {
                                                    width += 12;
                                                    progressBar.style.width = width + "%";
                                                }
                                            }, 300);

                                            document.getElementById('alerts-container').appendChild(alertDiv);
                                        }
                                        ;



        </script>

        <!--        <script>
                    function openEventdetail(n) {
                        var modal = new bootstrap.Modal(document.getElementById("view-event-detail-pop-up-" + n));
                        modal.show();
                    }
        
                </script>-->

        <script type="application/json" id="loadAllEventByUserId">
            ${loadAllEventByUserId}
        </script>



    </body>

</html>
