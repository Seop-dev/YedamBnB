<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="section">
  <div class="container">
    <div class="row mb-5 align-items-center">
      <div class="col-lg-6">
        <%-- 검색어가 있을 때와 없을 때 제목을 다르게 표시 --%>
        <c:if test="${not empty keyword}">
          <h2 class="font-weight-bold text-primary heading">'${keyword}' 검색 결과</h2>
        </c:if>
        <c:if test="${empty keyword}">
          <h2 class="font-weight-bold text-primary heading">전체 숙소 목록</h2>
        </c:if>
      </div>
      <div class="col-lg-6 text-lg-end">
        <%-- 이 버튼은 필요에 따라 다른 기능으로 활용 가능 --%>
        <p>
          <a href="#" target="_blank" class="btn btn-primary text-white py-3 px-4">View all properties</a>
        </p>
      </div>
    </div>

    <%-- 검색 결과가 없을 경우 메시지 표시 --%>
    <c:if test="${empty bnbList}">
      <div class="alert alert-warning" role="alert">
        '${keyword}'에 대한 검색 결과가 없습니다.
      </div>
    </c:if>

    <%-- 검색 결과가 있을 경우, 반복문으로 목록 표시 --%>
    <div class="row">
      <div class="col-12">
        <div class="property-slider-wrap">
          <div class="property-slider">

            <c:forEach var="bnb" items="${bnbList}">
              <div class="property-item">
                <a href="property-single.html" class="img">
                  <%-- 이미지는 나중에 DB에서 가져올 수 있도록 일단 고정 --%>
                  <img src="images/img_1.jpg" alt="Image" class="img-fluid" />
                </a>

                <div class="property-content">
                  <div class="price mb-2"><span>${bnb.price}원 / 박</span></div>
                  <div>
                    <span class="d-block mb-2 text-black-50">${bnb.lodgingName}</span>
                    <span class="city d-block mb-3">${bnb.lodgingAddress}</span>

                    <div class="specs d-flex mb-4">
                      <span class="d-block d-flex align-items-center me-3">
                        <span class="icon-bed me-2"></span>
                        <span class="caption">2 beds</span>
                      </span>
                      <span class="d-block d-flex align-items-center">
                        <span class="icon-bath me-2"></span>
                        <span class="caption">2 baths</span>
                      </span>
                    </div>

                    <a href="property-single.html" class="btn btn-primary py-2 px-3">상세보기</a>
                  </div>
                </div>
              </div>
              </c:forEach>

          </div>

          <div id="property-nav" class="controls" tabindex="0" aria-label="Carousel Navigation">
            <span class="prev" data-controls="prev" aria-controls="property" tabindex="-1">Prev</span>
            <span class="next" data-controls="next" aria-controls="property" tabindex="-1">Next</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>