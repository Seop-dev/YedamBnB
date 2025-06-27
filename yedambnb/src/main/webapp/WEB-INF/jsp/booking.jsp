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
				<%-- [참고] 사진 테이블이 없어졌으므로, 우선 임시 이미지를 사용합니다. --%>
				<img src="${pageContext.request.contextPath}/image/listing-default.png" alt="숙소 이미지">
				<div class="details">
					<%-- [수정] b.name -> b.lodgingName --%>
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
                            <button type="button" class="btn-cancel-styled btn-card btn-cancel" data-booking-id="${b.bookingId}">취소하기</button>
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
                                    <%-- [수정] data-accommodation-id -> data-lodging-id --%>
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
    <div class="modal-content">
        <button type="button" class="modal-close">&times;</button>
        <h2>리뷰 작성</h2>
        <form id="reviewForm">
            <input type="hidden" id="reviewBookingId" name="bookingId">
            <%-- [수정] accommodationId -> lodgingId --%>
            <input type="hidden" id="reviewLodgingId" name="lodgingId">
            <%-- [수정] user1 -> 실제 로그인 ID. 컨트롤러에서 세션 ID를 사용하도록 변경했으므로 이 값은 로그인 기능과 연동됩니다. --%>
            <input type="hidden" id="reviewUserId" name="userId" value="${logId}">
            
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
    // ... (탭 필터링, 모달 닫기 등 다른 로직은 동일)

    // '리뷰쓰기' 버튼들에 모달 열기 이벤트 추가
    document.querySelectorAll('.btn-review').forEach(button => {
        button.addEventListener('click', function() {
            const bookingId = this.dataset.bookingId;
            const lodgingId = this.dataset.lodgingId; // [수정]
            document.getElementById('reviewBookingId').value = bookingId;
            document.getElementById('reviewLodgingId').value = lodgingId; // [수정]
            reviewModal.style.display = 'flex';
        });
    });

    // 리뷰 폼 제출(AJAX) 기능
    const reviewForm = document.getElementById('reviewForm');
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
                    alert('리뷰 등록에 실패했습니다.');
                }
            })
            .catch(err => console.error('Error:', err));
        });
    }
    
    // ... (예약 취소 로직은 동일)
});
</script>