<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="main-content">
	<h1>예약 내역</h1>

	<nav class="tabs-nav">
		<ul>
			<li><a href="#" class="active" data-status="upcoming">다가오는 여행</a></li>
			<li><a href="#" data-status="past">이전 여행</a></li>
			<li><a href="#" data-status="canceled">취소된 여행</a></li>
		</ul>
	</nav>

	<div class="booking-list">
		<%-- 예약 내역이 없을 경우 --%>
		<c:if test="${empty bookingList}">
			<p>예약 내역이 없습니다.</p>
		</c:if>

		<%-- 예약 목록 반복 --%>
		<c:forEach var="b" items="${bookingList}">
			<div class="booking-card">
				<img src="${pageContext.request.contextPath}/image/${b.photoPath}" alt="숙소 이미지">
				<div class="details">
					<h3>${b.name}</h3>
					<p class="dates">
						<fmt:formatDate value="${b.checkInDate}" pattern="yyyy-MM-dd" /> ~ 
						<fmt:formatDate value="${b.checkOutDate}" pattern="yyyy-MM-dd" />
					</p>
					<p class="price">
						₩<fmt:formatNumber value="${b.pricePerNight}" pattern="#,###" /> / 1박
					</p>
					<c:choose>
						<c:when test="${b.bookingStatus == 'UPCOMING'}">
							<span class="status-badge upcoming">UPCOMING</span>
						</c:when>
						<c:when test="${b.bookingStatus == 'PAST'}">
							<span class="status-badge past">PAST</span>
							<button type="button" class="btn-primary btn-card btn-review" data-booking-id="${b.bookingId}" data-accommodation-id="${b.accommodationId}">리뷰쓰기</button>
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

<div id="reviewModal" class="modal-backdrop">
    <div class="modal-content">
        <button type="button" class="modal-close">&times;</button>
        <h2>리뷰 작성</h2>
        <form id="reviewForm">
            <input type="hidden" id="reviewBookingId" name="bookingId">
            <input type="hidden" id="reviewAccommodationId" name="accommodationId">
            <input type="hidden" id="reviewUserId" name="userId" value="user1">
            
            <div class="form-group">
                <label for="reviewScore">점수 (1~5점)</label>
                <input type="number" id="reviewScore" name="score" class="form-group input" min="1" max="5" value="5" required>
            </div>
            
            <div class="form-group">
                <label for="reviewContent">내용</label>
                <textarea id="reviewContent" name="content" required></textarea>
            </div>
            <div class="form-actions">
                <button type="submit" class="btn-primary">리뷰 제출</button>
            </div>
        </form>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 탭 필터링 관련 요소 및 함수
    const tabs = document.querySelectorAll('.tabs-nav a');
    const bookingCards = document.querySelectorAll('.booking-card');
    function filterBookings(targetStatus) {
        bookingCards.forEach(card => {
            const statusBadge = card.querySelector('.status-badge');
            if (statusBadge && statusBadge.textContent.trim().toLowerCase() === targetStatus) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
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
    if (tabs.length > 0) {
        tabs[0].click();
    }

    // 모달 관련 요소 및 이벤트
    const reviewModal = document.getElementById('reviewModal');
    const closeModalButton = reviewModal.querySelector('.modal-close');
    const reviewForm = document.getElementById('reviewForm');

    // '리뷰쓰기' 버튼들에 모달 열기 이벤트 추가
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.dataset.bookingId;
            const accommodationId = this.dataset.accommodationId;
            document.getElementById('reviewBookingId').value = bookingId;
            document.getElementById('reviewAccommodationId').value = accommodationId;
            reviewModal.style.display = 'flex';
        });
    });

    // 모달 닫기 기능
    function closeModal() {
        reviewModal.style.display = 'none';
    }
    closeModalButton.addEventListener('click', closeModal);
    reviewModal.addEventListener('click', event => {
        if (event.target === reviewModal) {
            closeModal();
        }
    });

    // 리뷰 폼 제출(AJAX) 기능
    reviewForm.addEventListener('submit', function(event) {
        event.preventDefault();
        const formData = new URLSearchParams(new FormData(reviewForm));
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
                alert('리뷰 등록에 실패했습니다: ' + (data.message || ''));
            }
        })
        .catch(err => {
            console.error('Error:', err);
            alert('오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
        });
    });
});
</script>