<%-- 
    Document   : header
    Created on : Jan 17, 2024, 11:08:55 PM
    Author     : PC-Phong
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>Social Cell Network</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Favicon -->
        <link rel="shortcut icon" type="image/x-icon" href="img/logo.png">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <!-- Flaticon CSS -->
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="css/header.css">
    </head>
    <body>

        <!--Progress for delete successful-->
        <div id="alerts-container">        
            <div class="login-success-alert d-none">
                <div id="alert-text" class="text-white"></div>            
                <div class="progress-container">
                    <div class="progress-bar"></div>
                </div>
            </div>
        </div>

        <nav class=" navbar-ver1 navbar-expand-lg navbar-dark">
            <div class="container-fluid .no-padding-margin">
                <!-- Brand and toggle get grouped for better mobile display -->
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                        aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <div class="container-fluid">
                        <div class="row">
                            <div class="col-lg-2 navbar-list-option-left">
                                <!-- <img src="img/logo.png" alt=""> -->
                                <form class="d-flex nav-search" action="addfriend" method="GET">
                                    <input class="form-control" id="key" type="search" name="searchQuery" placeholder="Search" aria-label="Search">
                                    <button class="btn btn-outline-light" type="submit" style="border-radius: 0px 5px 5px 0px;" onclick="return validateSearch()"><i class="fas fa-search"></i></button>
                                </form>

                            </div>
                            <div class="col-lg-8 navbar-list-option-mid">
                                <ul class="navbar-nav">

                                    <li class="nav-item">
                                        <a class="nav-link active" href="home"><i class="fas fa-home"></i></a>
                                    </li>

                                    <li class="nav-item">
                                        <a class="nav-link active" data-bs-target="#chooseFamilyPopUp" data-bs-toggle="modal"
                                           ><i class="fas fa-users"></i></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" href="boxchat"><i class="far fa-comment-dots"></i></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link active" href="familytree?isIndividualTree=true"><i class="fas fa-tree"></i></a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                </div><!-- /.navbar-collapse -->
                <div class="col-lg-2 navbar-list-option-right">
                    <ul class="navbar-nav">
                        <li class="nav-item" style="position: relative">
                            <a class="nav-link active" id="notification-button"><i class="fas fa-bell"></i> <span class="aleart-notification"></span></a>

                        </li> 

                        <li class="nav-item">
                            <a class="nav-link active" id="link" data-bs-target="#log-out" data-bs-toggle="modal"><i class="fas fa-sign-out-alt"></i></a>
                        </li>

                    </ul>
                </div>
            </div><!-- /.container-fluid -->

        </nav>
        <!-- End Nav -->
        <!--pop-up logout-->
        <div class="modal fade" id="log-out" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
             aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Are you sure to log out?</h1>
                    </div>
                    <div class="modal-body" style="display: flex; justify-content: space-between;">
                        <button type="button" class="btn btn-danger" class="btn-close" data-bs-dismiss="modal">No</button>                       
                        <a href="logout" class="btn btn-primary" style="text-decoration: none; color:white">
                            Yes
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!--notification-->
        <div class="notification" id="notification">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <button class="nav-link active" id="nav-home-tab" data-bs-toggle="tab" data-bs-target="#nav-home" type="button" role="tab" aria-controls="nav-home" aria-selected="true">Friend</button>
                    <button class="nav-link" id="nav-profile-tab" data-bs-toggle="tab" data-bs-target="#nav-profile" type="button" role="tab" aria-controls="nav-profile" aria-selected="false">Tag Event</button>
                    <button class="nav-link" id="nav-contact-tab" data-bs-toggle="tab" data-bs-target="#nav-contact" type="button" role="tab" aria-controls="nav-contact" aria-selected="false">Remind event</button>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab" tabindex="0">
                    <div class="notification-title">Connect requires</div>
                    <c:set var="hasConnectNotifications" value="false" />                
                    <c:forEach var="notification" items="${sessionScope.notifications}">                       
                        <c:if test="${notification.notification_type == 1}">
                            <c:set var="hasConnectNotifications" value="true" />
                            <div class="notification-component-connect-require">
                                <div class="notification-image">
                                    <img src="img/${notification.senderImage}" alt="alt"/>
                                    <i class="fas fa-user-circle"></i>
                                </div>
                                <div class="notification-description">
                                    <p><span>${notification.description}</span></p>
                                    <p class="notification-description-day">${notification.date.toString().substring(0,10)}</p>
                                    <div class="notification-description-button" style="display: flex; justify-content: space-around; margin-top: 10px;">
                                        <form action="notification" method="POST" style="margin: 0;">
                                            <input type="hidden" name="notificationId" value="${notification.notification_id}">
                                            <input type="hidden" name="relatiID" value="${notification.relation_id}">
                                            <input type="hidden" name="action" value="accept">
                                            <button class="first-child">Accept</button>
                                        </form>
                                        <form action="notification" method="POST" style="margin: 0;">
                                            <input type="hidden" name="notificationId" value="${notification.notification_id}">
                                            <input type="hidden" name="relatiID" value="${notification.relation_id}">
                                            <input type="hidden" name="action" value="reject">
                                            <button type="submit">Reject</button>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                        <c:if test="${notification.notification_type == 2}">
                            <c:set var="hasConnectNotifications" value="true" />
                            <div class="notification-component-connect-require">
                                <div class="notification-image">
                                    <img src="img/${notification.senderImage}" alt="alt"/>
                                    <i class="fas fa-user-circle"></i>
                                </div>
                                <div class="notification-description">
                                    <p><span>${notification.description}</span></p>
                                    <p class="notification-description-day">${notification.date.toString().substring(0,10)}</p>
                                </div>
                                <div>
                                    <i class="fas fa-minus-circle" style="color:red; font-size: 20px; cursor: pointer" data-bs-toggle="modal" data-bs-target="#disconnectModal${notification.notification_id}"></i>
                                </div>
                            </div>
                        </c:if>
                        <div class="modal fade" id="disconnectModal${notification.notification_id}" tabindex="-1" aria-labelledby="disconnectModalLabel${notification.notification_id}" aria-hidden="true">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="disconnectModalLabel${notification.notification_id}">Delete Confirmation</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                    </div>
                                    <div class="modal-body">
                                        Are you sure to delete notification?
                                    </div>
                                    <div class="modal-footer">
                                        <form action="notification" method="POST">
                                            <input type="hidden" name="notificationId" value="${notification.notification_id}">
                                            <input type="hidden" name="relatiID" value="${notification.relation_id}">
                                            <input type="hidden" name="action" value="delete">
                                            <button type="submit" class="btn btn-danger">Confirm delete</button>
                                        </form>
                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                    <c:if test="${!hasConnectNotifications}">
                        <div class="alert alert-info" style="margin-top: 30px">No notifications.</div>
                    </c:if>
                </div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab" tabindex="0">
                    <div class="notification-title">Tag Events</div>
                    <!--su kien-->
                    <c:set var="hasEventNotifications" value="false"/>
                    <c:forEach var="notification" items="${sessionScope.notifications}">
                        <c:if test="${notification.notification_type == 3}">
                            <c:if test="${notification.getRemind_event() == null}">
                                <c:set var="hasEventNotifications" value="true"/>
                                <div class="notification-component-connect-require">
                                    <div class="notification-image">
                                        <img src="img/${notification.senderImage}" alt="alt"/>
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="notification-description">
                                        <p><span>${notification.description}</span></p>
                                        <p class="notification-description-day">${notification.date.toString().substring(0,16)}</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-minus-circle" style="color:red; font-size: 20px; cursor: pointer" data-bs-toggle="modal" data-bs-target="#disconnectEventModal${notification.notification_id}"></i>
                                    </div>
                                </div>
                                <div class="modal fade" id="disconnectEventModal${notification.notification_id}" tabindex="-1" aria-labelledby="disconnectEventModal${notification.notification_id}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="disconnectEventModal${notification.notification_id}">Delete Confirmation</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Are you sure to delete notification?
                                            </div>
                                            <div class="modal-footer">
                                                <form action="notification" method="POST">
                                                    <input type="hidden" name="notificationId" value="${notification.notification_id}">
                                                    <input type="hidden" name="relatiID" value="${notification.relation_id}">
                                                    <input type="hidden" name="action" value="delete">
                                                    <button type="submit" class="btn btn-danger">Confirm delete</button>
                                                </form>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${notification.getRemind_event() != null && dateNow.toString().substring(0,10) eq notification.remind_event.toString().substring(0,10)}">                           
                                <c:set var="hasEventNotifications" value="true"/>
                                <div class="notification-component-connect-require">
                                    <div class="notification-image">
                                        <img src="img/${notification.senderImage}" alt="alt"/>
                                        <i class="fas fa-calendar-check"></i>
                                    </div>
                                    <div class="notification-description">
                                        <p><span>${notification.description}</span></p>
                                        <p class="notification-description-day" style="color: red">On Day</p>
                                    </div>
                                    <div>
                                        <i class="fas fa-minus-circle" style="color:red; font-size: 20px; cursor: pointer" data-bs-toggle="modal" data-bs-target="#disconnectRemineModal${notification.notification_id}"></i>
                                    </div>
                                </div>
                                <div class="modal fade" id="disconnectRemineModal${notification.notification_id}" tabindex="-1" aria-labelledby="disconnectRemineModal${notification.notification_id}" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title" id="disconnectModalLabel${notification.notification_id}">Delete Confirmation</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>
                                            <div class="modal-body">
                                                Are you sure to delete notification?
                                            </div>
                                            <div class="modal-footer">
                                                <form action="notification" method="POST">
                                                    <input type="hidden" name="notificationId" value="${notification.notification_id}">
                                                    <input type="hidden" name="relatiID" value="${notification.relation_id}">
                                                    <input type="hidden" name="action" value="delete">
                                                    <button type="submit" class="btn btn-danger">Confirm delete</button>
                                                </form>
                                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </c:if>
                    </c:forEach>
                    <c:if test="${!hasEventNotifications}">
                        <div class="alert alert-info" style="margin-top: 30px">No notifications.</div>
                    </c:if>
                </div>
                <div class="tab-pane fade" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab" tabindex="0">
                    <div class="notification-title">Remind Events</div>
                    <c:if test="${showRemindEventByTargetUser.size() == 0}">
                        <div class="alert alert-info" style="margin-top: 30px">No remind event.</div>
                    </c:if>
                    <c:forEach items="${showRemindEventByTargetUser}" var="sre">
                        <div class="notification-component-event">
                            <div class="notification-image">
                                <img src="img/${sre.img}" alt="alt"/>
                                <i class="fas fa-calendar-week"></i>

                            </div>
                            <div class="notification-description">
                                <p><span>${sre.fullname}'s Event:</span> ${sre.event_title} </p>
                                <p>Remind title: ${sre.remind_title}</p>
                                <c:if test="${sre.dayafter==0}" >
                                    <p class="notification-description-day">In day</p>
                                </c:if>
                                <c:if test="${sre.dayafter>0}" >
                                    <p class="notification-description-day">${sre.dayafter} day left</p>
                                </c:if>
                                <c:if test="${sre.dayafter<0}" >
                                    <p class="notification-description-day">Event has happened</p>
                                </c:if>

                                <div class="notification-description-place-des">
                                    <c:if test="${!sre.place.isEmpty()}"><div><span>Place:</span>${sre.place}</div></c:if>
                                    <c:if test="${!sre.description.isEmpty()}"><div><span>Description:</span> ${sre.description}</div></c:if>


                                    </div>
                                </div>
                            </div> 
                    </c:forEach>
                </div>

            </div>

        </div>

        <!--end notification-->

        <!-- Phần pop up của family -->
        <div class="modal fade" id="chooseFamilyPopUp" aria-hidden="true"
             aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Choose Family</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body choose-group-item">
                        <c:choose>
                            <c:when test="${not empty sessionScope.listfamily}">
                                <c:forEach items="${sessionScope.listfamily}" var="family">
                                    <div>
                                        <a href="familydetail?familyId=${family.getFamily_id()}" style="text-decoration: none; color: inherit;">
                                            <div class="body-content-left-avatar">
                                                <img src="img/${family.getImg()}">${family.getName()}
                                            </div>
                                        </a>
                                    </div>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <div>You have not joined any groups yet!!!</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>



        <script>
            var toggleButton = document.getElementById("notification-button");
            var toggleElement = document.getElementById("notification");
            var isNotificationVisible = false;

            toggleButton.addEventListener("click", function () {
                isNotificationVisible = !isNotificationVisible;
                toggleElement.style.display = isNotificationVisible ? "block" : "none";
            });

            window.addEventListener("click", function (event) {
                if (!toggleButton.contains(event.target) && !toggleElement.contains(event.target)) {
                    isNotificationVisible = false;
                    toggleElement.style.display = "none";
                }
            });

            function validateSearch() {
                var keyInput = document.getElementById('key');
                var key = keyInput.value.trim();
                if (key === '') {
                    event.preventDefault();
                    alert("Please fill the name or phone number to search");
                }
            }
            ;


        </script>                                    


    </body>
</html>
