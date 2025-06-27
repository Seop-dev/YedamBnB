<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<form action="lodgingList.do" method="post">
<input type="hidden" name="lodging_no" value="${lodging.lodgingNo}">
<!-- 사진영역 -->
<div class="section">
      <div class="container">
        <div class="row justify-content-between">
          <div class="col-lg-7">
            <div class="img-property-slide-wrap">
              <div class="img-property-slide">
                <img src="../../image/seoul_img/seoul01_1.jpeg" alt="Image" class="img-fluid" />
                <img src="images/img_2.jpg" alt="Image" class="img-fluid" />
                <img src="images/img_3.jpg" alt="Image" class="img-fluid" />
              </div>
            </div>
          </div>
<!-- 사진영역 -->

<!--  -->
          <div class="col-lg-4">
            <h2 class="heading text-primary">5232 California Ave. 21BC</h2>
            <p class="meta">California, United States</p>
            <p class="text-black-50">
              Lorem ipsum dolor sit amet consectetur, adipisicing elit. Ratione
              laborum quo quos omnis sed magnam id, ducimus saepe, debitis error
              earum, iste dicta odio est sint dolorem magni animi tenetur.
            </p>
            <p class="text-black-50">
              Perferendis eligendi reprehenderit, assumenda molestias nisi eius
              iste reiciendis porro tenetur in, repudiandae amet libero.
              Doloremque, reprehenderit cupiditate error laudantium qui, esse
              quam debitis, eum cumque perferendis, illum harum expedita.
            </p>
<!-- 예약/결제 폼 영역 -->
        <div class="card p-4 mb-4 shadow-sm">
          <h5 class="mb-3">숙소 예약하기</h5>
          <div class="mb-3">
            <label for="checkin" class="form-label">체크인</label>
            <input type="date" class="form-control" id="checkin" name="checkin" required>
          </div>
          <div class="mb-3">
            <label for="checkout" class="form-label">체크아웃</label>
            <input type="date" class="form-control" id="checkout" name="checkout" required>
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
          <button type="submit" class="btn btn-primary w-100">결제하기</button>
        </div>
        <!-- // 예약/결제 폼 영역 -->
            <div class="d-block agent-box p-5">
              <div class="img mb-4">
                <img
                  src="images/person_2-min.jpg"
                  alt="Image"
                  class="img-fluid"
                />
              </div>
              <div class="text">
                <h3 class="mb-0">Alicia Huston</h3>
                <div class="meta mb-3">Real Estate</div>
                <p>
                  Lorem ipsum dolor sit amet consectetur adipisicing elit.
                  Ratione laborum quo quos omnis sed magnam id ducimus saepe
                </p>
                <ul class="list-unstyled social dark-hover d-flex">
                  <li class="me-1">
                    <a href="#"><span class="icon-instagram"></span></a>
                  </li>
                  <li class="me-1">
                    <a href="#"><span class="icon-twitter"></span></a>
                  </li>
                  <li class="me-1">
                    <a href="#"><span class="icon-facebook"></span></a>
                  </li>
                  <li class="me-1">
                    <a href="#"><span class="icon-linkedin"></span></a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
</form>