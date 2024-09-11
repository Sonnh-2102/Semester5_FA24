<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Family</title>
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
        <link rel="stylesheet" href="css/family.css">
        <link rel="stylesheet" href="templates/css/swiper-budle.css">


    </head>

    <body>

        <!-- Header -->

        <%@include file="/components/header.jsp"%>

        <!-- End Header -->

        <div class="container-fluid body-content">
            <div class="row">
                <!-- left nav -->
                <%@include file="/components/familysidebar.jsp"%>
                <!-- End left nav -->
                <div class="col-lg-2"></div>
                <!-- Content -->
                <!-- Calendar -->
                <div class="col-lg-7">
                    <!-- Create post status -->
                    <div class="content-post">
                        <div class="status-post">
                            <form action="statuscontroller" method="post">
                                <img src="img/${currentUser.image}">
                                <input type="text" id="statusInput" placeholder="Would you like to share a memory with your family?" required="" name="content">
                            </form>
                        </div>
                    </div>
                    <!-- Start post -->
                    <c:forEach items="${familyStatusList}" var="fs" varStatus="loop">
                        <div class="content-post">                   
                            <div class="status-post-1">
                                <div class="status-post-1-header">
                                    <table>
                                        <tr>
                                            <td class="td-img" rowspan="2"><img src="img/${user[loop.index].image}"></td>
                                            <td class="td-username">${user[loop.index].f_name} ${user[loop.index].l_name} shared to ${family.name}</td>
                                        </tr>
                                        <tr>
                                            <td>${fs.date.toString().substring(0,16)}</td>
                                        </tr>
                                    </table>
                                    <!--drop down edit status -->
                                    <div class="dropdown" onclick="toggleDropdown(${fs.status_id})">
                                        <i class="fas fa-ellipsis-h dropbtn"></i>
                                        <c:if test="${fs.user_id == currentUser.user_id}">
                                            <div class="dropdown-content" id="myDropdown${fs.status_id}">
                                                <a href="updatechoosenfamilystatus?id=${fs.status_id}&type=0&page=${familyId}">Edit</a>
                                                <a value="${fs.status_id}" onclick="showConfirmDelete(${fs.status_id})">Delete</a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                                <pre class="post-description">${fs.description}</pre>

                                <div class="post-img">
                                    <c:if test="${fs.img != null }"><img src="img/${fs.img}" alt=""></c:if>
                                    </div>
                                    <div class="number-of-like-and-comments">
                                        <p class="no-padding-margin" id= "countLike${fs.status_id}">${count[loop.index]} <i class="fas fa-heart" style="color: red;"></i></p>
                                        <%--<c:if test="${countComment[loop.index] > 0}">--%>
                                    <p class="no-padding-margin" id="countComment${fs.status_id}">${countComment[loop.index]} Comments</p>
                                    <%--</c:if>--%>    
                                </div>

                                <hr style="margin: 0px 5%;color: rgba(0, 0, 0, 0.5);">
                                <div class="like-comment-saved">
                                    <button class="like-btn" id="like${fs.status_id}" onclick="toggleLike(${fs.status_id},${currentUser.user_id})">
                                        <c:if test="${checkLike[loop.index]}">
                                            <i class="fas fa-heart" style="color: red;"></i>
                                        </c:if> 
                                        <c:if test="${!checkLike[loop.index]}">
                                            <i class="far fa-heart"><span> Like</span></i>
                                        </c:if> 
                                    </button>
                                    <button  class="like-btn" onclick="showComment(${fs.status_id},${currentUser.user_id})">
                                        <i class="far fa-comment"> <span>Comment</span></i>
                                    </button>
                                    <button href="" class="like-btn">
                                        <i class="fas fa-share-square"></i> <span>Save</span></i>
                                    </button>
                                </div>
                                <hr style="margin: 0px 5%;color: rgba(0, 0, 0, 0.5);">
                            </div>
                        </div>

                        <!--   COMMENT   -->    
                        <div class="comment" id="comment${fs.status_id}" style= "display:none">
                            <!--view comment list by AJAX-->
                            <div id="commentList${fs.status_id}" class="commentList{
                                     comment_id
                                 }">
                            </div>
                            <!--add new comment-->
                            <hr style="margin: 0px 0% 10px;color: rgba(0, 0, 0, 0.5);">
                            <div class="formAddComment">
                                <div class="td-img" rowspan="2"><img src="img/${currentUser.image}"></div>
                                <input type="hidden" name="userId" value="${currentUser.user_id}">
                                <input type="hidden" name="statusId" value="${fs.status_id}">    
                                <textarea name="description" id="contentComment${fs.status_id}" rows="2" placeholder="Write your comment" required></textarea>
                                <button class="btn btn-primary" style="border-radius: 20px"onclick="addNewComment(${fs.status_id},${currentUser.user_id})"> Comment</button>
                            </div>
                        </div>
                        <!--popup confirm delete-->
                        <div class="modal fade" id="popUpToConfirmDelete${fs.status_id}" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                             aria-labelledby="staticBackdropLabel" aria-hidden="true">
                            <div class="modal-dialog modal-dialog-centered">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Are you sure to delete this memory?</h1>
                                    </div>
                                    <div class="modal-body" style="display: flex; justify-content: space-between;">
                                        <button type="button" class="btn btn-secondary" class="btn-close" data-bs-dismiss="modal">Cancel</button>
                                        <button type="button" class="btn btn-danger">
                                            <a href="statuscontroller?id=${fs.status_id}&type=1&page=${familyId}" style="text-decoration: none; color:white">
                                                Delete
                                            </a>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </c:forEach>

                </div>
                <!-- End post -->
                <!-- Intro và family admin -->

                <div class="col-lg-3 col-md-5 body-content-right">           
                    <div>
                        <c:if test="${family.getDescription().length() > 0}">
                            <div>
                                <div style="font-weight: 700;">Introduce</div>
                                <p>${family.getDescription()}</p>
                            </div>
                        </c:if>
                        <div>
                            <div style="font-weight: 700;">Total Members</div>                                       
                            <div style="display: flex;">
                                <p style="margin-right: 10px">${ membersWithRole.size()} Members </p>
                                <c:if test="${membersWithRole.size() != 0}">
                                    <a data-bs-target="#viewmemberfamily" data-bs-toggle="modal"><i class="fas fa-eye"></i></a>
                                    </c:if>
                            </div>
                            <!--Popup add family event-->
                            <div class="modal fade" id="viewmemberfamily" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Family Members</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" style="overflow-y: scroll; height: 500px">
                                            <c:forEach items="${membersWithRole}" var="membersWithRole">
                                                <div style="display: flex; align-items: center; padding: 0px 10px">
                                                    <img src="img/${membersWithRole.getImage()}" style="width: 60px; height: 60px; border-radius: 50%; margin-right: 20px;" alt="">
                                                    <div style="flex-grow: 1;">
                                                        <div style="font-weight: bold;">${membersWithRole.getF_name()} ${membersWithRole.getL_name()}</div>
                                                        <div>${membersWithRole.getPhone_number()}</div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div>
                            <div style="font-weight: 700;">Total Leaders</div>                                       
                            <div style="display: flex;">
                                <p style="margin-right: 10px">${listAdmin.size()} Leaders </p>
                                <c:if test="${admin.size() != 0}">
                                    <a data-bs-target="#viewadminfamily" data-bs-toggle="modal"><i class="fas fa-eye"></i></a>
                                    </c:if>
                            </div>
                            <div class="modal fade" id="viewadminfamily" aria-hidden="true" aria-labelledby="exampleModalToggleLabel" tabindex="-1">
                                <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title">Family Leaders</h5>
                                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                        </div>
                                        <div class="modal-body" style="overflow-y: scroll; height: 500px">
                                            <c:forEach items="${listAdmin}" var="admin">
                                                <div style="display: flex; align-items: center; padding: 0px 10px">
                                                    <img src="img/${admin.getImage()}" style="width: 60px; height: 60px; border-radius: 50%; margin-right: 20px;" alt="">
                                                    <div style="flex-grow: 1;">
                                                        <div style="font-weight: bold;">${admin.getF_name()} ${admin.getL_name()}</div>
                                                        <div>${admin.getPhone_number()}</div>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!--search sự kiện-->
                    <div style="padding-top: 20px">
                        <div class="select-month-option-find">
                            Select month: <input id="familyevent_month"type="month" name="month"/>
                            <button onclick="searchFamilyEventByMonth()"><i class="fas fa-search"></i></button>
                        </div>
                        <div class="event-search-by-month familyevent">
                            <div class="event-search-by-month-component">
                                <div><p>28/6</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Ngày Gia Đình Việt Nam</span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>8/3</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Quốc Tế Phụ Nữ</span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>15/5</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Quốc Tế Gia Đình</span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>20/10</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Ngày Phụ Nữ Việt Nam </span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>6/6</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Ngày Truyền Thống Người Cao Tuổi Việt Nam</span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>3/6</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                                <div style="word-wrap: break-word; width: 150px">Title: <span >Ngày Của Cha</span></div>
                            </div>
                            <div class="event-search-by-month-component">
                                <div><p>2/5</p><span> (30/1)</span></div>
                                <div style="word-wrap: break-word; width: 120px">Place: <span >Việt Nam</span></div>
                               <div style="word-wrap: break-word; width: 150px">Title: <span >Ngày Của Mẹ</span></div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-2"></div>

                <!--popup to create new status-->
                <div class="modal fade" id="popUpStatusCreate" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
                     aria-labelledby="staticBackdropLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <div>
                                    <h1 class="modal-title fs-5" id="exampleModalToggleLabel">Create Status</h1>
                                </div>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="clearImage()"></button>
                            </div>
                            <div class="modal-body">
                                <div><a href="" class="body-content-left-avatar"><img src="img/${currentUser.image}">${currentUser.f_name} ${currentUser.l_name}</a>
                                </div>
                                <form action="statuscontroller" method="post">
                                    <textarea name="content" id="" rows="4" placeholder="Would you like to share a memory ?" required></textarea>
                                    <input type="hidden" name="page" id="familyid" value="${familyId}">
                                    <div class="post-img">
                                        <img src=""  id="image1" style="display: none; height: 90px; width: 90px; border-radius: 0px; margin: 10px 0px;">
                                    </div>  
                                    <div class="op-up-up-coming-event">
                                        <input type="file" name="image" accept="image/gif, image/jpg, image/png" onchange="chooseFile(this)" >
                                        <button class="btn btn-primary">Upload</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="templates/js/bootstrap.min.js"></script>    
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>   
        <script src="templates/js/validator.min.js"></script> 
        <script src="templates/js/main.js"></script>
        <script src="templates/js/jquery.min.js"></script>
        <script src="templates/js/moment.min.js"></script>
        <script src="templates/js/fullcalendar.min.js"></script>
        <script src="templates/js/swipter-bundle.js"></script>
        <script src="js/postStatus.js"></script>
        <script>

                                            function searchFamilyEventByMonth() {
                                                var familyid = document.getElementById("familyid").value;
                                                var selectedMonth = document.getElementById("familyevent_month").value;
                                                var listFamilyEvent = document.getElementsByClassName("familyevent")[0];
                                                listFamilyEvent.innerHTML = "";
                                                $.ajax({
                                                    url: '/SocialCellNetwork/filterfamilyevent',
                                                    type: 'POST',
                                                    data: {
                                                        month: selectedMonth,
                                                        familyid: familyid
                                                    },
                                                    success: function (datafamily) {
                                                        console.log("Get data successful");

                                                        listFamilyEvent.innerHTML = datafamily;
                                                    },
                                                    error: function (xhr) {

                                                        console.log("Error:", xhr.statusText);
                                                    }
                                                });
                                            }

                                            function chooseFile(fileInput) {
                                                if (fileInput.files && fileInput.files[0]) {
                                                    var reader = new FileReader();

                                                    reader.onload = function (e) {
                                                        $('#image1').attr('src', e.target.result);
                                                        $('#image1').css("display", "block");
                                                    };
                                                    reader.readAsDataURL(fileInput.files[0]);
                                                }
                                            }
                                            function clearImage() {
                                                $('#image1').attr('src', null);
                                                $('#image1').css("display", "none");
                                            }

        </script>
    </body>
</html>