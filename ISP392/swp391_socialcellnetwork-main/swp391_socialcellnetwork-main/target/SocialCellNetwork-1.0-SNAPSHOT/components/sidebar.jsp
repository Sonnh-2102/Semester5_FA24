<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : header
    Created on : Jan 17, 2024, 11:08:55 PM
    Author     : PC-Phong
--%>

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
        <link rel="stylesheet" href="templates/css/chosen.css">

        <link rel="stylesheet" href="css/sidebar.css">
        <style>

        </style>
    </head>
    <body>
        <div class="col-lg-2 body-content-left no-padding-margin">
            <div><a href="profile" class="body-content-left-avatar"><img src="img/${sessionScope.currentUser.image}">${sessionScope.currentUser.f_name} ${sessionScope.currentUser.l_name}</a></div>
            <div><a href="showstatus"><i class="far fa-newspaper"></i><span>News</span></a></div>
            <div><a href="home"><i class="fas fa-history"></i><span>Celebrate</span></a></div>
            <div><a href="boxchat"><i class="far fa-comment-dots"></i><span>Messages</span></a></div>
            <div>
                <a class="" data-bs-target="#chooseFamilyPopUp" data-bs-toggle="modal"
                   style="padding-right: 15px;"><i class="fas fa-users"></i><span>Family</span></a>
            </div>
            <div>
                <a class="" data-bs-target="#createfamily" data-bs-toggle="modal"
                   style="padding-right: 15px;"><i class="fas fa-users-cog"></i><span>Create Family</a>
            </div>

        </div>

        <!-- Phần pop up của family -->
        <div class="modal fade" id="createfamily" aria-hidden="true"
             aria-labelledby="exampleModalToggleLabel" tabindex="-1">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Create Family</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="create-family-body">
                        <form action="createfamily" method="POST">                                   
                            <div>
                                <label style="font-weight: 700;">Family Name</label><br>
                                <input class="input-edit-group" type="text" placeholder="name" name="familyname" required>
                            </div>
                            <div>
                                <label style="font-weight: 700; margin-top: 10px;">Image</label><br>
                                <img src="img/familydefault.jpg" id="image" alt="" style="width: 90px; height: 90px;margin: 10px 0px"><br>
                                <input type="file" accept="image/gif, image/jpg, image/png" placeholder="image-url" name="imageurl" onchange="chooseFile(this)" >
                            </div>
                            <div>
                                <label style="font-weight: 700; margin-top: 10px;">Introduce</label><br>
                                <textarea class="input-edit-group" id="introduction" name="introduction" rows="5" cols="35" placeholder="introduce..."></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="submit" class="btn btn-primary">Create</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!--Popup add event-->
        <form action="eventcontroller" method="post" onsubmit="return validateForm()">
            <div class="modal fade" id="addevent" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">Add event</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body event-create-pop-up" style="margin: 0px;">
                            <label for="">Template: </label> 
                            <select id="template" onchange="fillTemplate()">
                                <option value="1">Custom event</option>
                                <option value="2">Memorial day</option>                               
                                <option value="3">Longevity ceremony</option>
                                <option value="4">Happy wedding</option>
                                <option value="5">Happy birthday</option>
                            </select>
                            <a data-bs-target="#tagmember" data-bs-toggle="modal" style="float: right;cursor: pointer; color: blue"><i class="fas fa-user-tag"></i></i>Tag people</a>
                            <br/>
                            <label for="title_event">Event</label>                         
                            <input type="text" name="title_event" id="event-title" placeholder="Add title" required >

                            <label for="">Date: </label>
                            <select name="calendar_type" id="calendar_type" onchange="changeCalendar()">
                                <option value="0">solar day</option>                               
                                <option value="1">lunar day</option>
                            </select>
                            <input type="date" name="solar_date" id="solar">
                            <input type="hidden" value="" id="lunar_date" name="lunar_date">
                            <input type="text" name="" id="lunar" placeholder="dd/mm/yyyy" pattern="\d{2}/\d{2}/\d{4}" onchange="convertToSolar()">
                            <div id="changeToSolar" style="padding: 5px 0px">
                                Change to solar date (dd/mm/yyyy): <span id="lunartosolar" ></span>
                            </div>

                            <div class="input-event-fre-re">
                                <div>
                                    <label for="repeat">Repeat</label>
                                    <select name="repeat" id="repeat">
                                        <option value="1">one-time</option>
                                        <option value="0">Every year</option>
                                    </select>
                                </div>
                                <div>
                                    <label for="first_remind">Remind 1st</label>
                                    <select name="first_remind" id="first_remind" onchange="checkSelection()">
                                        <option value="">none</option>
                                        <option value="1">1 day before</option>
                                        <option value="2">2 day before</option>
                                        <option value="3">3 day before</option>
                                    </select>
                                </div>
                                <div>
                                    <label for="second_remind">Remind 2nd</label>
                                    <select name="second_remind" id="second_remind" onchange="checkSelection()">
                                        <option value="">none</option>
                                        <option value="1">1 day before</option>
                                        <option value="2">2 day before</option>
                                        <option value="3">3 day before</option>
                                    </select>
                                </div>
                            </div>
                            <div class="access_event">
                                <label for="access">Access</label>
                                <div>
                                    <input type="radio" name="access" value="1" checked> Private
                                </div>
                                <div>
                                    <input type="radio" name="access" value="0"> Public
                                </div>
                            </div>
                            <div>
                                <label for="place">Place</label>
                                <input type="text" name="place" placeholder="Add place">
                                
                            </div>
                            <div>
                                <label for="description">Description</label>
                                <textarea class="input-edit-group" name="description" rows="5"
                                          cols="60"></textarea>
                            </div>
                            <div class="button-create">
                                <button type="reset" class="btn btn-secondary">Reset</button>
                                <button class="btn btn-primary">Create</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--Tag member-->
            <div class="modal fade" id="tagmember" aria-hidden="true" aria-labelledby="exampleModalToggleLabel2" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel2">Tag member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">

                            <label>Tag your friends in the event</label>
                            <div>
                                <select name="tagfriend" class="anyuser" multiple style="width: 100%;">
                                    <c:forEach items="${loadFriendByUserId}" var="f">
                                        <option value="${f.user_id}">
                                            ${f.f_name} ${f.l_name}
                                        </option> 
                                    </c:forEach>
                                    

                                </select>
                            </div>

                        </div>

                        <div class="modal-footer">
                            <a class="btn btn-primary" data-bs-target="#addevent" data-bs-toggle="modal">Back to add event</a>
                        </div>
                    </div>
                </div>
            </div>
        </form>




        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>   
        <script src="templates/js/validator.min.js"></script> 
        <script src="js/main.js"></script>
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/moment.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
        <script src="js/sidebar.js"></script>     

        <script src="templates/js/chosen.jquery.js" type="text/javascript"></script>    

        <script type="text/javascript">
                                        $('#tagmember, #addevent').on('shown.bs.modal', function () {
                                            $(this).find('.anyuser').chosen('destroy').chosen(); 
                                        });
                                        $('.anyuser').chosen();

                                        
                                        window.onload = function () {
                                            var chosenContainers = document.querySelectorAll('.chosen-container.chosen-container-multi');

                                            chosenContainers.forEach(function (container) {
                                                container.style.width = '100%';
                                            });
                                        };
        </script>



        <script>
            function checkSelection() {
                var firstSelect = document.getElementById('first_remind');
                var secondSelect = document.getElementById('second_remind');
                for (var i = 1; i < firstSelect.options.length; i++) {
                    firstSelect.options[i].disabled = false;
                    secondSelect.options[i].disabled = false;
                }
                if (firstSelect.value !== "") {
                    var firstValue = firstSelect.value;
                    for (var i = 1; i < secondSelect.options.length; i++) {
                        if (secondSelect.options[i].value === firstValue) {
                            secondSelect.options[i].disabled = true;
                            break;
                        }
                    }
                }
                if (secondSelect.value !== "") {
                    var secondValue = secondSelect.value;
                    for (var i = 1; i < firstSelect.options.length; i++) {
                        if (firstSelect.options[i].value === secondValue) {
                            firstSelect.options[i].disabled = true;
                            break;
                        }
                    }
                }
            }

        </script>      


    </body>
</html>
