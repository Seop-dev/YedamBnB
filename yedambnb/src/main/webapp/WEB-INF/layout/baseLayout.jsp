<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title><tiles:insertAttribute name="title" /></title>

    <%-- Property 템플릿 CSS 경로 수정 --%>
    <link href="<c:url value='/resources/property/css/style.css' />" rel="stylesheet">
    
    <%-- Shop Homepage 템플릿 CSS 경로 수정 --%>
    <link href="<c:url value='/assets/css/styles.css' />" rel="stylesheet">

</head>
<body>

    <tiles:insertAttribute name="header" />
    <tiles:insertAttribute name="body" />
    <tiles:insertAttribute name="footer" />

    <%-- ▼▼▼ 자바스크립트 파일들 경로 수정 ▼▼▼ --%>
    <%-- Property 템플릿 JS --%>
    <script src="<c:url value='/resources/property/js/jquery.min.js' />"></script>
    <script src="<c:url value='/resources/property/js/jquery-migrate-3.0.1.min.js' />"></script>
    <script src="<c:url value='/resources/property/js/bootstrap.bundle.min.js' />"></script> <%-- bootstrap.min.js 대신 bundle.min.js 사용 --%>
    <script src="<c:url value='/resources/property/js/main.js' />"></script>
    
    <%-- Shop Homepage 템플릿 JS --%>
    <script src="<c:url value='/assets/js/scripts.js' />"></script>

</body>
</html>