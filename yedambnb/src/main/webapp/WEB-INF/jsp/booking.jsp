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
			<%-- [수정] 각 카드에 data-status를 직접 부여합니다. --%>
			<div class="booking-card" data-status="${b.bookingStatus.toLowerCase()}">
				<img src="${pageContext.request.contextPath}/image/listing-default.png" alt="숙소 이미지">
				<div class="details">
					<h3>${b.lodgingName}</h3>
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
                            <button type="button" class="cancel-btn btn-cancel" data-booking-id="${b.bookingId}">취소하기</button>
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
							                data-lodging-id="${b.lodgingId}">리뷰쓰기</button>
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
    <%-- ... (모달창 HTML 내용은 이전과 동일하게 유지) ... --%>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const tabs = document.querySelectorAll('.tabs-nav a');
    const bookingCards = document.querySelectorAll('.booking-card');
    // ... (리뷰 모달 관련 변수 선언은 동일) ...

    // --- 탭 필터링 기능 (개선된 방식) ---
    function filterBookings(targetStatus) {
        bookingCards.forEach(card => {
            // [수정] 카드의 data-status 속성값을 직접 비교하여 안정성을 높입니다.
            if (card.dataset.status === targetStatus) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // --- 이하 모든 스크립트는 이전과 동일합니다 ---
    tabs.forEach(tab => {
        tab.addEventListener('click', function(event) {
            event.preventDefault();
            tabs.forEach(t => t.classList.remove('active'));
            this.classList.add('active');
            filterBookings(this.dataset.status);
        });
    });

    // ... (모달 열기/닫기, 리뷰 제출, 예약 취소 기능) ...
    
    // 페이지 초기화
    if (tabs.length > 0) {
        tabs[0].click();
    }
});
</script>