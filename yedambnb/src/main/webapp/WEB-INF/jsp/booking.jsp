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
		<c:if test="${empty bookingList}">
			<p>예약 내역이 없습니다.</p>
		</c:if>

		<c:forEach var="b" items="${bookingList}">
			<div class="booking-card" data-status="${b.bookingStatus.toLowerCase()}">
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
                            <button type="button" class="btn-card btn-secondary btn-cancel" data-booking-id="${b.bookingId}">취소하기</button>
						</c:when>
						<c:when test="${b.bookingStatus == 'PAST'}">
							<span class="status-badge past">PAST</span>
							<c:choose>
							    <c:when test="${not empty b.commentText}">
							        <div class="written-review">
							        <p> </p>
							            <strong>내 리뷰:</strong> ★${b.score} ${b.commentText}
							        </div>
							    </c:when>
							    <c:otherwise>
							        <button type="button" class="btn-card btn-primary btn-review"
							                data-booking-id="${b.bookingId}" 
							                data-accommodation-id="${b.accommodationId}">리뷰쓰기</button>
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
    const tabs = document.querySelectorAll('.tabs-nav a');
    const bookingCards = document.querySelectorAll('.booking-card');
    const reviewModal = document.getElementById('reviewModal');
    const closeModalButton = reviewModal.querySelector('.modal-close');
    const reviewForm = document.getElementById('reviewForm');

    // --- 탭 필터링 기능 ---
    function filterBookings(targetStatus) {
        bookingCards.forEach(card => {
            if (card.dataset.status === targetStatus) {
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

    // --- 모달창 열기/닫기 기능 ---
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.dataset.bookingId;
            const accommodationId = this.dataset.accommodationId;
            document.getElementById('reviewBookingId').value = bookingId;
            document.getElementById('reviewAccommodationId').value = accommodationId;
            reviewModal.style.display = 'flex';
        });
    });
    function closeModal() { reviewModal.style.display = 'none'; }
    if(closeModalButton) closeModalButton.addEventListener('click', closeModal);
    reviewModal.addEventListener('click', event => { if (event.target === reviewModal) closeModal(); });

    // --- 리뷰 폼 제출(AJAX) 기능 ---
    if(reviewForm) {
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
    }

    // --- 예약 취소(AJAX) 기능 ---
    document.querySelectorAll('.btn-cancel').forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();
            if (!confirm('이 예약을 정말로 취소하시겠습니까?')) return;

            const bookingId = this.dataset.bookingId;
            const cardToCancel = this.closest('.booking-card');
            const formData = new URLSearchParams();
            formData.append('bookingId', bookingId);

            fetch('/yedambnb/cancelBooking.do', { method: 'POST', body: formData })
            .then(response => response.json())
            .then(data => {
                if (data.retCode === 'Success') {
                    alert('예약이 취소되었습니다.');
                    cardToCancel.dataset.status = 'canceled';
                    const detailsDiv = cardToCancel.querySelector('.details');
                    // 기존 버튼과 뱃지를 모두 지우고, 새로운 CANCELED 뱃지를 추가합니다.
                    detailsDiv.querySelector('.status-badge').remove();
                    detailsDiv.querySelector('.btn-cancel').remove();
                    detailsDiv.insertAdjacentHTML('beforeend', '<span class="status-badge canceled">CANCELED</span>');
                    
                    document.querySelector('.tabs-nav a.active').click();
                } else {
                    alert('예약 취소에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('오류가 발생했습니다.');
            });
        });
    });

    // --- 페이지 초기화 ---
    if (tabs.length > 0) {
        tabs[0].click();
    }
});
</script>