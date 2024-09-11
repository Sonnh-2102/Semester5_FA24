<%@page import="dal.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html class="no-js" lang="">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Conversation</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <link rel="stylesheet" href="css/boxchat.css"/>
    </head>

    <body>
        <%@include file="/components/header.jsp"%>

        <div class="container-fluid body-content">
            <div class="row fix-component">
                <div class="col-lg-3 no-padding-margin">
                    <div class="chat-box-left">
                        <h3>Conversations</h3>
                        <form action="boxchat" method="get">
                            <input type="text" placeholder="Search conversation" name="name" value="${name}">
                            <button><i class="fas fa-search"></i></button>
                        </form>
                        <div class="choose-box-chat-member">
                            <p style="margin: 10px 0px; font-weight: 600; font-size: 20px">Family</p>
                            <c:if test="${empty listFamily}">
                                <div class="alert alert-info" style="margin-right: 10px">Family's conversation not found!</div>
                            </c:if>
                            <!-- Danh sách family -->
                            <c:forEach items="${listFamily}" var="family">
                                <form action="boxchat" method="post" id="familyForm${family.value.getFamily_id()}">
                                    <input type="hidden" name="name" value="${name}">
                                    <input type="hidden" name="choosenFamilyId" value="${family.value.getFamily_id()}">                                  
                                    <div class="list-member-chat-box-entity pointer" onclick="submitFormFamily(${family.value.getFamily_id()})">
                                        <div class="list-member-chat-box-entity-profile">
                                            <div>
                                                <img src="img/${family.value.getImg()}">
                                            </div>
                                            <div>
                                                <h5>${family.value.getName()}</h5>
                                                <p>
                                                    <c:if test="${family.key.getSent_by() == sessionScope.currentUser.getUser_id()}">
                                                        <c:choose>
                                                            <c:when test="${family.key.getDescription().length() >= 20}">
                                                                You: ${family.key.getDescription().toString().substring(0, 15)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                You: ${family.key.getDescription()}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <c:if test="${family.key.getSent_by() != sessionScope.currentUser.getUser_id()}">
                                                        <c:choose>
                                                            <c:when test="${family.key.getDescription().length() >= 20}">
                                                                ${family.value.getName()}: ${family.key.getDescription().toString().substring(0, 15)}.....
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${family.value.getName()}: ${family.key.getDescription()}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                </p>
                                            </div>
                                        </div>

                                        <div>
                                            ${family.key.getDate().toString().substring(11, 16)}
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>
                            <p style="margin-bottom: 10px; font-weight: 600; font-size: 20px">Others</p>
                            <c:if test="${empty listFriend}">
                                <div class="alert alert-info" style="margin-right: 10px">Couple's conversation not found!</div>
                            </c:if>
                            <!-- Danh sách bạn bè -->
                            <c:forEach items="${listFriend}" var="user">
                                <form action="boxchat" method="post" id="myForm${user.value.getUser_id()}">
                                    <input type="hidden" name="name" value="${name}">
                                    <input type="hidden" name="choosenUserId" value="${user.value.getUser_id()}">                                  
                                    <div class="list-member-chat-box-entity pointer" onclick="submitForm(${user.value.getUser_id()})">
                                        <div class="list-member-chat-box-entity-profile">
                                            <div>
                                                <img src="img/${user.value.getImage()}">
                                            </div>
                                            <div>
                                                <h5>${user.value.getF_name()} ${user.value.getL_name()}</h5>
                                                <p>
                                                    <c:if test="${user.key.getSent_by() == sessionScope.currentUser.getUser_id()}">
                                                        <c:choose>
                                                            <c:when test="${user.key.getDescription().length() >= 20}">
                                                                You: ${user.key.getDescription().toString().substring(0, 10)}......
                                                            </c:when>
                                                            <c:otherwise>
                                                                You: ${user.key.getDescription()}
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:if>
                                                    <c:if test="${user.key.getSent_by() != sessionScope.currentUser.getUser_id()}">
                                                        <c:choose>
                                                            <c:when test="${user.key.getDescription().length() >= 20}">
                                                                ${user.value.getL_name()}: ${user.key.getDescription().toString().substring(0, 10)}...
                                                            </c:when>
                                                            <c:otherwise>
                                                                ${user.value.getL_name()}: ${user.key.getDescription()}
                                                            </c:otherwise>
                                                        </c:choose>

                                                    </c:if>
                                                </p>
                                            </div>
                                        </div>

                                        <div>
                                            ${user.key.getDate().toString().substring(11, 16)}
                                        </div>
                                    </div>
                                </form>
                            </c:forEach>
                        </div>
                    </div>

                </div>
                <!-- boxx chat -->
                <div class="col-lg-9 no-padding-margin box-chat-main-father">
                    <div class="box-chat-main">
                        <div class="box-chat-main-header">
                            <div class="box-chat-main-header-title">
                                <c:choose>
                                    <c:when test="${choosenConversationFriend == null && choosenConversationFamily == null}">
                                        <div>
                                            <img src="img/userdefault.jpg">
                                        </div>
                                        <div>
                                            <h5>No conversation choosen</h5>
                                            <p>No time</p>
                                        </div>
                                    </div>
                                </c:when>
                                <c:when test="${choosenConversationFamily != null}">
                                    <div>
                                        <img src="img/${choosenConversationFamily.getImg()}">
                                    </div>
                                    <div>
                                        <h5>
                                            ${choosenConversationFamily.getName()}
                                        </h5>
                                        <p>Online 2 hours ago</p>
                                    </div>
                                </div>
                                <div>
                                    <a class="pointer" data-bs-target="#popUpChatBoxOption" data-bs-toggle="modal"><i
                                            class="fas fa-ellipsis-v"></i></a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div>
                                    <img src="img/${choosenConversationFriend.getImage()}">
                                </div>
                                <div>
                                    <h5>
                                        ${choosenConversationFriend.getF_name()} ${choosenConversationFriend.getL_name()} 
                                        <c:if test="${!areFriend}"><span class="stranger-alert">STRANGER</span></c:if>
                                        </h5>
                                        <p>Online 2 hours ago</p>
                                    </div>
                                </div>
                                <div>
                                    <a class="pointer" data-bs-target="#popUpChatBoxOption" data-bs-toggle="modal"><i
                                            class="fas fa-ellipsis-v"></i></a>
                                </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="box-chat-main-body" id="messageContainer">
                    <c:if test="${conversationStatus.getStatus() == sessionScope.currentUser.getUser_id()}">
                        <div class="ban-box-chat-main-body">
                            <div>
                                <i class="fas fa-exclamation-triangle"></i>You have banned this Conversation
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${conversationStatus.getStatus() != sessionScope.currentUser.getUser_id() && conversationStatus.getStatus() != 0 && conversationStatus.getStatus() != null}">
                        <div class="ban-box-chat-main-body">
                            <div>
                                <i class="fas fa-exclamation-triangle"></i>You have been banned from this conversation
                            </div>
                        </div>
                    </c:if>

                    <div  class="conversation">
                        <c:set var="previousMessage" value="" />
                        <c:set var="previousMessageTime" value="" />
                        <c:forEach items="${allConversationMessageChat}" var="message">
                            <c:choose>
                                <c:when test="${message.key.getSent_by() == sessionScope.currentUser.getUser_id()}">
                                    <c:choose>
                                        <c:when test="${previousMessage.equals(message.value.getUser_id()) 
                                                        && previousMessageTime.equals(message.key.getDate().toString().substring(0, 16))}">
                                                <div class="your-self-conversation" onmouseleave="hideOptions(${message.key.getMesage_id()})">
                                                    <div class="options-message-button">
                                                        <div id="options${message.key.getMesage_id()}" class="options-message">
                                                            <div>
<!--                                                                <button><i class="fas fa-share"></i></button>
                                                                <button><i class="far fa-heart"></i></button>-->
                                                                <form action="deletemessage" method="post">
                                                                    <c:choose>
                                                                        <c:when test="${choosenConversationFriend != null && choosenConversationFamily == null}">

                                                                            <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                                                            <input type="hidden" name="choosenUserId" value="${choosenConversationFriend.getUser_id()}"/>
                                                                        </c:when>
                                                                        <c:when test="${choosenConversationFriend == null && choosenConversationFamily != null}">

                                                                            <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                                                            <input type="hidden" name="choosenFamilyId" value="${choosenConversationFamily.getFamily_id()}"/>
                                                                        </c:when>
                                                                    </c:choose>
                                                                    <input type="hidden" name="messageID" value="${message.key.getMesage_id()}"/>
                                                                    <button type="submit"><i class="fas fa-trash"></i></button>
                                                                </form>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="title" title="${message.key.getDate().toString().substring(0, 16)}" onmouseenter="showOptions(${message.key.getMesage_id()})">
                                                        <div class="content-mesage-title" data-message="${message.key.getDescription().toString()}"></div>
                                                    </div>
                                                    <div style="width: 40px">

                                                    </div>
                                                </div>

                                        </c:when>
                                        <c:otherwise>
                                            <div class="your-self-conversation" style="margin-top: 10px" onmouseleave="hideOptions(${message.key.getMesage_id()})">
                                                <div class="options-message-button">
                                                    <div id="options${message.key.getMesage_id()}" class="options-message">
                                                        <div>
<!--                                                            <button><i class="fas fa-share"></i></button>
                                                            <button><i class="far fa-heart"></i></button>-->
                                                            <form action="deletemessage" method="post">
                                                                <c:choose>
                                                                    <c:when test="${choosenConversationFriend != null && choosenConversationFamily == null}">

                                                                        <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                                                        <input type="hidden" name="choosenUserId" value="${choosenConversationFriend.getUser_id()}"/>
                                                                    </c:when>
                                                                    <c:when test="${choosenConversationFriend == null && choosenConversationFamily != null}">

                                                                        <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                                                        <input type="hidden" name="choosenFamilyId" value="${choosenConversationFamily.getFamily_id()}"/>
                                                                    </c:when>
                                                                </c:choose>
                                                                <input type="hidden" name="messageID" value="${message.key.getMesage_id()}"/>
                                                                <button type="submit"><i class="fas fa-trash"></i></button>
                                                            </form>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="title" title="${message.key.getDate().toString().substring(0, 16)}" onmouseenter="showOptions(${message.key.getMesage_id()})">
                                                    <div class="content-mesage-title" data-message="${message.key.getDescription().toString()}"></div>
                                                </div>
                                                <div>
                                                    <img src="img/${sessionScope.currentUser.getImage()}" title="${message.value.getF_name()} ${message.value.getL_name()} ">
                                                </div>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:when test="${message.key.getSent_by() != sessionScope.currentUser.getUser_id()}">
                                    <c:choose>
                                        <c:when test="${previousMessage.equals(message.value.getUser_id()) 
                                                        && previousMessageTime.equals(message.key.getDate().toString().substring(0, 16))}">
                                                <div class="friend-conversation" onmouseleave="hideOptions(${message.key.getMesage_id()})">
                                                    <div style="width: 40px">

                                                    </div>
                                                    <div class="title" title="${message.key.getDate().toString().substring(0, 16)}" onmouseenter="showOptions(${message.key.getMesage_id()})">
                                                        <div class="content-mesage-title" data-message="${message.key.getDescription().toString()}"></div>

                                                    </div>
                                                    <div>
                                                        <div id="options${message.key.getMesage_id()}" class="options-message">

<!--                                                            <button><i class="fas fa-share"></i></button>
                                                            <button><i class="far fa-heart"></i></button>-->
                                                        </div>
                                                    </div>
                                                </div>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="friend-conversation" style="margin-top: 10px;" onmouseleave="hideOptions(${message.key.getMesage_id()})">
                                                <div>
                                                    <img src="img/${message.value.getImage()}" title="${message.value.getF_name()} ${message.value.getL_name()} ">
                                                </div>
                                                <div class="title" title="${message.key.getDate().toString().substring(0, 16)}" onmouseenter="showOptions(${message.key.getMesage_id()})">
                                                    <div class="content-mesage-title" data-message="${message.key.getDescription().toString()}"></div>

                                                </div>
                                                <div>
                                                    <div id="options${message.key.getMesage_id()}" class="options-message">

<!--                                                        <button><i class="fas fa-share"></i></button>
                                                        <button><i class="far fa-heart"></i></button>-->
                                                    </div>
                                                </div>

                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </c:when>
                            </c:choose>
                            <c:set var="previousMessage" value="${message.value.getUser_id()}" />
                            <c:set var="previousMessageTime" value="${message.key.getDate().toString().substring(0, 16)}" />
                        </c:forEach>
                    </div>
                </div>
                <c:choose>
                    <c:when test="${choosenConversationFriend != null && choosenConversationFamily == null && conversationStatus.getStatus() == 0}">
                        <div class="box-chat-main-footer">
                            <form id="updateboxchat-send-mess-form" action="updateboxchat" method="post" onsubmit="send(event)">
                                <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                <input type="hidden" name="choosenUserId" value="${choosenConversationFriend.getUser_id()}"/>
                                <a href=""><i class="fas fa-plus-circle"></i></a>
                                <input type="text" placeholder="Type a message here" name="description" required="" id="message_input"/>
                                <button onclick="send()"><i class="fas fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </c:when>
                    <c:when test="${choosenConversationFriend == null && choosenConversationFamily != null && conversationStatus.getStatus() == 0}">
                        <div class="box-chat-main-footer">
                            <form id="updateboxchat-send-mess-form" action="updateboxchat" method="post" onsubmit="send(event)">
                                <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                <input type="hidden" name="choosenFamilyId" value="${choosenConversationFamily.getFamily_id()}"/>
                                <a href=""><i class="fas fa-plus-circle"></i></a>
                                <input type="text" placeholder="Type a message here" name="description" required="" id="message_input"/>
                                <button onclick="send()"><i class="fas fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="box-chat-main-footer">
                            <form action="updateboxchat" method="post">
                                <a href="" ><i class="fas fa-plus-circle"></i></a>
                                <input type="text" placeholder="Type a message here" name="description" readonly="">
                                <button disabled=""><i class="fas fa-paper-plane"></i></button>
                            </form>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

        </div>

        <!-- Phan pop up của thanh 3 chấm -->
        <div class="modal fade" id="popUpChatBoxOption" data-bs-backdrop="static" data-bs-keyboard="false"
             tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <div>
                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Options</h1>
                        </div>

                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <div class="choosen-pop-up-box-chat-profile no-hover">
                            <c:choose>
                                <c:when test="${choosenConversationFriend != null}">
                                    <div class="no-hover">
                                        <img src="img/${choosenConversationFriend.getImage()}">
                                    </div>
<!--                                    <div class="choosen-pop-up-box-chat-profile-icon"> 
                                        <form action="" method="post" onclick="window.location.href = 'profile?user_id=${choosenConversationFriend.getUser_id()}'">
                                            <i class="fas fa-user-circle"></i><br>Profile 
                                        </form>
                                        <form action="" method="post">
                                            <i class="fas fa-bell"></i><br>Turn off
                                        </form>
                                    </div>-->
                                </c:when>
                                <c:otherwise>
                                    <div class="no-hover">
                                        <img src="img/${choosenConversationFamily.getImg()}">
                                    </div>
<!--                                    <div class="choosen-pop-up-box-chat-profile-icon"> 
                                        <form action="" method="post">
                                            <i class="fas fa-users"></i><br>Family
                                        </form>
                                        <form action="" method="post">
                                            <i class="fas fa-bell"></i><br>Turn off
                                        </form>
                                    </div>-->
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <h5>Custom</h5>
                        <c:choose>
                            <c:when test="${conversationStatus.getStatus() == 0}">
                                <form action="banboxchat" method="post" id="myDeletePopUp">
                                    <div onclick="submitDeleteForm()">
                                        <input type="hidden" name="BanOrUnban" value="Ban"/>
                                        <c:choose>
                                            <c:when test="${choosenConversationFriend != null}">
                                                <input type="hidden" name="choosenUserId" value="${choosenConversationFriend.getUser_id()}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="choosenFamilyId" value="${choosenConversationFamily.getFamily_id()}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                        <i class="fas fa-lock"></i> Ban This Conversation
                                    </div>
                                </form>  
                            </c:when>
                            <c:when test="${conversationStatus.getStatus() != 0 && conversationStatus.getStatus() == sessionScope.currentUser.getUser_id()}">
                                <form action="banboxchat" method="post" id="myDeletePopUp">
                                    <div onclick="submitDeleteForm()">
                                        <input type="hidden" name="BanOrUnban" value="Unban"/>
                                        <c:choose>
                                            <c:when test="${choosenConversationFriend != null}">
                                                <input type="hidden" name="choosenUserId" value="${choosenConversationFriend.getUser_id()}"/>
                                            </c:when>
                                            <c:otherwise>
                                                <input type="hidden" name="choosenFamilyId" value="${choosenConversationFamily.getFamily_id()}"/>
                                            </c:otherwise>
                                        </c:choose>
                                        <input type="hidden" name="conversationChoosenId" value="${conversationChoosenId}"/>
                                        <i class="fas fa-lock-open"></i> Unban This Conversation
                                    </div>
                                </form>  
                            </c:when>
                        </c:choose>

                        <c:if test="${!areFriend && areFriend != null}">
<!--                            <form action="" method="post">
                                <div onclick="">
                                    <input type="hidden" name="conversationChoosenId" value="${choosenConversationFriend.getUser_id()}"/>
                                    <i class="fas fa-user-plus"></i> Connect
                                </div>
                            </form>  -->
                        </c:if>    
                        <c:if test="${areFriend && areFriend != null}">
<!--                            <form action="" method="post">
                                <div onclick="">
                                    <input type="hidden" name="conversationChoosenId" value="${choosenConversationFriend.getUser_id()}"/>
                                    <i class="fas fa-user-minus"></i> Disconnect
                                </div>
                            </form>  -->
                        </c:if>    
                    </div>
                </div>

            </div>
        </div> 
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script>

//            var wsURI = "ws://" + document.location.host + document.location.pathname + "chat";
                                        var wsURI = "ws://" + "localhost:9999/SocialCellNetwork/" + "chat/${conversationChoosenId}";
                                        var websocket${conversationChoosenId} = new WebSocket(wsURI);
                                        websocket${conversationChoosenId}.onmessage = function (evnt) {
                                            onMessage(evnt);
                                        };
                                        websocket${conversationChoosenId}.onopen = function () {
                                            onOpen();
                                        };
                                        function onOpen() {
                                            console.log("Opened connection: " + wsURI);
                                        }

                                        function onClose() {
                                            console.log("Closed connection: " + wsURI);
                                        }

                                        function onMessage(event) {
                                            console.log(event);
                                            display(event.data);
                                        }
//            sua 
                                        function display(dataString) {
                                            var data = JSON.parse(dataString);
                                            //var contentMessage = "<p>User " + data.send_by + " says: " + data.description + " converid: " + data.conversation_id + "</p>";
                                            var contentMessage = `
        <div class="your-self-conversation" style="margin-top: 10px;margin-bottom: 10px;">
            <div class="title" title="` + data.date + `">
                <div class="content-mesage-title" data-message="` + data.description + `"></div>
            </div>
            <div>
                <img src="img/${sessionScope.currentUser.getImage()}" title="` + data.name + `">
            </div>
        </div>
    `;
                                            if (${sessionScope.currentUser.getUser_id()} != data.send_by) {
                                                contentMessage = `
        <div class="friend-conversation" style="margin-top: 10px;margin-bottom: 10px;">
                                                <div>
                                                    <img src="img/` + data.image + `" title="` + data.name + `">
                                                </div>
                                                <div class="title" title="` + data.date + `">
                                                    <div class="content-mesage-title" data-message="` + data.description + `"></div>

                                                </div>
                                            </div>
    `;
                                            }
                                            var conversationBox = document.getElementById("messageContainer");
                                            conversationBox.innerHTML += contentMessage;
                                            conversationBox.scrollTop = conversationBox.scrollHeight;
                                        }

                                        var currentTime = new Date();
                                        var year = currentTime.getFullYear();
                                        var month = ('0' + (currentTime.getMonth() + 1)).slice(-2); 
                                        var day = ('0' + currentTime.getDate()).slice(-2);
                                        var hours = ('0' + currentTime.getHours()).slice(-2);
                                        var minutes = ('0' + currentTime.getMinutes()).slice(-2);
                                        var formattedDateTime = year + "-" + month + "-" + day + " " + hours + ":" + minutes;
                                        function send(event) {
                                            event.preventDefault(); 

                                            var description = document.getElementById("message_input").value;
                                            var json = {
                                                "description": description,
                                                "send_by": ${sessionScope.currentUser.getUser_id()}, 
                                                "conversation_id": ${conversationChoosenId},
                                                "date": formattedDateTime,
                                                "image": "${sessionScope.currentUser.image}",
                                                "name": "${sessionScope.currentUser.getF_name()} ${sessionScope.currentUser.getL_name()} "
                                            };
                                            console.log("Sending " + description);
                                            document.getElementById("message_input").value = "";
                                            document.getElementById("message_input").focus();
                                            callJavaFunction(description);
                                            websocket${conversationChoosenId}.send(JSON.stringify(json));
                                            
                                        }

                                        function callJavaFunction(description) {
                                            $.ajax({
                                                url: 'updateboxchat', 
                                                type: 'POST',
                                                data: {"conversationChoosenId": ${conversationChoosenId}, "description": description, "send_by": ${sessionScope.currentUser.getUser_id()}}, // Truyền giá trị của biến JavaScript
                                                success: function (response) {
                                                    //alert('Kết quả từ máy chủ: ' + response);
                                                }
                                            });
                                        }


        </script>







        <script>function showOptions(n) {
                document.getElementById("options" + n).style.display = "block";
            }

            function hideOptions(n) {
                document.getElementById("options" + n).style.display = "none";
            }

        </script>
        <script>
            function submitForm(n) {
                document.getElementById("myForm" + n).submit();
            }

            function submitFormFamily(n) {
                document.getElementById("familyForm" + n).submit();
            }

            function submitDeleteForm() {
                document.getElementById("myDeletePopUp").submit();
            }

            // Đảm bảo rằng mã JavaScript chỉ được thực thi khi toàn bộ nội dung của trang đã được tải
            document.addEventListener("DOMContentLoaded", function () {
                // Tìm phần tử messageContainer
                var messageContainer = document.getElementById('messageContainer');
                // Kiểm tra xem phần tử có tồn tại không
                if (messageContainer) {
                    // Cuộn xuống cuối trang
                    messageContainer.scrollTop = messageContainer.scrollHeight;
                }
            });
        </script>
        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
    </body>
</html>