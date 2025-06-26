<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
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
</html>