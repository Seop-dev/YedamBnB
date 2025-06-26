<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page - <tiles:insertAttribute name="title" /></title>
    
    <%-- mypage.css 파일을 연결합니다. --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>
    <div class="page-container">
    
        <aside class="sidebar">
            <h2>My Page</h2>
            <nav class="menu">
                <ul>
                    <li><a href="userInfo.do">정보 수정</a></li>
                    <li><a href="bookingList.do">예약 내역</a></li>
                    <li><a href="wishlist.do">위시리스트</a></li>
                </ul>
            </nav>
        </aside>

        <main class="main-content">
            <tiles:insertAttribute name="body" />
        </main>
        
    </div>
</body>
</html>