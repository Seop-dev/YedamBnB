<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Page - 정보 수정</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/css/mypage.css">
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
							<label for="userId">아이디</label> <input type="text" id="userId"
								name="userId" value="${userInfo.userId}" readonly>
						</div>
						<div class="form-group">
							<label for="userName">이름</label> <input type="text" id="userName"
								name="userName" value="${userInfo.userName}">
						</div>
					</div>
					<div class="form-group">
						<label for="phone">휴대폰 번호</label> <input type="tel" id="phone"
							name="phone" value="${userInfo.telephone}">
					</div>
					<div class="form-group">
						<label for="birthDate">생년월일</label>
						<fmt:formatDate value="${userInfo.birthDate}" pattern="yyyy-MM-dd"
							var="BirthDate" />
						<input type="date" id="birthDate" name="birthDate"
							value="${BirthDate}">
					</div>
				</section>

				<hr>

				<div class="form-actions">
					<button type="submit" class="btn btn-primary">저장하기</button>
					<button type="button" id="deleteUserBtn" class="btn btn-secondary">회원
						탈퇴</button>
				</div>
			</form>
		</main>
	</div>

	<script>
        // 페이지의 모든 HTML 요소가 로드된 후에 이 코드가 실행됩니다.
        document.addEventListener('DOMContentLoaded', function() {
            
            // --- 파트 1: 정보 수정 결과 alert을 띄우는 기능 ---
            const urlParams = new URLSearchParams(window.location.search);
            const result = urlParams.get('result');

            if (result === 'success') {
                alert('성공적으로 저장되었습니다.');
            } else if (result === 'fail') {
                alert('수정 실패! 다시 시도해주세요.');
            }

            // alert을 보여준 뒤, 주소창에서 파라미터를 깔끔하게 제거합니다.
            if (result) {
                history.replaceState({}, document.title, window.location.pathname);
            }

            // --- 파트 2: 회원 탈퇴 버튼 이벤트 처리 기능 ---
            const deleteBtn = document.getElementById('deleteUserBtn');

            if (deleteBtn) { // 버튼이 페이지에 존재하는지 확인
                deleteBtn.addEventListener('click', function() {
                    
                    // 1. 정말 탈퇴할 것인지 사용자에게 마지막으로 확인받습니다.
                    if (!confirm('정말로 탈퇴하시겠습니까?')) {
                        return; // '취소'를 누르면 아무것도 하지 않음
                    }

                    // 2. 폼에 숨겨진 userNo 값을 가져옵니다.
                    const userNo = document.querySelector('input[name="userNo"]').value;

                    const formData = new URLSearchParams();
                    formData.append('userNo', userNo);

                    // 3. fetch를 이용해 서버에 삭제 요청을 보냅니다.
                    fetch('/yedambnb/deleteUser.do', {
                        method: 'POST',
                        body: formData
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.retCode === 'Success') {
                            alert('회원 탈퇴가 처리되었습니다. 이용해주셔서 감사합니다.');
                            // 4. 성공 시, 로그아웃 처리 후 메인 페이지로 이동합니다.
                            location.href = '/yedambnb/main.do';
                        } else {
                            alert('회원 탈퇴에 실패했습니다. 다시 시도해주세요.');
                        }
                    })
                    .catch(err => {
                        console.error('Error:', err);
                        alert('처리 중 오류가 발생했습니다.');
                    });
                });
            }
        });
    </script>
</body>
</html>

</body>
</html>