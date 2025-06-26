<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%-- 
  이제 이 파일은 '본문' 조각이므로, <html>, <head>, <body>, <aside> 태그 등은
  모두 template.jsp가 담당합니다. 여기서는 <main> 태그부터 시작합니다.
--%>
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
			<div class="booking-card">
				<img src="${pageContext.request.contextPath}/image/${b.photoPath}"
					alt="숙소 이미지">
				<div class="details">
					<h3>${b.name}</h3>
					<p class="dates">
						<fmt:formatDate value="${b.checkInDate}" pattern="yyyy-MM-dd" />
						~
						<fmt:formatDate value="${b.checkOutDate}" pattern="yyyy-MM-dd" />

					</p>
					<p class="price">${b.pricePerNight} / 1박</p>
					<c:choose>
						<c:when test="${b.bookingStatus == 'UPCOMING'}">
							<span class="status-badge upcoming">UPCOMING</span>
						</c:when>
						<c:when test="${b.bookingStatus == 'PAST'}">
							<span class="status-badge past">PAST</span>
							<button type="button" class="btn-primary btn-card">리뷰쓰기</button>
						</c:when>
						<c:when test="${b.bookingStatus == 'CANCELED'}">
							<span class="status-badge canceled">CANCELED</span>
						</c:when>
					</c:choose>
				</div>
			</div>
		</c:forEach>
	</div>

	<script>
		// 이 스크립트는 이 페이지에서만 사용되므로 여기에 남겨둡니다.
		document.addEventListener('DOMContentLoaded', function() {
			var tabs = document.querySelectorAll('.tabs-nav a');
			var bookingCards = document.querySelectorAll('.booking-card');

			function filterBookings(targetStatus) {
				for (var k = 0; k < bookingCards.length; k++) {
					var card = bookingCards[k];
					var statusBadge = card.querySelector('.status-badge');

					if (statusBadge
							&& statusBadge.classList.contains(targetStatus)) {
						card.style.display = 'flex';
					} else {
						card.style.display = 'none';
					}
				}
			}

			for (var i = 0; i < tabs.length; i++) {
				tabs[i].addEventListener('click', function(event) {
					event.preventDefault();
					for (var j = 0; j < tabs.length; j++) {
						tabs[j].classList.remove('active');
					}
					this.classList.add('active');
					var targetStatus = this.getAttribute('data-status');
					filterBookings(targetStatus);
				});
			}

			if (tabs.length > 0) {
				tabs[0].click();
			}
		});
	</script>
</main>