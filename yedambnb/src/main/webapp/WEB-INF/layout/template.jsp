<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<<<<<<< HEAD
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Simple Sidebar - Start Bootstrap Template</title>
        <!-- Favicon-->
        <link rel="icon" type="image/x-icon" href="assets/favicon.ico" />
        <!-- Core theme CSS (includes Bootstrap)-->
        <link href="css/styles.css" rel="stylesheet" />
    </head>
    <body>
        <div class="d-flex" id="wrapper">
            <!-- Sidebar-->
            <tiles:insertAttribute name="menu" />
            <!-- Page content wrapper-->
            <div id="page-content-wrapper">
                <!-- Top navigation-->
                <tiles:insertAttribute name="header" />
                <!-- Page content-->
                <div class="container-fluid">
                	<tiles:insertAttribute name="body" />
                </div>
            </div>
        </div>
        <tiles:insertAttribute name="footer" />
    </body>
=======
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <%-- 페이지마다 다른 제목이 들어올 자리 --%>
    <title><tiles:insertAttribute name="title" /></title>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <div class="page-container">
    
        <%-- 모든 페이지에 공통으로 보일 사이드바 --%>
        <aside class="sidebar">
            <h2>My Page</h2>
            <nav class="menu">
                <ul>
                    <%-- 링크는 나중에 타일즈 설정 이름으로 바꿀 수 있습니다. 우선 .do로 둡니다. --%>
                    <li><a href="userInfo.do">정보 수정</a></li>
                    <li><a href="bookingList.do">예약 내역</a></li>
                    <li><a href="wishlist.do">위시리스트</a></li>
                </ul>
            </nav>
        </aside>

        <%-- 페이지마다 내용이 바뀌는 '본문'이 들어올 자리 --%>
        <main class="main-content">
            <tiles:insertAttribute name="body" />
        </main>
        
    </div>
</body>
>>>>>>> branch 'mypage' of https://github.com/Seop-dev/yedambnb.git
</html>