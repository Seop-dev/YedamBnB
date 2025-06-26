<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Page - 정보 수정</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/mypage.css">
</head>
<body>

    <div class="page-container">
        <main class="main-content">
            <h1>정보 수정</h1>
            
            <form action="userInfo.do" method="post">
                <section class="form-section">
                    
                    <input type="hidden" name="userNo" value="${userInfo.userNo}">
                
                    <div class="form-row">
                        <div class="form-group">
                            <label for="userId">아이디</label>
                            <input type="text" id="userId" name="userId" value="${userInfo.userId}" readonly>
                        </div>
                        <div class="form-group">
                            <label for="userName">이름</label>
                            <input type="text" id="userName" name="userName" value="${userInfo.userName}">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="phone">휴대폰 번호</label>
                        <input type="tel" id="phone" name="phone" value="${userInfo.telephone}">
                    </div>
                    <div class="form-group">
                        <label for="birthDate">생년월일</label>
                        <fmt:formatDate value="${userInfo.birthDate}" pattern="yyyy-MM-dd" var="BirthDate" />
                        <input type="date" id="birthDate" name="birthDate" value="${BirthDate}">
                    </div>
                </section>

                <hr>

                <div class="form-actions">
                    <button type="submit" class="btn-primary">저장하기</button>
                </div>
            </form>
        </main>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const result = urlParams.get('result');

            if (result === 'success') {
                alert('성공적으로 저장되었습니다.');
            } else if (result === 'fail') {
                alert('수정 실패! 다시 시도해주세요.');
            }

            if (result) {
                history.replaceState({}, document.title, window.location.pathname);
            }
        });
    </script>
</body>
</html>