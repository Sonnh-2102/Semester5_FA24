<%-- 
    Document   : login
    Created on : Jan 19, 2024, 1:37:48 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html class="no-js" lang="">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="x-ua-compatible" content="ie=edge">
        <title>SCN | Login</title>
        <meta name="description" content="">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="templates/css/bootstrap.min.css">
        <!-- Fontawesome CSS -->
        <link rel="stylesheet" href="templates/css/fontawesome-all.min.css">
        <link rel="shortcut icon" type="image/x-icon" href="img/favicon.jpg">
        <!-- Flaticon CSS -->
        <link rel="stylesheet" href="templates/font/flaticon.css">
        <!-- Custom CSS -->
        <link rel="stylesheet" href="templates/css/style.css">
    </head>

    <body>
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
                <div class="row align-items-center">
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
                    <div class="col-lg-6 col-12 fxt-bg-color">
                        <div class="fxt-content">
                            <div class="fxt-form">
                                <h2>Login</h2>
                                <p>Login into your pages account</p>
                                <h5 style="color: red">${error}</h5>
                                <h5 style="color: red">${error1}</h5>
                                <c:set var="cookie" value="${pageContext.request.cookies}"/>
                                <form action="login" method="POST">
                                    <div class="form-group">
                                        <label for="email" class="input-label">Username</label>
                                        <input type="text" id="user-name" class="form-control" name="userOrGmail"
                                               value="${cookie.userOrGmail.value}" placeholder="username" required="required">
                                    </div>
                                    <div class="form-group">
                                        <label for="password" class="input-label">Password</label>
                                        <input id="password" type="password" class="form-control" name="password"
                                               value="${cookie.password.value}" placeholder="password" required="required">
                                        <i toggle="#password" class="fa fa-fw fa-eye toggle-password field-icon"></i>
                                    </div>
                                    <div class="form-group">
                                        <div class="fxt-checkbox-area">
                                            <div class="checkbox">
                                                <input id="checkbox1" type="checkbox" name="remember" 
                                                       ${cookie.remember != null ? 'checked' : ''} value="ON">
                                                <label for="checkbox1">Keep me logged in</label>
                                            </div>
                                            <a href="forgotpassword" class="switcher-text">Forgot Password</a>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="submit" class="fxt-btn-fill">Log in</button>
                                    </div>
                                </form>
                            </div>
                            <div class="fxt-style-line">
                                <h3>Or Login With</h3>
                            </div>
                            <ul class="fxt-socials">
                                <!-- <li class="fxt-facebook"><a href="#" title="facebook">Facebook</a></li>-->
                                <li class="fxt-google">
                                    <a href="https://accounts.google.com/o/oauth2/auth?scope=profile%20email&redirect_uri=http://localhost:9999/SocialCellNetwork/logingoogle&response_type=code
                                       &client_id=935117260283-9osjdo6k40dm6c6vjgfu3tliscbi8bn3.apps.googleusercontent.com&approval_prompt=force" title="google">
                                        Google
                                    </a>
                                </li>
                            </ul>
                            <div class="fxt-footer">
                                <p>Don't have an account?<a href="register" class="switcher-text2 inline-text">Register</a></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
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
    </body>

</html>
