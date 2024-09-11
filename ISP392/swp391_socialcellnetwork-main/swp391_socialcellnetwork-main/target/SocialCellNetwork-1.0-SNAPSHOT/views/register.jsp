<%-- 
    Document   : register
    Created on : Jan 19, 2024, 1:37:52 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Register</title>
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
        <!-- Star Animation CSS -->
        <link rel="stylesheet" href="templates/css/star-animation.css">
        <!-- Google Web Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&amp;display=swap" rel="stylesheet">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="templates/css/style.css">
        <style>
            .name-input-style{
                display: flex;
                justify-content: space-between;
            }
        </style>
    </head>

    <body>

        <div id="preloader" class="preloader">
            <div class='inner'>
                <div class='line1'></div>
                <div class='line2'></div>
                <div class='line3'></div>
            </div>
        </div>
        <section class="fxt-template-animation fxt-template-layout22" data-bg-image="img/bg22-l.jpg">
            <!-- Star Animation Start Here -->
            <div class="star-animation">
                <div id="stars1"></div>
                <div id="stars2"></div>
                <div id="stars3"></div>
                <div id="stars4"></div>
                <div id="stars5"></div>
            </div>
            <!-- Star Animation End Here -->
            <div class="container">
                <div class="row align-items-center" style="align-items: center;">
                    <div class="col-lg-6 col-12 fxt-none-991">
                        <div class="fxt-header">

                            <div class="fxt-transformY-50 fxt-transition-delay-2">
                                <h1>Welcome To Social Cell Networking</h1>
                            </div>
                            <div class="fxt-transformY-50 fxt-transition-delay-3">
                                <p>Welcome to Social Cell Networking, an innovative venture poised to reshape familial connections. Beyond a conventional social network, our project serves as a dynamic hub, facilitating seamless communication, fostering relationships, and weaving the intricate narratives of family lineage.</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6 col-12 fxt-bg-color"  style="align-items: center;">
                        <div class="fxt-content">
                            <div class="fxt-form">
                                <h2>Register</h2>
                                <p>Create an account</p>
                                <form action="register" method="POST">
                                    <div class="name-input-style">
                                        <div class="form-group">
                                            <label for="name" class="input-label" >First Name</label>
                                            <input type="text" id="firstname" class="form-control" name="firstname" placeholder="firstname" required="required" value="${firstname}">
                                        </div>
                                        <div class="form-group" style="margin-left: 20px;">
                                            <label for="name" class="input-label">Last Name</label>
                                            <input type="text" id="lastname" class="form-control" name="lastname" placeholder="lastname" required="required" value="${lastname}">
                                        </div>
                                    </div>
                                        <div class="form-group" style="margin-bottom: 0px">
                                        <label for="name" class="input-label">Username</label>
                                        <input type="text" id="username" class="form-control" name="username" placeholder="username" required="required" value="${username}">
                                        <span style="color: red; font-size: 15px; padding-left: 5px">${errorUsername}</span>
                                    </div>
                                    <div class="name-input-style">
                                        <div class="form-group">
                                            <label for="name" class="input-label">Phone Number</label>
                                            <input type="text" id="number" class="form-control" name="phone_number" placeholder="Enter phone number" minlength="10" maxlength="10" pattern="[0-9]{10}" title="Please enter a 10-digit phone number" value="${phone}">
                                            <span style="color: red; font-size: 15px; padding-left: 5px">${errorPhone}</span>
                                        </div>
                                        <div class="form-group">
                                            <label for="email" class="input-label">Email</label>
                                            <input type="email" id="email" class="form-control" name="email" placeholder="demo@gmail.com" value="${email}">
                                            <span style="color: red; font-size: 15px; padding-left: 5px">${errorEmail}</span>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label>
                                            <input type="radio" name="gender" value="1" required ${gender == 1 ? "checked" : ""} checked=""> 
                                            <span style="color: #979696;
                                                  margin-bottom: 10px;
                                                  font-weight: 500; margin-right: 80px; cursor: pointer">Male</span>
                                        </label>

                                        <label>
                                            <input type="radio" name="gender" value="0" required ${gender == 0 ? "checked" : ""}> 
                                            <span style="color: #979696;
                                                  margin-bottom: 10px;
                                                  font-weight: 500; cursor: pointer">Female</span>
                                        </label>
                                    </div>

                                    <div class="form-group">
                                        <label for="password" class="input-label">Password</label>
                                        <input id="password" type="password" class="form-control" name="password" placeholder="Enter password" required="required" oninput="validatePassword()">
                                        <i toggle="#password" class="fa fa-fw fa-eye toggle-password field-icon"></i>

                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="input-label">Confirm Password</label>
                                        <input id="re-password" type="password" class="form-control" name="confirmPassword" placeholder="Confirm password" required="required" oninput="validatePassword()">
                                        <i toggle="#re-password" class="fa fa-fw fa-eye toggle-password field-icon"></i>
                                    </div>
                                    <div class="form-group" style="margin-top: 60px">
                                        <button type="submit" class="fxt-btn-fill">Register</button>
                                    </div>
                                </form>
                            </div>
                            <div class="fxt-footer">
                                <p>Have an account?<a href="login" class="switcher-text2 inline-text">Log in</a></p>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </section>
        <!-- jquery-->
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                var password = document.getElementById("password");
                var confirmPassword = document.getElementById("re-password");

                function validatePassword() {
                    if (password.value !== confirmPassword.value) {
                        confirmPassword.setCustomValidity("Passwords do not match");
                    } else {
                        confirmPassword.setCustomValidity('');
                    }
                }

                password.addEventListener('change', validatePassword);
                confirmPassword.addEventListener('keyup', validatePassword);
            });
        </script>
        <script src="templates/js/jquery.min.js"></script>
        <!-- Bootstrap js -->
        <script src="templates/js/bootstrap.min.js"></script>
        <!-- Imagesloaded js -->
        <script src="templates/js/imagesloaded.pkgd.min.js"></script>
        <!-- Validator js -->
        <script src="templates/js/validator.min.js"></script>
        <!-- Custom Js -->
        <script src="js/main.js"></script>

    </body>


</html>