
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
        <link rel="stylesheet" href="templates/css/chosen.css">

    </head>

    <body>
        <%@include file="/components/header.jsp"%>
        <div class="container-fluid body-content">
            <div class="row">
                <div class="showlist-title">
                    <h3>${date} </h3>
                </div>
                <!--show all event-->
                <c:forEach items="${loadAllEventsByUserIdAndStartDate}" var="sl" varStatus="loop" >

                    <!--Add remind-->
                    <div class="modal fade" id="remindevent-edit-pop-up-${sl.event_id}" aria-hidden="true"
                         aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                        <!--                        <div class="modal-dialog modal-dialog-centered">
                                                    <div class="modal-content">
                                                        <div class="modal-header">
                                                            <h1 class="modal-title fs-5" id="">Remind Event</h1>
                                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                        </div>
                                                        <div class="modal-body choose-group-item">
                        
                                                            <input type="text" name="title" placeholder="Type title here!" style="border-radius: 5px; border: none; background-color: rgba(128, 128, 128, 0.18  )"/>
                                                            <div style="display: flex; justify-content: space-between">
                                                                <input type="date" name="date" style="width: 60%; margin-bottom: 0px">
                                                                <button style="padding: 5px 20px; border-radius: 5px; background-color: aqua; border: none">Add</button>
                                                            </div>
                        
                                                            <div style="font-size: 23px;font-weight: 600; margin-top: 20px ">List reminds:</div>
                                                            <div>
                                                                <div style="display: flex; justify-content: space-between">
                                                                    <div style="font-size: 20px">Wedding</div>
                                                                    <div style="color: blue;font-size: 15px; font-weight: 500">Next 4 days</div>      
                                                                </div>
                                                                <div style="margin-left: 10px">01/01/2024</div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>-->
                    </div>

                    <!--delete pop up confirm-->
                    <div class="modal fade" id="event-delete-pop-up-${sl.event_id}" aria-hidden="true"
                         aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Alert</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"
                                            aria-label="Close"></button>
                                </div>                                                                   
                                <div class="modal-body">
                                    Are you sure you want to delete the event?
                                </div>
                                <div class="modal-footer">
                                    <!-- xử lý delete the family -->
                                    <button onclick="deleteEvent(${sl.event_id},${date})" class="btn btn-primary">OK</button>
                                    <!--type =0--> 
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--Tag member-->
                    <div class="modal fade" id="tagmember-${sl.event_id}" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Tag member</h1>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                </div>
                                <div class="modal-body" id="taguser-${sl.event_id}">


                                    <!--                                    <label>Tag your friends:</label>
                                                                        <div>
                                                                            <select name="" id="" class="anymember" multiple style="width: 100%;">
                                                                                data from ajax
                                    
                                                                            </select>
                                                                        </div>-->

                                </div>
                                <c:if test="${sl.user_id == currentUser.user_id&&sl.family_id == 0}">

                                    <div class="modal-footer">
                                        <input type="hidden" id="event-description-${sl.event_id}" value="${sl.title}" />
                                        <input type="hidden" id="event-start-date-${sl.event_id}" value="${sl.start_date.toString().substring(0,10)}" />
                                        <button class="btn btn-primary" onclick="editTagmember(${sl.event_id})">Save</button>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-12">
                        <div class="modal-body event-create-pop-up">

                            <input type="hidden" name="date" value="${date}">
                            <input type="hidden" name="eventid" value="${sl.event_id}">

                            <div class="date-delete-update">
                                <div class="date-delete-update-icon" style="position: relative">

                                    <a  onclick="tagMember(${sl.event_id},${sl.user_id})" data-bs-toggle="modal" style="position: relative"><i class="fas fa-user-tag"></i> <span class="tagfriendmemberquantity">+${countTag[loop.index]}</span></a>
                                    <a  onclick="showRemind(${sl.event_id})"><i class="fas fa-bell"></i></a>
                                        <c:if test="${sl.user_id==currentUser.user_id && sl.family_id==0}">
                                        <a data-bs-target="#event-delete-pop-up-${sl.event_id}" data-bs-toggle="modal"  style="color: black;"><i class="fas fa-trash"></i></a>
                                        </c:if>
                                </div>
                                <div>
                                    <c:choose>
                                        <c:when test="${sl.user_id == currentUser.user_id}">
                                            <c:choose>
                                                <c:when test="${sl.family_id == 0}">
                                                    <label for="name">${sl.frequency == 0 ? 'My event (Event of every year)' : 'My event'}</label><br>
                                                </c:when>
                                                <c:otherwise>
                                                    <label for="name">Event of ${sl.name} family${sl.frequency == 0 ? ' (Event of every year)' : ''}</label><br>
                                                </c:otherwise>
                                            </c:choose>

                                            <input class="input-edit-event" type="text" value="${sl.title}" 
                                                   name="title" ${sl.frequency == 0 ? 'readonly=""' : ''} data-eventid="${sl.event_id}" >
                                        </c:when>
                                        <c:otherwise>
                                            <label for="name">Event of ${sl.name}${sl.frequency == 0 ? ' (Event of every year)' : ''}</label><br>
                                            <input class="input-edit-event" type="text" value="${sl.title}" 
                                                   name="title" readonly="">
                                        </c:otherwise>
                                    </c:choose>
                                </div>



                                <c:if test="${sl.user_id == currentUser.user_id&&sl.family_id == 0}">
                                    <div class="input-event-fre-rep">
                                        <div>
                                            <label for="repeat">Repeat</label>
                                            <select name="repeat" data-eventid="${sl.event_id}">
                                                <c:if test="${sl.frequency==1}">
                                                    <option value="1" >one-time</option>
                                                </c:if>
                                                <c:if test="${sl.frequency==0}">
                                                    <option value="0">Every year</option>                                          
                                                </c:if>
                                            </select>
                                        </div>

                                    </div>

                                    <div class="access_event">
                                        <label for="access">Access</label>
                                        <div>
                                            <input type="radio" name="access${sl.event_id}" value="1" ${sl.access==1 ?'checked':''} data-eventid="${sl.event_id}" >Private
                                        </div>
                                        <div>
                                            <input type="radio" name="access${sl.event_id}" value="0" ${sl.access==0 ?'checked':''} data-eventid="${sl.event_id}" >Public
                                        </div>
                                    </div>
                                </c:if>
                                <label for="place">Place</label>
                                <input class="input-edit-event" type="text" name="place" value="${sl.place}" data-eventid="${sl.event_id}">

                                <label for="description">Description</label>
                                <textarea class="input-edit-event" name="description" rows="6"
                                          cols="60" data-eventid="${sl.event_id}"  >${sl.description}</textarea>
                                <c:if test="${sl.user_id == currentUser.user_id&&sl.family_id == 0}">
                                    <div class="button-save">
                                        <button class="btn btn-primary" 
                                                data-bs-toggle="modal" onclick="updateEvent(${sl.event_id})" >Save</button>
                                    </div>
                                </c:if>
                            </div>

                        </div>
                    </div>
                </c:forEach>

                <!-- jquery-->
                <script src="templates/js/jquery.min.js"></script>
                <!-- Bootstrap js -->
                <script src="templates/js/bootstrap.min.js"></script>
                <!-- Custom Js -->
                <script src="js/main.js"></script>
                <script src="templates/js/chosen.jquery.js" type="text/javascript"></script>   

                <script>
                                                    function deleteEvent(eventid) {

                                                        $.ajax({
                                                            url: 'eventcontroller',
                                                            type: 'GET',
                                                            data: {
                                                                eventid: eventid,

                                                                type: 0
                                                            },
                                                            success: function (response) {
                                                                localStorage.setItem("showSuccess", "true");

                                                                window.location.reload();
                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
                                                            }
                                                        });
                                                    }
                                                    ;
                                                    function updateEvent(eventid) {
                                                        var titleInput = $('input[name="title"][data-eventid="' + eventid + '"]');
                                                        console.log(titleInput.val());
                                                        var frequencySelect = $('select[name="repeat"][data-eventid="' + eventid + '"]');
                                                        console.log(frequencySelect.val());

                                                        var accessInput = $('input[name="access' + eventid + '"][data-eventid="' + eventid + '"]:checked');
                                                        console.log(accessInput.val());

                                                        var placeInput = $('input[name="place"][data-eventid="' + eventid + '"]');
                                                        console.log(placeInput.val());

                                                        var descriptionInput = $('textarea[name="description"][data-eventid="' + eventid + '"]');
                                                        console.log(descriptionInput.val());
                                                        var title = titleInput.val() || '';
                                                        var place = placeInput.val() || '';
                                                        var description = descriptionInput.val() || '';
                                                        var frequency = frequencySelect.val();
                                                        var access = accessInput.val();
                                                        console.log(description);
                                                        $.ajax({
                                                            url: 'eventcontroller',
                                                            type: 'GET',
                                                            data: {
                                                                eventid: eventid,
                                                                type: 1,
                                                                title: title,
                                                                place: place,
                                                                description: description,
                                                                feq: frequency,
                                                                access: access

                                                            },
                                                            success: function (response) {
                                                                showSuccess('Event updated successfully!!');
                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
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
                                                    function showRemind(event_id) {
                                                        console.log(event_id);
                                                        var showRemind = document.getElementById('remindevent-edit-pop-up-' + event_id);
                                                        showRemind.innerHTML = "";
                                                        $.ajax({
                                                            url: 'showremind',
                                                            type: 'GET',
                                                            data: {
                                                                event_id: event_id

                                                            },
                                                            success: function (data) {
                                                                console.log('Successful');
                                                                showRemind.innerHTML = data;
                                                                $('#remindevent-edit-pop-up-' + event_id).modal('show');

                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
                                                            }
                                                        });
                                                    }
                                                    ;


                                                    function addRemind(eventid) {
                                                        var title = document.getElementById('text' + eventid).value;
                                                        var date = document.getElementById('date' + eventid).value;
                                                        console.log(title);
                                                        console.log(date);
                                                        if (!title || !date) {
                                                            alert("Title or date cannot be empty!");
                                                        } else {

                                                            $.ajax({
                                                                url: 'showremind',
                                                                type: 'POST',
                                                                data: {
                                                                    event_id: eventid,
                                                                    title: title,
                                                                    date: date

                                                                },
                                                                success: function (data) {
                                                                    showRemind(eventid);
                                                                    showSuccess('Add remind sucessfully!');

                                                                },
                                                                error: function (xhr, status, error) {

                                                                    alert("Error: " + error);
                                                                }
                                                            });
                                                        }
                                                    }
                                                    ;
                                                    function deleteRemind(remind_id, eventid) {
                                                        console.log(remind_id);
                                                        $.ajax({
                                                            url: 'remindcontroller',
                                                            type: 'POST',
                                                            data: {
                                                                remind_id: remind_id
                                                            },
                                                            success: function (data) {
                                                                showRemind(eventid);
                                                                showSuccess('Delete remind sucessfully!');

                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
                                                            }
                                                        });

                                                    }
                                                    ;
                                                    function tagMember(eventid, userid) {
                                                        console.log(eventid);
                                                        var showTagMember = document.getElementById('taguser-' + eventid);
                                                        showTagMember.innerHTML = "";

                                                        $.ajax({
                                                            url: 'tagmembercontroller',
                                                            type: 'GET',
                                                            data: {
                                                                eventid: eventid,
                                                                userid: userid
                                                            },
                                                            success: function (data) {
                                                                console.log('sucessfully');
                                                                showTagMember.innerHTML = data;
                                                                $('#tagmember-' + eventid).modal('show');
                                                                $('#tagmember, #addevent').on('shown.bs.modal', function () {
                                                                    $(this).find('.anymember').chosen('destroy').chosen(); // Reinitialize Chosen
                                                                });
                                                                $('.anymember').chosen();

                                                                var chosenContainers = document.querySelectorAll('.chosen-container.chosen-container-multi');

                                                                chosenContainers.forEach(function (container) {
                                                                    container.style.width = '100%';
                                                                });



                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
                                                            }
                                                        });
                                                    }
                                                    ;
                                                    function editTagmember(eventid) {

                                                        var selectedMembers = $("#tagMemberSelect" + eventid).val();
                                                        var eventDescription = $("#event-description-" + eventid).val();
                                                        var eventStartDate = $("#event-start-date-" + eventid).val();
                                                        console.log(selectedMembers);
                                                        console.log("Event Description:", eventDescription);
                                                        console.log("Event Start Date:", eventStartDate);
                                                        $.ajax({
                                                            url: 'tagmembercontroller',
                                                            type: 'POST',

                                                            data: {
                                                                eventid: eventid,
                                                                selectedMembers: selectedMembers,
                                                                description: eventDescription,
                                                                event_id: eventStartDate
                                                            },

                                                            success: function (data) {
                                                                console.log("successful");
                                                                $('#tagmember-' + eventid).modal('hide');

                                                                showSuccess('Update tag member successfully!');
                                                                window.location.reload();
                                                            },
                                                            error: function (xhr, status, error) {

                                                                alert("Error: " + error);
                                                            }
                                                        });



                                                    }






                </script>
                <script>
                    $(document).ready(function () {
                        if (localStorage.getItem("showSuccess") === "true") {
                            localStorage.removeItem("showSuccess");
                            showSuccess('Event deleted successfully!!');
                        }
                    });
                </script>

                <script type="text/javascript">
                    $('#tagmember, #addevent').on('shown.bs.modal', function () {
                        $(this).find('.anymember').chosen('destroy').chosen(); // Reinitialize Chosen
                    });
                    $('.anymember').chosen();

                    // Đảm bảo DOM hoàn toàn tải xong
                    window.onload = function () {
                        var chosenContainers = document.querySelectorAll('.chosen-container.chosen-container-multi');

                        // Set chiều rộng cho tất cả phần tử tìm được
                        chosenContainers.forEach(function (container) {
                            container.style.width = '100%';
                        });
                    };
                </script>


                </body>

                </html>