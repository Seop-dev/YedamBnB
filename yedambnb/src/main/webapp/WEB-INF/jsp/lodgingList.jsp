<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<input type="hidden" id="lodgingNo" value="${lodging.lodgingNo}">

<!-- 헤더부분 사진 및 설명 -->
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

<!-- 사진영역  0~3 서울,  4~6 부산, 7~9 대구, 10~12 광주, 나머지 제주-->
<c:choose>
  <c:when test="${lodging.lodgingNo <= 4}">
    <c:set var="city" value="seoul"/>
    <c:set var="num" value="${lodging.lodgingNo}"/>
  </c:when>
  <c:when test="${lodging.lodgingNo <= 8}">
    <c:set var="city" value="busan"/>
    <c:set var="num" value="${lodging.lodgingNo - 4}"/>
  </c:when>
  <c:when test="${lodging.lodgingNo <= 12}">
    <c:set var="city" value="daegu"/>
    <c:set var="num" value="${lodging.lodgingNo - 8}"/>
  </c:when>
  <c:when test="${lodging.lodgingNo <= 16}">
    <c:set var="city" value="gwangju"/>
    <c:set var="num" value="${lodging.lodgingNo - 12}"/>
  </c:when>
  <c:otherwise>
    <c:set var="city" value="jeju"/>
    <c:set var="num" value="${lodging.lodgingNo - 16}"/>
  </c:otherwise>
</c:choose>
<c:set var="imgnum" value="${num lt 10 ? '0' : ''}${num}" />

<!-- 숙소이미지 보여주는 공간 -->
<section style="margin-top : 80px">
  <div class="container">
    <div class="row g-2">
      <div class="col-lg-8 col-md-8 col-12">
        <img src="/yedambnb/image/${city}_img/${city}${imgnum}_0.jpeg" class="img-fluid rounded w-100" alt="대표사진">
      </div>
      <div class="col-lg-4 col-md-4 col-12 d-flex flex-column justify-content-between">
        <c:forEach var="i" begin="1" end="2">
          <img src="/yedambnb/image/${city}_img/${city}${imgnum}_${i}.jpeg"
               class="img-fluid rounded mb-2"
               style="height:49%; object-fit:cover;"
               alt="서브${i}">
        </c:forEach>
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
            <h5 class="text-primary" id="pricePerNight">${lodging.pricePerNight }</h5>1박
            <p class="text-black-50">${lodging.description}</p>
          </div>
          </div>
          </div>
          </div>
          </div>
          </div>
<!--  숙소제목, 위치, 설명 -->

<!-- 지도 -->
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e8a31d0d96330d4676d7c932270aa001"></script>
<script>

let lat = ${lodging.lat}
let lng = ${lodging.lng}

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(lat, lng), // 지도의 중심좌표
        level: 4 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(64, 69), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
      
// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(lat, lng); // 마커가 표시될 위치입니다
  

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition, 
    image: markerImage // 마커이미지 설정 
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);  
</script>
<!-- 지도 -->

          
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
<script src="js/reserve.js"></script>