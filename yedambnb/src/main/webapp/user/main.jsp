<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<c:if test="${not empty loginUser}">
  <p>${loginUser.userName}님 환영합니다!</p>
  <a href="logout.do">로그아웃</a>
</c:if>
