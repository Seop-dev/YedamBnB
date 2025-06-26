<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- ========================================================= --%>
<%--                메인 페이지 본문 (Body) 시작                 --%>
<%-- ========================================================= --%>

<div class="hero">
  <div class="hero-slide">
    <div
      class="img overlay"
      style="background-image: url('images/hero_bg_3.jpg')"
    ></div>
    <div
      class="img overlay"
      style="background-image: url('images/hero_bg_2.jpg')"
    ></div>
    <div
      class="img overlay"
      style="background-image: url('images/hero_bg_1.jpg')"
    ></div>
  </div>

  <div class="container">
    <div class="row justify-content-center align-items-center">
      <div class="col-lg-9 text-center">
        
        
        <h1 class="heading" data-aos="fade-up">
          어디로 떠나실 계획이신가요?
        </h1>
        
        <form
          action="#"
          class="narrow-w form-search d-flex align-items-stretch mb-3"
          data-aos="fade-up"
          data-aos-delay="200"
        >
          <%-- ▼▼▼ 수정된 검색창 안내 문구 ▼▼▼ --%>
          <input
            type="text"
            class="form-control px-4"
            placeholder="도시 또는 지역으로 검색"
          />
          <button type="submit" class="btn btn-primary">검색</button>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="section">
  <div class="container">
    <div class="row mb-5 align-items-center">
      <div class="col-lg-6">
        <h2 class="font-weight-bold text-primary heading">
          인기 숙소
        </h2>
      </div>
      <div class="col-lg-6 text-lg-end">
        <p>
          <a
            href="bnbList.do"
            class="btn btn-primary text-white py-3 px-4"
            >모든 숙소 보기</a
          >
        </p>
      </div>
    </div>
    <div class="row">
      <div class="col-12">
        <div class="property-slider-wrap">
          <div class="property-slider">
            <div class="property-item">
              <a href="property-single.html" class="img">
                <img src="images/img_1.jpg" alt="Image" class="img-fluid" />
              </a>

              <div class="property-content">
                <div class="price mb-2"><span>$1,291,000</span></div>
                <div>
                  <span class="d-block mb-2 text-black-50"
                    >5232 California Fake, Ave. 21BC</span
                  >
                  <span class="city d-block mb-3">California, USA</span>

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

                  <a
                    href="property-single.html"
                    class="btn btn-primary py-2 px-3"
                    >See details</a
                  >
                </div>
              </div>
            </div>
            <div class="property-item">
              <a href="property-single.html" class="img">
                <img src="images/img_2.jpg" alt="Image" class="img-fluid" />
              </a>

              <div class="property-content">
                <div class="price mb-2"><span>$1,291,000</span></div>
                <div>
                  <span class="d-block mb-2 text-black-50"
                    >5232 California Fake, Ave. 21BC</span
                  >
                  <span class="city d-block mb-3">California, USA</span>

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

                  <a
                    href="property-single.html"
                    class="btn btn-primary py-2 px-3"
                    >See details</a
                  >
                </div>
              </div>
            </div>
            <div class="property-item">
              <a href="property-single.html" class="img">
                <img src="images/img_3.jpg" alt="Image" class="img-fluid" />
              </a>

              <div class="property-content">
                <div class="price mb-2"><span>$1,291,000</span></div>
                <div>
                  <span class="d-block mb-2 text-black-50"
                    >5232 California Fake, Ave. 21BC</span
                  >
                  <span class="city d-block mb-3">California, USA</span>

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

                  <a
                    href="property-single.html"
                    class="btn btn-primary py-2 px-3"
                    >See details</a
                  >
                </div>
              </div>
            </div>
            <div class="property-item">
              <a href="property-single.html" class="img">
                <img src="images/img_4.jpg" alt="Image" class="img-fluid" />
              </a>

              <div class="property-content">
                <div class="price mb-2"><span>$1,291,000</span></div>
                <div>
                  <span class="d-block mb-2 text-black-50"
                    >5232 California Fake, Ave. 21BC</span
                  >
                  <span class="city d-block mb-3">California, USA</span>

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

                  <a
                    href="property-single.html"
                    class="btn btn-primary py-2 px-3"
                    >See details</a
                  >
                </div>
              </div>
            </div>
            </div>

          <div
            id="property-nav"
            class="controls"
            tabindex="0"
            aria-label="Carousel Navigation"
          >
            <span
              class="prev"
              data-controls="prev"
              aria-controls="property"
              tabindex="-1"
              >Prev</span
            >
            <span
              class="next"
              data-controls="next"
              aria-controls="property"
              tabindex="-1"
              >Next</span
            >
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<section class="features-1">
  <div class="container">
    <div class="row">
      <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="300">
        <div class="box-feature">
          <span class="flaticon-house"></span>
          <h3 class="mb-3">다양한 숙소</h3>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Voluptates, accusamus.
          </p>
          <p><a href="#" class="learn-more">더 알아보기</a></p>
        </div>
      </div>
      <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="500">
        <div class="box-feature">
          <span class="flaticon-building"></span>
          <h3 class="mb-3">합리적인 가격</h3>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Voluptates, accusamus.
          </p>
          <p><a href="#" class="learn-more">더 알아보기</a></p>
        </div>
      </div>
      <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="400">
        <div class="box-feature">
          <span class="flaticon-house-3"></span>
          <h3 class="mb-3">신뢰할 수 있는 호스트</h3>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Voluptates, accusamus.
          </p>
          <p><a href="#" class="learn-more">더 알아보기</a></p>
        </div>
      </div>
      <div class="col-6 col-lg-3" data-aos="fade-up" data-aos-delay="600">
        <div class="box-feature">
          <span class="flaticon-house-1"></span>
          <h3 class="mb-3">안전한 결제</h3>
          <p>
            Lorem ipsum dolor sit amet, consectetur adipisicing elit.
            Voluptates, accusamus.
          </p>
          <p><a href="#" class="learn-more">더 알아보기</a></p>
        </div>
      </div>
    </div>
  </div>
</section>

<div class="section sec-testimonials">
  <div class="container">
    <div class="row mb-5 align-items-center">
      <div class="col-md-6">
        <h2 class="font-weight-bold heading text-primary mb-4 mb-md-0">
          고객 후기
        </h2>
      </div>
      <div class="col-md-6 text-md-end">
        <div id="testimonial-nav">
          <span class="prev" data-controls="prev">Prev</span>

          <span class="next" data-controls="next">Next</span>
        </div>
      </div>
    </div>

    <div class="row">
      <div class="col-lg-4"></div>
    </div>
    <div class="testimonial-slider-wrap">
      <div class="testimonial-slider">
        <div class="item">
          <div class="testimonial">
            <img
              src="images/person_1-min.jpg"
              alt="Image"
              class="img-fluid rounded-circle w-25 mb-4"
            />
            <div class="rate">
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
            </div>
            <h3 class="h5 text-primary mb-4">James Smith</h3>
            <blockquote>
              <p>
                &ldquo;Far far away, behind the word mountains, far from the
                countries Vokalia and Consonantia, there live the blind
                texts. Separated they live in Bookmarksgrove right at the
                coast of the Semantics, a large language ocean.&rdquo;
              </p>
            </blockquote>
            <p class="text-black-50">Designer, Co-founder</p>
          </div>
        </div>

        <div class="item">
          <div class="testimonial">
            <img
              src="images/person_2-min.jpg"
              alt="Image"
              class="img-fluid rounded-circle w-25 mb-4"
            />
            <div class="rate">
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
              <span class="icon-star text-warning"></span>
            </div>
            <h3 class="h5 text-primary mb-4">Mike Houston</h3>
            <blockquote>
              <p>
                &ldquo;Far far away, behind the word mountains, far from the
                countries Vokalia and Consonantia, there live the blind
                texts. Separated they live in Bookmarksgrove right at the
                coast of the Semantics, a large language ocean.&rdquo;
              </p>
            </blockquote>
            <p class="text-black-50">Designer, Co-founder</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>