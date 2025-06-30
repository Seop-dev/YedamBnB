<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<main class="main-content">
	<h1>예약 내역</h1>

	<nav class="tabs-nav">
		<ul>
			<li><a href="#" class="active" data-status="upcoming">다가오는
					여행</a></li>
			<li><a href="#" data-status="past">이전 여행</a></li>
			<li><a href="#" data-status="canceled">취소된 여행</a></li>
		</ul>
	</nav>

	<div class="booking-list">
		<c:if test="${empty bookingList}">
			<p>예약 내역이 없습니다.</p>
		</c:if>

		<c:forEach var="b" items="${bookingList}">
			<div class="booking-card"
				data-status="${b.bookingStatus.toLowerCase()}">
				<c:choose>
					<%-- 썸네일 이미지가 있는 경우 --%>
					<c:when test="${not empty b.thumbnailImg}">
						<img
							src="${pageContext.request.contextPath}/image/${b.thumbnailImg}"
							alt="${b.lodgingName}">
					</c:when>
					<%-- 썸네일 이미지가 없는 경우 기본 이미지 표시 --%>
					<c:otherwise>
						<img
							src="${pageContext.request.contextPath}/image/listing-default.png"
							alt="숙소 이미지">
					</c:otherwise>
				</c:choose>
				<div class="details">
					<h3>${b.lodgingName}</h3>
					<p class="dates">
						<fmt:formatDate value="${b.checkInDate}" pattern="yyyy-MM-dd" />
						~
						<fmt:formatDate value="${b.checkOutDate}" pattern="yyyy-MM-dd" />
					</p>
					<p class="price">
						₩
						<fmt:formatNumber value="${b.pricePerNight}" pattern="#,###" />
						/ 1박
					</p>
					<c:choose>
						<c:when test="${b.bookingStatus == 'UPCOMING'}">
							<span class="status-badge upcoming">UPCOMING</span>
							<button type="button" class="btn-secondary btn-card cancel-btn"
								data-booking-id="${b.bookingId}">취소하기</button>
								
						</c:when>
						<c:when test="${b.bookingStatus == 'PAST'}">
							<span class="status-badge past">PAST</span>
							<c:choose>
								<c:when test="${not empty b.commentText}">
									<div class="written-review">
										<strong>내 리뷰:</strong> ★${b.score} ${b.commentText}
									</div>
								</c:when>
								<c:otherwise>
									<button type="button" class="btn-primary btn-card btn-review"
										data-booking-id="${b.bookingId}"
										data-lodging-id="${b.lodgingNo}" data-user-id="${logId}">리뷰쓰기</button>

								</c:otherwise>
							</c:choose>
						</c:when>
						<c:when test="${b.bookingStatus == 'CANCELED'}">
							<span class="status-badge canceled">CANCELED</span>
						</c:when>
					</c:choose>
				</div>
			</div>

		</c:forEach>
	</div>
</main>

<%-- [수정됨] 리뷰 모달창 UI를 숫자 선택(select) 방식으로 변경하고, mypage.css 스타일을 따르도록 class 수정 --%>
<div id="reviewModal" class="modal-backdrop">
	<div class="modal-content">
		<h2>리뷰 작성</h2>
		<button type="button" class="modal-close">&times;</button>
		<form id="reviewForm">
			<div class="form-group">
				<label for="scoreSelect">점수</label> <select id="scoreSelect"
					name="score" class="form-control">
					<option value="" selected disabled>-- 점수를 선택해주세요 --</option>
					<option value="5">5점</option>
					<option value="4">4점</option>
					<option value="3">3점</option>
					<option value="2">2점</option>
					<option value="1">1점</option>
				</select>
			</div>
			<div class="form-group">
				<label for="reviewContent">리뷰 내용</label>
				<textarea class="form-control" id="reviewContent" rows="4"
					placeholder="리뷰를 작성해주세요."></textarea>
			</div>
			<div class="form-actions">
				<button type="submit" class="btn-primary">제출하기</button>
			</div>
		</form>
	</div>
</div>


<script>
document.addEventListener('DOMContentLoaded', function() {
    // 공용 변수 선언
    const tabs = document.querySelectorAll('.tabs-nav a');
    const bookingCards = document.querySelectorAll('.booking-card');
    const reviewModal = document.getElementById('reviewModal');
    const reviewForm = document.getElementById('reviewForm');
    const closeModalBtn = document.querySelector('.modal-close');
    let currentLodgingId, currentUserId;

    // --- 탭 필터링 기능 ---
    function filterBookings(targetStatus) {
        bookingCards.forEach(card => {
            card.style.display = (card.dataset.status === targetStatus) ? 'flex' : 'none';
        });
    }

    tabs.forEach(tab => {
        tab.addEventListener('click', function(event) {
            event.preventDefault();
            tabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            filterBookings(this.dataset.status);
        });
    });

    // --- 예약 취소 기능 ---
    document.querySelectorAll('.cancel-btn').forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.dataset.bookingId;
            if (confirm('정말로 이 예약을 취소하시겠습니까?')) {
                fetch('/yedambnb/cancelBooking.do', {
                    method: 'POST',
                    headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
                    body: 'bookingId=' + bookingId
                })
                .then(response => response.json())
                .then(data => {
                    if (data.retCode === 'Success') {
                        alert('예약이 성공적으로 취소되었습니다.');
                        location.reload();
                    } else {
                        alert('예약 취소에 실패했습니다.');
                    }
                })
                .catch(err => console.error('Error:', err));
            }
        });
    });

    // --- 리뷰쓰기 관련 기능 ---
    // '리뷰쓰기' 버튼 클릭 => 모달 열기
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', function() {
            currentLodgingId = this.dataset.lodgingId;
            currentUserId = this.dataset.userId;
            reviewModal.style.display = 'flex'; // mypage.css에 따라 flex로 설정
        });
    });

    // 모달 닫기 버튼
    if (closeModalBtn) {
        closeModalBtn.addEventListener('click', () => {
            reviewModal.style.display = 'none';
        });
    }

    // 모달 바깥 영역 클릭 시 닫기
    window.addEventListener('click', (event) => {
        if (event.target == reviewModal) {
            reviewModal.style.display = 'none';
        }
    });

    // 리뷰 '제출하기' 버튼 클릭
    if (reviewForm) {
        reviewForm.addEventListener('submit', function(event) {
            event.preventDefault();

            // [수정됨] 점수를 <select> 태그에서 가져옵니다.
            const scoreSelect = document.getElementById('scoreSelect');
            const score = scoreSelect.value;
            const content = document.getElementById('reviewContent').value;

            if (!score) {
                alert('점수를 선택해주세요.');
                return;
            }

            const formData = new URLSearchParams();
            formData.append('lodgingId', currentLodgingId);
            formData.append('userId', currentUserId);
            formData.append('score', score);
            formData.append('content', content);

            fetch('/yedambnb/addReview.do', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                if (data.retCode === 'Success') {
                    alert('리뷰가 성공적으로 등록되었습니다.');
                    location.reload();
                } else {
                    alert('리뷰 등록에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('Error:', err);
            });
        });
    }

    // 초기 탭 설정
    if (tabs.length > 0) {
        tabs[0].click();
    }
});
</script>