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
        <link rel="stylesheet" href="css/familysidebar.css">
    </head>
    <body>
        <!-- left nav -->
        <div class="col-lg-2 body-content-left no-padding-margin">
            <form action="familydetail" method="get" id="familyavatar">
                <input type="hidden" name="familyId" value="${family.family_id}" />
                <div class="body-content-left-avatar" onclick="submitForm()"><img src="img/${family.getImg()}" >${family.getName()}</div>
            </form>

            <div><a href="familytree?familyId=${family.family_id}"><img style="width: 30px; height: 30px; border-radius: 50%; margin-right: 20px" id="family-tree-icon" src="img/familytreeicon.png"
                                                                        alt=""><span >Family Tree</span></a></div>
            <div><a href="familycalendar?familyid=${family.family_id}"><i class="fas fa-calendar-alt"></i>Calendar</a></div>
            <c:if test="${familymember.getRole() == 0}">
                <div><a class="" data-bs-target="#outFamily" data-bs-toggle="modal"><i class="fas fa-sign-out-alt"></i>Out Family</a></div>
            </c:if>
            <c:if test="${familymember.getRole() == 1}">
                <div>
                    <a class="" data-bs-target="#addeventfamily" data-bs-toggle="modal"
                       style="padding-right: 15px;"><i class="fas fa-calendar-plus"></i><span>Add Event</span></a>
                </div>
                <div><a class="" data-bs-target="#editFamily" data-bs-toggle="modal"><i
                            class="fas fa-edit"></i>Edit
                        Family</a></div>
                <div>
                    <a class="" data-bs-target="#removemember" data-bs-toggle="modal"
                       style="padding-right: 15px;"><i class="fas fa-user-edit"></i>Remove Member</a>
                </div>
                <div>
                    <a class="" data-bs-target="#updaterole" data-bs-toggle="modal"
                       style="padding-right: 15px;"><i class="fas fa-user-edit"></i>Update Role</a>
                </div>
                <div><a class="" data-bs-target="#addMember" data-bs-toggle="modal"><i
                            class="fas fa-user-plus"></i>Add
                        Member</a></div>
                <div><a class="" data-bs-target="#removeFamily" data-bs-toggle="modal"><i
                            class="fas fa-trash"></i>Delete
                        Family</a></div>
                    </c:if>
        </div>
        <!-- End left nav -->

        <c:if test="${familymember.getRole() == 0}">
            <div class="modal fade" id="outFamily" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Alert</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <form action="outfamily" method="POST">
                            <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                            <div class="modal-body">
                                Are you sure you want to out the Family?
                            </div>
                            <div class="modal-footer">
                                <!-- xử lý out the family -->
                                <button class="btn btn-primary"
                                        data-bs-target="#exampleModalToggle2"
                                        data-bs-toggle="modal">OK</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>

        <c:if test="${familymember.getRole() == 1}">
            <div class="modal fade" id="removeFamily" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Alert</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <form action="familyadmin" method="POST">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                            <div class="modal-body">
                                Are you sure you want to delete the Family?
                            </div>
                            <div class="modal-footer">
                                <!-- xử lý delete the family -->
                                <button class="btn btn-primary"
                                        data-bs-target="#exampleModalToggle2"
                                        data-bs-toggle="modal">OK</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <!-- Phần popup của edit family -->
            <div class="modal fade" id="editFamily" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered" style="max-width: 400px">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Edit Family</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>

                        </div>
                        <div class="modal-body">
                            <!-- xử lý Edit family -->
                            <form action="familyadmin" method="POST">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                                <div>
                                    <label for="groupname" style="font-weight: 700;">Family Name</label><br>
                                    <input class="input-edit-group" type="text" value="${family.name}" name="familyname">
                                </div>
                                <div>
                                    <label for="imageurl" style="font-weight: 700; margin-top: 10px;">Image</label><br>
                                    <img src="img/${family.img}"  alt="alt" style="width: 90px; height: 90px; border-radius: 0px" id="family-image-url"/>
                                    <input type="hidden" name="image" value="${family.img}"><br>
                                    <input type="file" accept="image/gif, image/jpg, image/png" style="margin: 10px 0px;" name="imageurl" onchange="chooseFile(this)">
                                </div>
                                <div>
                                    <label for="introduction" style="font-weight: 700; margin-top: 10px;">Introduce</label><br>
                                    <textarea class="input-edit-group" id="introduction" name="introduction" rows="5" cols="40">${family.description}</textarea>
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Update</button>
                                </div>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
            <!-- Phần pop up của remove member -->
            <br><br>
            <div class="modal fade" id="removemember" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Edit Member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body"  style="overflow-y: scroll; max-height: 500px">
                            <form action="familyadmin" method="POST">
                                <input type="hidden" name="action" value="editMember">
                                <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                                <table>
                                    <c:choose>
                                        <c:when test="${not empty membersWithRole}">
                                            <c:forEach var="member" items="${membersWithRole}">
                                                <tr class="edit-member-ban-admin">
                                                    <td style="padding-right: 10px;"><img src="img/${member.getImage()}" alt=""></td>
                                                    <td style="padding-right: 20px;width: 150px; word-wrap: break-word">
                                                        <span style="font-weight: 600">${member.getF_name()}
                                                            ${member.getL_name()}</span>
                                                    </td>
                                                    <td>
                                                        <span>
                                                            <input type="hidden" name="userIds" value="${member.getUser_id()}">
                                                            <input type="checkbox" name="actionForMember_${member.getUser_id()}" value="delete"> Remove

                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3">There are currently no members to edit.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Phần pop up của edit member -->
            <br><br>
            <div class="modal fade" id="updaterole" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Edit Member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>
                        <div class="modal-body"  style="overflow-y: scroll; max-height: 500px">
                            <form action="familyadmin" method="POST">
                                <input type="hidden" name="action" value="editMember">
                                <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                                <table>
                                    <c:choose>
                                        <c:when test="${not empty membersWithRole}">
                                            <c:forEach var="member" items="${membersWithRole}">
                                                <tr class="edit-member-ban-admin">
                                                    <td style="padding-right: 10px;"><img src="img/${member.getImage()}" alt=""></td>
                                                    <td style="padding-right: 20px;width: 150px; word-wrap: break-word">
                                                        <span style="font-weight: 600">${member.getF_name()}
                                                            ${member.getL_name()}</span>
                                                    </td>
                                                    <td>
                                                        <span>
                                                            <input type="hidden" name="userIds" value="${member.getUser_id()}">
                                                            <input type="checkbox" name="actionForMember_${member.getUser_id()}" value="admin"> Leader
                                                        </span>
                                                    </td>
                                                </tr>
                                                <tr>                                                   
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="3">There are currently no members to edit.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </table>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" type="submit">Update</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Phần pop up của add member -->
            <div class="modal fade" id="addMember" aria-hidden="true"
                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Add Member</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <div class="d-flex nav-search">
                                <input class="form-control" type="search" id="searchQuery" placeholder="Search" aria-label="Search" style="background-color: rgba(128, 128, 128, 0.18 );">
                                <button class="btn" type="button" onclick="searchMember()"
                                        style="border-radius: 0px 5px 5px 0px; background: linear-gradient(to right,#9370DB, #87CEEB);color:white"><i class="fas fa-search"></i></button>
                            </div>
                            <div id="memberListContainer"></div>
                        </div>
                    </div>
                </div>
            </div>

            <!--Popup add family event-->

            <div class="modal fade" id="addeventfamily" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content">
                        <form action="familyeventcontroller" method="post"onsubmit="return validateForm()">
                            <div class="modal-header">
                                <h5 class="modal-title">Add family event</h5>
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
                                <input type="hidden" name="familyid" value="${family.getFamily_id()}">
                                <br/>
                                <label for="title_event">Event</label>                         
                                <input type="text" name="title_event" id="event-title" placeholder="Add title" required >

                                <label for="">Date</label>
                                <select name="calendar_type" id="calendar_type" onchange="changeFamilyCalendar()">
                                    <option value="0">solar day</option>                               
                                    <option value="1">lunar day</option>
                                </select>
                                <input type="date" name="solar_date" id="solar">
                                <input type="hidden" value="" id="lunar_date" name="lunar_date">
                                <input type="text" name="" id="lunar" placeholder="dd/mm/yyyy" pattern="\d{2}/\d{2}/\d{4}" onchange="convertToSolarFamily()">
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
                                    <!--                                    <div><label for="first_remind">Remind 1st</label>
                                                                            <select name="first_remind" id="">
                                                                                <option value="">none</option>
                                                                                <option value="">1 day before</option>
                                                                                <option value="">2 day before</option>
                                                                                <option value="">3 day before</option>
                                                                            </select>
                                                                        </div>
                                                                        <div>
                                                                            <label for="second_remind">Remind 2nd</label>
                                                                            <select name="second_remind" id="">
                                                                                <option value="">none</option>
                                                                                <option value="">1 day before</option>
                                                                                <option value="">2 day before</option>
                                                                                <option value="">3 day before</option>
                                                                            </select>
                                                                        </div>-->
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
                        </form>
                    </div>
                </div>
            </div>

        </c:if>
        <script src="js/familysidebar.js"></script>
        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>   
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/main.js"></script>
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/moment.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>


        <script>
                                    function chooseFile(fileInput) {
                                        if (fileInput.files && fileInput.files[0]) {
                                            var reader = new FileReader();
                                            reader.onload = function (e) {
                                                $('#family-image-url').attr('src', e.target.result);
                                                // Save the image data to local storage only when a file is chosen
                                                //localStorage.setItem('imageData', e.target.result);
                                            }
                                            reader.readAsDataURL(fileInput.files[0]);
                                        }
                                    }
                                    ;

                                    function submitForm() {
                                        document.getElementById("familyavatar").submit();
                                    }

        </script>
        <script>
            function searchMember() {
                var searchVal = $('#searchQuery').val();
                $.ajax({
                    url: 'familyadmin',
                    type: 'POST',
                    data: {
                        action: 'searchMember',
                        searchQuery: searchVal,
                        familyid: '${family.getFamily_id()}'
                    },
                    success: function (response) {
                        $('#memberListContainer').html(response);
                    },
                    error: function () {
                        $('#memberListContainer').html('There was an error processing your request.');
                    }
                });
            }
            function addMember(userId) {
                $.ajax({
                    url: 'familyadmin',
                    type: 'POST',
                    data: {
                        action: 'addMember',
                        userId: userId,
                        familyid: '${family.getFamily_id()}'
                    },
                    success: function (response) {
                        $('.user-entry[data-user-id="' + userId + '"]').remove();
                    },
                    error: function () {
                        $('#memberListContainer').html('Error adding member.');
                    }
                });
            }
            $(document).ready(function () {
                $('#addMember').on('hidden.bs.modal', function () {
                    location.reload();
                });
            });
        </script>

    </body>
</html>
