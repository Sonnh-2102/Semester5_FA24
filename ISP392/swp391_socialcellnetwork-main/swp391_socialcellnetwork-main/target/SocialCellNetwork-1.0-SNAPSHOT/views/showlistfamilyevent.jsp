
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html class="no-js" lang="">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Event</title>
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
        <link rel="stylesheet" href="css/showlistevent.css">

    </head>

    <body>
        <%@include file="/components/header.jsp"%>
        <div class="container-fluid body-content">
            <div class="row">
                <div class="showlist-title">
                    <h3>${date} </h3>
                </div>
                <!--show my event-->
                <c:forEach items="${loadFamilyEventsByStartDate}" var="sl" >
                    <div class="col-lg-12">
                        <div class="modal-body event-create-pop-up">
                            <input type="hidden" name="eventid" value="${sl.event_id}">


                            <div class="date-delete-update">
                                <c:if test="${familymember.getRole() == 1}">
                                    <div class="date-delete-update-icon">
                                        <a href="familyeventcontroller?eventid=${sl.event_id}&date=${date}&type=0&familyid=${family.family_id}"  style="color: black;"><i class="fas fa-trash"></i></a>
                                    </div>
                                </c:if>
                                <div>
                                    <c:if test="${sl.frequency==1}">
                                        <label  for="name">Family event</label><br>
                                        <input class="input-edit-event"  type="text" value="${sl.title}" 
                                               name="title" >
                                    </c:if>
                                    <c:if test="${sl.frequency==0}">
                                        <label  for="name">Family event (Event of every year)</label><br>
                                        <input class="input-edit-event"  type="text" value="${sl.title}" readonly=""
                                               name="title" >
                                    </c:if>
                                </div>
                                <form action="familyeventcontroller" method="get">
                                    <input type="hidden" name="familyid" value="${family.family_id}">
                                    <input type="hidden" name="type" value="1">
                                    <input type="hidden" name="date" value="${date}">
                                    <div class="input-event-fre-rep" >
                                        <c:if test="${sl.frequency==1}">
                                            <div>
                                                <label for="repeat">Repeat</label>
                                                <select name="repeat" id="">
                                                    <option value="1" >one-time</option>
                                                </select>
                                            </div>
                                        </c:if>
                                        <c:if test="${sl.frequency==0}">
                                            <div>
                                                <label for="repeat">Repeat</label>
                                                <select name="repeat" id="">                                           
                                                    <option value="0">Every year</option>
                                                </select>
                                            </div>
                                        </c:if>
                                        <!--                                        <div><label for="first_remind">Remind 1st</label>
                                                                                    <select name="first_remind" id="">
                                                                                        <option value="">none</option>
                                                                                        <option value="">1 day before</option>
                                                                                        <option value="">2 day before</option>
                                                                                        <option value="">3 day before</option>
                                                                                    </select>
                                                                                </div>
                                                                                <div><label for="second_remind">Remind 2nd</label>
                                                                                    <select name="second_remind" id="">
                                                                                        <option value="">none</option>
                                                                                        <option value="">1 day before</option>
                                                                                        <option value="">2 day before</option>
                                                                                        <option value="">3 day before</option>
                                                                                    </select>
                                                                                </div>-->
                                    </div>
                                    <label for="place">Place</label>
                                    <input class="input-edit-event" type="text" name="place" value="${sl.place}">

                                    <label for="description">Description</label>
                                    <textarea class="input-edit-event" name="description" rows="6"
                                              cols="60" >${sl.description}</textarea>


                                </form>
                                <c:if test="${familymember.getRole() == 1}">
                                    <div class="button-save" style="display: flex;justify-content: space-between">
                                        <a href="familycalendar?familyid=${family.family_id}" class="btn btn-danger">Back to family calendar</a>
                                        <button class="btn btn-primary" 
                                                data-bs-toggle="modal">Save</button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>
                </c:forEach>


            </div>
            <!-- jquery-->
            <script src="templates/js/jquery.min.js"></script>
            <!-- Bootstrap js -->
            <script src="templates/js/bootstrap.min.js"></script>
            <!-- Custom Js -->
            <script src="js/main.js"></script>

    </body>



</html>