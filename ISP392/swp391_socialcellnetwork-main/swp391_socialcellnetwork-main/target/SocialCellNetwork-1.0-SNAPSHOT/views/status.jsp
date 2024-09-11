<%@page import="dal.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Status</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <link rel="stylesheet" href="templates/css/chosen.css">
        <link rel="stylesheet" href="css/status.css"/>
    </head>
    <body>
        <%@include file="/components/header.jsp"%>
        <div class="container-fluid body-content">
            <div class="row" >
                <!-- left nav -->
                <%@include file="/components/sidebar.jsp"%>
                <!-- End left nav -->     
                <div class="col-lg-2">

                </div>
                <!-- Content -->
                <div class="col-lg-7 body-content-main">
                    <!-- Create post status -->
                    <div class="content-post">
                        <div class="status-post">
                            <form action="statuscontroller" method="post">
                                <img src="img/${currentUser.image}">
                                <input type="text" id="statusInput" placeholder="Would you like to share a memory ?" required="" name="content">
                            </form>
                        </div>
                    </div>

                    <!-- Start post -->
                    <div id="AllStatus"> 
                        <c:forEach items="${showAllStatus}" var="sas" varStatus="loop" >
                            <div class="content-post">                   
                                <div class="status-post-1">
                                    <div class="status-post-1-header">
                                        <table>
                                            <tr>
                                                <td class="td-img" rowspan="2"><img src="img/${user[loop.index].image}"></td>
                                                    <c:if test="${sas.access == 0}">
                                                    <td class="td-username">${user[loop.index].f_name} ${user[loop.index].l_name} 
                                                        <c:if test ="${taged[loop.index].size() >0}">
                                                            with 
                                                            <c:forEach items="${taged[loop.index]}" var="t">
                                                                <span>${t.f_name} ${t.l_name}</span>
                                                            </c:forEach>
                                                        </c:if>    
                                                    </td>
                                                </c:if>
                                                <c:if test="${sas.access == 1}">
                                                    <td class="td-username">${user[loop.index].f_name} ${user[loop.index].l_name} 
                                                        <c:if test ="${taged[loop.index].size() >0}">
                                                            with 
                                                            <c:forEach items="${taged[loop.index]}" var="t">
                                                                <span>${t.f_name} ${t.l_name}</span>
                                                            </c:forEach>
                                                        </c:if>  
                                                        shared to Family
                                                    </td>
                                                </c:if>
                                            </tr>
                                            <tr>
                                                <td>${sas.date.toString().substring(0,16)}</td>
                                            </tr>
                                        </table>

                                        <!--drop down edit status -->
                                        <div class="dropdown" onclick="toggleDropdown(${sas.status_id})">
                                            <i class="fas fa-ellipsis-h dropbtn"></i>
                                            <c:if test="${sas.user_id == currentUser.user_id}">
                                                <div class="dropdown-content" id="myDropdown${sas.status_id}">
                                                    <a onclick ="showStatusEdit(${sas.status_id})">Edit</a>
                                                    <a value="${sas.status_id}" onclick="showConfirmDelete(${sas.status_id})">Delete</a>
                                                    <c:if test="${sas.access == 0}">
                                                        <a onclick="showEditAudience(${sas.status_id})">Edit audience of your status</a>
                                                    </c:if>    
                                                </div>
                                            </c:if>
                                        </div>
                                    </div>

                                    <pre class="post-description">${sas.description}</pre>

                                    <c:if test="${!sas.place.equals('')}">
                                        <span class="status-info"> <strong>Place:</strong> ${sas.place}  </span> <br>
                                    </c:if>        
                                    <c:if test="${sas.date_memory!= null}">
                                        <span class="status-info"> <strong>Time:  </strong>
                                            <fmt:formatDate pattern = "dd-MM-yyyy" value = "${sas.date_memory}" />
                                        </span>
                                    </c:if> 

                                    <div class="post-img">
                                        <c:if test="${sas.img != null }"><img src="img/${sas.img}" alt=""></c:if>
                                        </div>
                                        <div class="number-of-like-and-comments">
                                            <p class="no-padding-margin" id= "countLike${sas.status_id}">${count[loop.index]} <i class="fas fa-heart" style="color: red;"></i></p>
                                            <%--<c:if test="${countComment[loop.index] > 0}">--%>
                                        <p class="no-padding-margin" id="countComment${sas.status_id}">${countComment[loop.index]} Comments</p>
                                        <%--</c:if>--%>    
                                    </div>
                                    <hr style="margin: 0px 5%;color: rgba(0, 0, 0, 0.5);">
                                    <div class="like-comment-saved">
                                        <button class="like-btn" id="like${sas.status_id}" onclick="toggleLike(${sas.status_id},${currentUser.user_id})">
                                            <c:if test="${checkLike[loop.index]}">
                                                <i class="fas fa-heart" style="color: red;"></i>
                                            </c:if> 
                                            <c:if test="${!checkLike[loop.index]}">
                                                <i class="far fa-heart"><span> Like</span></i>
                                            </c:if> 
                                        </button>
                                        <button  class="like-btn" onclick="showComment(${sas.status_id},${currentUser.user_id})">
                                            <i class="far fa-comment"> <span>Comment</span></i>
                                        </button>
                                        <button href="" class="like-btn" onclick="showSaveForm(${sas.status_id})">
                                            <i class="fas fa-share-square"></i> <span>Save</span></i>
                                        </button>
                                    </div>
                                    <hr style="margin: 0px 5%;color: rgba(0, 0, 0, 0.5);">
                                </div>
                            </div>

                            <!--   COMMENT   -->    
                            <div class="comment" id="comment${sas.status_id}" style="display:none">
                                <!--view comment list by AJAX-->
                                <div id="commentList${sas.status_id}" class="commentList{
                                         comment_id
                                     }">
                                    <!--  <div class="commentItem" id="commentItem">
                                            <div class="td-img" rowspan="2"><img src="img/${currentUser.image}}"></div>
                                            <div class="commentItem-content">
                                                <span>${currentUser.f_name} ${currentUser.l_name}</span>
                                                <pre id="commentItem-content1000">description ajdakjs  ajsdkas  asjd as  jsad ka  asjda   jas dk  asda  as dja sd  aksdj a  askd ka</pre>
                                            </div> 
                                            drop down edit comment                              
                                             <div class="dropdown dd-comment" onclick="toggleDropdownComment(1000)">
                                                 <i class="fas fa-ellipsis-h dropbtn"></i>
                                    <%--<c:if test="${sas.user_id == currentUser.user_id}">--%>
                                    <div class="dropdown-content" id="dropdownComment1000">
                                        <button onclick="editComment(1000)">Edit</button>
                                        <a value="${sas.status_id}" onclick="showConfirmDelete(${sas.status_id})">Delete</a>
                                    </div>
                                    <%--</c:if>--%>
                                </div>  
                           </div>-->
                                </div>
                                <!--add new comment-->
                                <hr style="margin: 0px 0% 10px;color: rgba(0, 0, 0, 0.5);">
                                <div class="formAddComment">
                                    <div class="td-img" rowspan="2"><img src="img/${currentUser.image}"></div>
                                    <input type="hidden" name="userId" value="${currentUser.user_id}">
                                    <input type="hidden" name="statusId" value="${sas.status_id}">    
                                    <textarea name="description" id="contentComment${sas.status_id}" rows="2" placeholder="Write your comment" required></textarea>
                                    <button class="btn btn-primary" style="border-radius: 20px"onclick="addNewComment(${sas.status_id},${currentUser.user_id})"> Comment</button>
                                </div>
                            </div>
                            <!--edit status-->
                            <div class="modal fade" id="popUpStatusEdit${sas.status_id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <div>
                                                <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Edit Your Status</h1>
                                            </div>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body">
                                            <table>
                                                <tr>
                                                    <td class="body-content-left-avatar" rowspan="2"><img src="img/${currentUser.image}"/>
                                                    </td>
                                                    <c:if test="${sas.access == 0}">
                                                        <td class="td-username">${currentUser.f_name} ${currentUser.l_name}</td>
                                                    </c:if>
                                                    <c:if test="${sas.access == 1}">
                                                        <td class="td-username">${currentUser.f_name} ${currentUser.l_name} shared to Family</td>
                                                    </c:if>
                                                </tr>
                                                <tr>
                                                    <td>${sas.date.toString().substring(0,16)}</td>
                                                </tr>
                                            </table>
                                            <form action="statuscontroller" method="get">
                                                <input type="hidden" name="page" value="status">
                                                <input type="hidden" name="id" value="${sas.status_id}"> 
                                                <input type="hidden" name="type" value="0">
                                                <div>
                                                    <span>Tag members</span>
                                                    <select name="tagmemberstatus" class="anyuser" multiple style="width: 100%;">
                                                        <c:forEach items="${loadFriendByUserId}" var="t">
                                                            <c:set var="isSelected" value="false"/>
                                                            <c:forEach items="${taged[loop.index]}" var="taggedItem" varStatus="status">
                                                                <c:if test="${taggedItem.user_id == t.user_id}">
                                                                    <c:set var="isSelected" value="true"/>
                                                                </c:if>
                                                            </c:forEach>

                                                            <c:if test="${isSelected}">
                                                                <option value="${t.user_id}" selected>${t.f_name} ${t.l_name}</option>
                                                            </c:if>

                                                            <c:if test="${not isSelected}">
                                                                <option value="${t.user_id}">${t.f_name} ${t.l_name}</option>
                                                            </c:if>

                                                        </c:forEach>
                                                    </select>
                                                </div>
                                                <span>Describe your memory</span><textarea name="content" id="" rows="4" required>${sas.description}</textarea>
                                                <span>Where did this memory take place?</span> <textarea id ="place" name="place">${sas.place}</textarea>
                                                <span>When did this memory take place?</span> <input id="dateOfMemory" type="date" name="dateOfMemory"value="${sas.date_memory}"><br/>

                                                <input type="hidden" name="page" value="status">
                                                <div class="post-img" style="position: relative; width: 90px">
                                                    <input type="hidden" id="uploadedImage${sas.status_id}" name="uploadedImage${sas.status_id}" value="${sas.img}">
                                                    <img id="image${sas.status_id}" src="img/${sas.img}" style="${(sas.img!=null )?"width: 90px":" width:0px"} ; border-radius: 0px; margin: 10px 0px;">
                                                    <div  >
                                                        <i id="deleteimg${sas.status_id}" style="display: ${(sas.img!=null )?"block":"none"};position: absolute; right:-9px; top:-5px; font-size: 20px" 
                                                           onclick="clearImage(${sas.status_id})"class="far fa-times-circle" ></i>
                                                    </div>
                                                </div>  
                                                <div class="op-up-up-coming-event">
                                                    <input type="file" name="image" accept="image/gif, image/jpg, image/png" onchange="chooseFileUpdate(this,${sas.status_id})" >
                                                    <button class="btn btn-primary" data-bs-dismiss="modal">Upload</button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--popup confirm delete-->
                            <div class="modal fade" id="popUpToConfirmDelete${sas.status_id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Are you sure to delete this memory?</h1>
                                        </div>
                                        <div class="modal-body" style="display: flex; justify-content: space-between;">
                                            <button type="button" class="btn btn-secondary" class="btn-close" data-bs-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-danger">
                                                <a href="statuscontroller?id=${sas.status_id}&type=1&page=status" style="text-decoration: none; color:white">
                                                    Delete
                                                </a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--popup edit audience-->
                            <div class="modal fade" id="popUpEditAudience${sas.status_id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                                 aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Choose audience can see your status</h1>
                                        </div>
                                        <div class="modal-body">
                                            <div class="form-check">
                                                <i class="fas fa-globe-asia"></i>
                                                <input class="form-check-input" type="radio" value="0" name="editAudience${sas.status_id}" id="" ${(sas.access==0)?"checked":""}>
                                                <label class="form-check-label" for="flexRadioDefault1">
                                                    Public
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <i class="fas fa-user-lock"></i>
                                                <input class="form-check-input" type="radio" value="2" name="editAudience${sas.status_id}" id="" ${(sas.access==2)?"checked":""}>
                                                <label class="form-check-label" for="flexRadioDefault2">
                                                    Private
                                                </label>
                                            </div>
                                        </div>
                                        <div class="modal-body" style="display: flex; justify-content: space-between;">
                                            <button type="button" class="btn btn-secondary" class="btn-close" data-bs-dismiss="modal">Cancel</button>
                                            <button type="button" class="btn btn-primary" class="btn-close" data-bs-dismiss="modal">
                                                <a onclick="editAudience(${sas.status_id})" style="text-decoration: none; color:white">
                                                    Update
                                                </a>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!--popup save as event-->                        
                            <form action="savememory" method="post">
                                <div class="modal fade" id="formSaveStatus${sas.status_id}" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                    <div class="modal-dialog modal-dialog-centered">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <h5 class="modal-title">Save status as an event</h5>
                                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                            </div>

                                            <div class="modal-body event-create-pop-up" style="margin: 0px;">
                                                <div style="display: flex">

                                                    <label for="title_event">Tag member: </label>                                                                                                   
                                                        <c:forEach items="${taged[loop.index]}" var="t">
                                                            <input type="hidden" value="${t.user_id}" name="tagmember">
                                                            <span >${t.f_name} ${t.l_name}  </span>
                                                        </c:forEach>
                                                 
                                                </div>
                                                
                                                <label for="title_event">Event</label>                         
                                                <input type="text" name="title_event" id="event-title" placeholder="Add title" required >

                                                <label for="">Date: </label>

                                                <input type="date" value="${sas.date_memory}" name="solar_date" id="solar" required="">
                                                <input type="hidden" value="${sas.user_id}" name="statusowner" >

                                                <div class="access_event">
                                                    <label for="access">Access</label>
                                                    <div>
                                                        <input type="radio" name="access" value="1" ${sas.access==2?"checked":""}> Private
                                                    </div>
                                                    <div>
                                                        <input type="radio" name="access" value="0"${sas.access==0?"checked":""}> Public
                                                    </div>
                                                </div>
                                                <div>
                                                    <label for="place">Place</label>
                                                    <input type="text" name="place" placeholder="" value="${sas.place}">
                                                </div>
                                                <div>
                                                    <label for="description">Description</label>
                                                    <textarea class="input-edit-group" name="description" rows="5"
                                                              cols="60">${sas.description}</textarea>
                                                </div>
                                                <div class="button-create">
                                                    <button type="reset" class="btn btn-secondary">Reset</button>
                                                    <button class="btn btn-primary">Save memory</button>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>

                        </c:forEach>
                    </div>     
                    <!-- End post -->

                    <!--popup create status-->
                    <div class="modal fade" id="popUpStatusCreate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                         aria-labelledby="staticBackdropLabel" aria-hidden="true">
                        <div class="modal-dialog modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <div>
                                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Create Status</h1>
                                    </div>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="clearImage(0)"></button>
                                </div>
                                <div class="modal-body">
                                    <form id="createStatus" action="statuscontroller" method="post">
                                        <div>
                                            <a href="" class="body-content-left-avatar"><img src="img/${currentUser.image}">${currentUser.f_name} ${currentUser.l_name}</a>
                                            <div class="dropdown" onclick="togglePublic_Private()">
                                                <select id="access" name="access">
                                                    <option value="0" selected>Public</option>  
                                                    <option value="2"> Private  </option>
                                                </select>    
                                            </div>
                                        </div>
                                        <span>Tag member</span>
                                        <div>
                                            <select name="tagmemberstatus" class="anyuser" multiple style="width: 100%;">
                                                <c:forEach items="${loadFriendByUserId}" var="f">
                                                    <option value="${f.user_id}">
                                                        ${f.f_name} ${f.l_name}
                                                    </option> 
                                                </c:forEach>

                                            </select>
                                        </div>
                                        <span>Describe your memory</span>
                                        <textarea name="content" id="content" rows="3" placeholder="Would you like to share somthing about this memory ?" required></textarea>
                                        <span>Where did this memory take place?</span> <textarea id ="place" name="place"></textarea>

                                        <span>When did this memory take place?</span> <input id="dateOfMemory" type="date" name="dateOfMemory"><br/>


                                        <input type="hidden" id="page" name="page" value="status">
                                        <div class="post-img">
                                            <img src=""  id="newimage" style="display: none; height: 90px; width: 90px; border-radius: 0px; margin: 10px 0px;">
                                        </div>  
                                        <div class="op-up-up-coming-event">
                                            <input type="file" id="image" name="image" accept="image/gif, image/jpg, image/png" onchange="chooseFile(this)" >
                                            <!--do tag xu li ở js gây mất đồng bộ add ko chính xác vì chạy 2 luồng => xử lí cùng chyaj qua js-->
                                            <button class="btn btn-primary " >Upload</button>
                                            <!--dismiss-->
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
        <script src="js/postStatus.js""></script>

        <script src="templates/js/chosen.jquery.js" type="text/javascript"></script> 
        <script>
                                                $('.anyuser').chosen();
                                                function chooseFile(fileInput) {
                                                    if (fileInput.files && fileInput.files[0]) {
                                                        var reader = new FileReader();
                                                        reader.onload = function (e) {
                                                            console.log(e.target.result);
                                                            $('#newimage').attr('src', e.target.result);
                                                            $('#newimage').css("display", "block");
                                                            //                         console.log($('#image1').attr('src'));
                                                        };
                                                        reader.readAsDataURL(fileInput.files[0]);
                                                    }
                                                }
                                                function chooseFileUpdate(fileInput, id) {
                                                    console.log(fileInput.files);
                                                    if (fileInput.files && fileInput.files[0]) {
                                                        var reader = new FileReader();
                                                        reader.onload = function (e) {
                                                            $('#image' + id).attr('src', e.target.result);
                                                            $('#image' + id).css("display", "block");
                                                            $('#image' + id).css("width", "90px");
                                                            $('#deleteimg' + id).css("display", "block");
                                                        };
                                                        reader.readAsDataURL(fileInput.files[0]);
                                                    }
                                                }
                                                function clearImage(id) {
                                                    //                Event.preventDefault();
                                                    $('#newimage').attr('src', null);
                                                    $('#newimage').css("display", "none");
                                                    $('#image' + id).attr('src', null);
                                                    $('#image' + id).css("display", "none");
                                                    $('#uploadedImage' + id).attr('src', null);
                                                    $('#uploadedImage' + id).attr('value', null);
                                                    $('#deleteimg' + id).css("display", "none");
                                                }
        </script>
    </body>
</html>