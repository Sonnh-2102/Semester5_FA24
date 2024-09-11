<%-- 
    Document   : listFriend
    Created on : Jan 21, 2024, 10:07:08 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Search</title>
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
        <link rel="stylesheet" href="css/listfriend.css">
    </head>

    <body>
        <%@include file="/components/header.jsp"%>

        <div class="container-fluid body-content">
            <div class="row">
                <!-- left nav -->
                <%@include file="/components/sidebar.jsp"%>
                <!-- End left nav -->
                <div class="col-lg-2">

                </div>
                <!-- Content -->
                <div class="col-lg-10 content-show-friend" style="display: block;" >
                    <c:choose>
                        <c:when test="${empty sessionScope.currentUser.phone_number}">
                            <div class="alert alert-info" style="margin-top: 30px">Please enter your <a href="profile" data-bs-target="#add-phonenumber" data-bs-toggle="modal" style="text-decoration: none">phone number</a> to find new friend</div>
                            <!--pop-up-addphone-->
                            <div class="modal fade" id="add-phonenumber" aria-hidden="true"
                                 aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Add phone number</h1>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body choose-group-item" style="height: 200px; overflow-y: hidden">
                                            <div class="name-input-style addphone">
                                                <div class="form-group">
                                                    <label for="number" class="input-label">Phone Number</label>
                                                    <input type="text" id="phonenumber" class="form-control" name="phone_number" value="${phone}" placeholder="phonenumber" pattern="[0-9]{10}" title="Please enter valid number"
                                                           maxlength="10" minlength="10" required="required" />
                                                </div>
                                                <div class="form-group" style="display: flex; justify-content: end">
                                                    <button type="submit" class="btn btn-primary" onclick="checkPhone(${currentUser.user_id})">Update</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:if test="${empty friends}">
                                <div class="alert alert-info" style="margin-top: 30px">No relatives found.</div>
                            </c:if>
                            <c:if test="${not empty friends}">
                                <c:forEach var="friends" items="${friends}">
                                    <c:choose>
                                        <c:when test="${data.getRelation(currentUserId, friends.getUser_id()) == null}">
                                            <div class="content-show-friend">
                                                <div class="show-friend">
                                                    <div class="show-friend-header">
                                                        <table>
                                                            <tr>
                                                            <a href="profile?user_id=${friends.getUser_id()}">
                                                                <td class="td-img" rowspan="2"><img src="img/${friends.image}"></td>
                                                                <td>${friends.getF_name()} ${friends.getL_name()}</td>
                                                            </a>
                                                            </tr>
                                                            <tr>
                                                                <td>${friends.getPhone_number()}</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <p>This is a stranger!  Let's create connection together.</p>
                                                    <div style="display: flex">
                                                        <form action="addfriend" method="POST">
                                                            <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                            <input type="hidden" name="action" value="add"/>
                                                            <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>  
                                                            <button class="button-add-friend">Connect</button>
                                                        </form>
                                                        <button class="button-add-friend" data-bs-target="#chatPopUp${friends.getUser_id()}" data-bs-toggle="modal"
                                                                style="padding-right: 15px;">Chat</button>
                                                        <button class="button-add-friend" onclick="window.location.href = 'profile?user_id=${friends.getUser_id()}'"
                                                                style="padding-right: 15px;">Profile</button>
                                                        <div class="modal fade" id="chatPopUp${friends.getUser_id()}" aria-hidden="true"
                                                             aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                                            <div class="modal-dialog modal-dialog-centered" style="width: 350px">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Send to ${friends.getF_name()} ${friends.getL_name()}</h1>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                                aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form class="pop-up-chat-friend" action="updateboxchat" method="get">
                                                                            <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                            <input type="hidden" name="friendName" value="${friends.getF_name()} ${friends.getL_name()}"/>
                                                                            <input type="text" name="description" placeholder="Type a message here" required="">
                                                                            <button class="button-add-friend">Send</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${data.getRelation(currentUserId, friends.getUser_id()) == 0}">
                                            <div class="content-show-friend">
                                                <div class="show-friend">
                                                    <div class="show-friend-header">
                                                        <table>
                                                            <tr>
                                                                <td class="td-img" rowspan="2"><img src="img/${friends.image}"></td>
                                                                <td>${friends.getF_name()} ${friends.getL_name()}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>${friends.getPhone_number()}</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <p>Connection request pending.</p>
                                                    <div style="display: flex">                                                
                                                        <c:choose>
                                                            <c:when test="${data.getRequestSenderId(currentUserId, friends.getUser_id()) == currentUserId}">
                                                                <form action="addfriend" method="POST">
                                                                    <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                                    <input type="hidden" name="action" value="removeRequest"/>
                                                                    <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                    <button class="button-add-friend" style ="background: green;"> Cancel Request</button>
                                                                </form>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <form action="addfriend" method="POST">
                                                                    <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                                    <input type="hidden" name="action" value="accept"/>
                                                                    <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                    <button class="button-add-friend" style=" background: blue">Accept</button>
                                                                </form>
                                                                <form action="addfriend" method="POST">
                                                                    <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                                    <input type="hidden" name="action" value="reject"/>
                                                                    <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                    <button class="button-add-friend" style=" background: #6f6f6f">Reject</button>
                                                                </form>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <button class="button-add-friend" data-bs-target="#chatPopUp${friends.getUser_id()}" data-bs-toggle="modal"
                                                                style="padding-right: 15px;">Chat</button>
                                                        <button class="button-add-friend" onclick="window.location.href = 'profile?user_id=${friends.getUser_id()}'"
                                                                style="padding-right: 15px;">Profile</button>
                                                        <div class="modal fade" id="chatPopUp${friends.getUser_id()}" aria-hidden="true"
                                                             aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                                            <div class="modal-dialog modal-dialog-centered" style="width: 350px">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Send to ${friends.getF_name()} ${friends.getL_name()}</h1>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                                aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form class="pop-up-chat-friend" action="updateboxchat" method="get">
                                                                            <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                            <input type="hidden" name="friendName" value="${friends.getF_name()} ${friends.getL_name()}"/>
                                                                            <input type="text" name="description" placeholder="Type a message here" required="">
                                                                            <button class="button-add-friend">Send</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                </div>
                                            </div>
                                        </c:when>
                                        <c:when test="${data.getRelation(currentUserId, friends.getUser_id()) == 1}">
                                            <div class="content-show-friend">
                                                <div class="show-friend">
                                                    <div class="show-friend-header">
                                                        <table>
                                                            <tr>
                                                                <td class="td-img" rowspan="2"><img src="img/${friends.image}"></td>
                                                                <td>${friends.getF_name()} ${friends.getL_name()}</td>
                                                            </tr>
                                                            <tr>
                                                                <td>${friends.getPhone_number()}</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <p>You have already connected with this person</p>
                                                    <div style="display: flex; align-items: center; gap: 15px;">
                                                        <div class="connected-status" data-bs-target="#disconnectedModal${friends.getUser_id()}" data-bs-toggle="modal" style="display: flex; align-items: center; background-color: rgb(111 106 101);; color: white; border-radius: 20px; padding: 5px 15px; cursor: pointer;margin-left: 20px;">
                                                            <i class="fas fa-user-check" style="margin-right: 5px;"></i><span>Connected</span>
                                                        </div>
                                                        <div class="modal fade" id="disconnectedModal${friends.getUser_id()}" aria-hidden="true"
                                                             aria-labelledby="disconnectedModalLabel${friends.getUser_id()}" tabindex="-1">
                                                            <div class="modal-dialog modal-dialog-centered">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h5 class="modal-title" id="disconnectedModalLabel${friends.getUser_id()}">Disconnect Confirmation</h5>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                                aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        Are you sure to disconnect with ${friends.getF_name()} ${friends.getL_name()}?
                                                                    </div>
                                                                    <div class="modal-footer">
                                                                        <form action="addfriend" method="POST">
                                                                            <input type="hidden" name="searchQuery" value="${searchQuery}">
                                                                            <input type="hidden" name="action" value="delete"/>
                                                                            <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                            <button class="button-delete">Confirm Disconnect</button>
                                                                        </form>
                                                                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <button class="button-add-friend" data-bs-target="#chatPopUp${friends.getUser_id()}" data-bs-toggle="modal"
                                                                style="padding-right: 15px;">Chat</button>
                                                        <button class="button-add-friend" onclick="window.location.href = 'profile?user_id=${friends.getUser_id()}'"
                                                                style="padding-right: 15px;">Profile</button>
                                                        <div class="modal fade" id="chatPopUp${friends.getUser_id()}" aria-hidden="true"
                                                             aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                                            <div class="modal-dialog modal-dialog-centered" style="width: 350px">
                                                                <div class="modal-content">
                                                                    <div class="modal-header">
                                                                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Send to ${friends.getF_name()} ${friends.getL_name()}</h1>
                                                                        <button type="button" class="btn-close" data-bs-dismiss="modal"
                                                                                aria-label="Close"></button>
                                                                    </div>
                                                                    <div class="modal-body">
                                                                        <form class="pop-up-chat-friend" action="updateboxchat" method="get">
                                                                            <input type="hidden" name="friendId" value="${friends.getUser_id()}"/>
                                                                            <input type="hidden" name="friendName" value="${friends.getF_name()} ${friends.getL_name()}"/>
                                                                            <input type="text" name="description" placeholder="Type a message here" required="">
                                                                            <button class="button-add-friend">Send</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>  
                                                </div>
                                            </div>
                                        </c:when>
                                    </c:choose>
                                </c:forEach>
                            </c:if>
                        </c:otherwise>
                    </c:choose>

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
                                                                    function checkPhone(userId) {
                                                                        var phonenumber = document.getElementById("phonenumber").value;
                                                                        var addphone = document.getElementsByClassName("addphone")[0];
                                                                        console.log(userId);
                                                                        console.log(phonenumber);

                                                                        $.ajax({
                                                                            url: 'addphone',
                                                                            type: 'POST',
                                                                            data: {
                                                                                userId: userId,
                                                                                phonenumber: phonenumber
                                                                            },
                                                                            success: function (response) {
                                                                                if (response.trim() === "updatesucess") {
                                                                                    // Hiển thị cảnh báo hoặc modal nếu số điện thoại đã tồn tại
                                                                                    alert("Update phone success.");
                                                                                    window.location.href = '/SocialCellNetwork/home';
                                                                                } else {
                                                                                    addphone.innerHTML = "";
                                                                                    addphone.innerHTML = response;
                                                                                    alert("The phone has been used.");
                                                                                }
                                                                            },
                                                                            error: function (xhr, status, error) {

                                                                                alert("Error: " + error);
                                                                            }
                                                                        });
                                                                    }
                                                                    ;
        </script>

    </body>



</html>
