<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<input type="hidden" id="accommodationId" value="${lodging.lodgingNo}">

<!-- 사진안에 숙소제목넣는곳 -->
    <div
      class="hero page-inner overlay"
      style="background-image: url('images/hero_bg_3.jpg')"
    >
      <div class="container">
        <div class="row justify-content-center align-items-center">
          <div class="col-lg-9 text-center mt-5">
            <h1 class="heading" data-aos="fade-up">
              ${lodging.name }
            </h1>

            <nav
              aria-label="breadcrumb"
              data-aos="fade-up"
              data-aos-delay="200"
            >
              <ol class="breadcrumb text-center justify-content-center">
                <li class="breadcrumb-item"><a href="index.html">숙소${lodging.lodgingId }</a></li>
                <li class="breadcrumb-item">
                  <a href="properties.html">${lodging.address }</a>
                </li>
                <li
                  class="breadcrumb-item active text-white-50"
                  aria-current="page"
                >
                  ${lodging.name }
                </li>
              </ol>
            </nav>
          </div>
        </div>
      </div>
      </div>

<!-- 사진영역 -->
<!--  
<div class="section" style="margin-top: 100px;">
      <div class="container">
        <div class="row justify-content-between">
          <div class="col-lg-7">
            <div class="img-property-slide-wrap">
              <div class="img-property-slide">
                <img src="../image/seoul_img/seoul01_1.jpeg" alt="Image" class="img-fluid" />
                <img src="images/img_2.jpg" alt="Image" class="img-fluid" />
                <img src="images/img_3.jpg" alt="Image" class="img-fluid" />
              </div>
            </div>
          </div> -->
<!-- 사진영역 -->
<section class="section bg-white py-5 mb-5">
  <div class="container">
<div class="row g-2">
  <!-- 왼쪽 큰 이미지 -->
  <div class="col-lg-8 col-md-8 col-12" >
    <img src="/yedambnb/image/seoul_img/seoul01_1.jpeg" class="img-fluid rounded w-100" alt="대표사진">
  </div>
  <!-- 오른쪽 이미지들 -->
  <div class="col-lg-4 col-md-4 col-12 d-flex flex-column justify-content-between">
    <img src="images/img_2.jpg" class="img-fluid rounded mb-2" style="height:49%; object-fit:cover;" alt="서브1">
    <img src="images/img_3.jpg" class="img-fluid rounded" style="height:49%; object-fit:cover;" alt="서브2">
  </div>
</div>
</div>
</section>




<!-- 숙소제목, 위치, 설명  -->
<div class="section bg-light mt-5">
  <div class="container">
    <div class="row">
      <div class="col-12">
          <div class="col-lg-4">
            <h2 class="heading text-primary">${lodging.name }</h2>
            <p class="meta">${lodging.address }</p>	
          <div class="mt-3">
            <h5 class="text-primary">숙소 설명</h5>
            <p class="text-black-50">${lodging.description}</p>
          </div>
          </div>
          </div>
          </div>
          </div>
          </div>
<!--  숙소제목, 위치, 설명 -->
          
<!-- 예약/결제 폼 영역 -->
<div class="section bg-light mt-5">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <div class="card p-4 mb-4 shadow-sm" id="booking">
          <h5 class="mb-3">숙소 예약하기</h5>
          <div class="mb-3">
            <label for="checkin" class="form-label">체크인</label>
            <input type="date" class="form-control" id="checkIn" name="checkIn" required>
          </div>
          <div class="mb-3">
            <label for="checkout" class="form-label">체크아웃</label>
            <input type="date" class="form-control" id="checkOut" name="checkOut" required>
          </div>
          <div class="mb-3">
            <label for="guests" class="form-label">인원</label>
            <select class="form-select" id="guests" name="guests" required>
              <option value="" selected disabled>선택</option>
              <option value="1">1명</option>
              <option value="2">2명</option>
              <option value="3">3명</option>
              <option value="4">4명</option>
              <option value="5">5명</option>
            </select>
          </div>
          <button type="button" class="btn btn-primary w-100">예약하기</button>
        </div>
        </div>
        </div>
        </div>
        </div>


<script>
console.log("lodging.lodgingNo = [${lodging.lodgingNo}]");
console.log("lodging = ", "${lodging}");


      document.querySelector('.btn').addEventListener("click", function(e) {
	  e.preventDefault();
	  let checkInDate = document.getElementById("checkIn").value;
	  let checkOutDate = document.getElementById("checkOut").value;
	  let accommodationId = '${lodging.lodgingNo}';

	  console.log("fetch url: " + url);
	  console.log("accommodationId: " + accommodationId);
	  console.log("checkInDate: ", checkInDate);
	  console.log("checkOutDate: ", checkOutDate);
	  
	  fetch(/yedambnb/addBooking.do?accommodation_id=${accommodationId}&check_in_date=${checkInDate}&check_out_date=${checkOutDate}`, {method: 'GET'})
	    .then(result => result.json())
	    .then(data => {
	      if(data.retCode == "Success") {
	        alert("예약이 완료되었습니다.");
	      } else {
	        alert("예약을 취소했습니다");
	      }
	    });
	});
</script>
<!-- 예약/결제 폼 영역 -->

<!-- 리뷰조회 -->
<div class="section bg-light mt-5">
  <div class="container">
    <div class="row">
      <div class="col-12">
        <h3 class="mb-4">리뷰</h3>
        <!-- 평균 리뷰 점수 (5점 만점) -->
        <c:set var="reviewSum" value="0" />
        <c:set var="reviewCnt" value="0" />
        <c:forEach var="review" items="${reviewList}">
            <c:set var="reviewSum" value="${reviewSum + review.score}" />
            <c:set var="reviewCnt" value="${reviewCnt + 1}" />
        </c:forEach>
        <c:choose>
          <c:when test="${reviewCnt > 0}">
            <c:set var="reviewAvg" value="${reviewSum / reviewCnt}" />
            <div style="
              display: flex;
              align-items: center;
              background: #f8fafc;
              border: 1.5px solid #00BCD4;
              border-radius: 16px;
              padding: 12px 24px;
              margin-bottom: 18px;
              font-size: 1.18em;">
              <span style="color:#00BCD4; font-weight:bold; font-size:1.5em;">
                <fmt:formatNumber value="${reviewAvg}" maxFractionDigits="1"/>
              </span>
              <span style="color:#666; margin:0 8px 0 8px;">/ 5점</span>
            </div>
          </c:when>
          <c:otherwise>
            <div class="text-muted mb-4">아직 등록된 리뷰가 없습니다.</div>
          </c:otherwise>
        </c:choose>
        <!-- 리뷰 리스트 -->
        <c:forEach var="review" items="${reviewList}">
          <div class="card mb-3 p-3">
            <strong>${review.userName}</strong>
            <span style="display: inline-block; font-size: 1.2em; color: #00BCD4; font-weight: bold; margin-left:8px;">
              ${review.score}
            </span>
            <p class="mb-0 mt-2">${review.commentText}</p>
          </div>
        </c:forEach>
      </div>
    </div>
  </div>
</div>

