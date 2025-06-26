<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="hero">
	<div class="hero-slide">
		<div class="img overlay"
			style="background-image: url('images/hero_bg_3.jpg')"></div>
		<div class="img overlay"
			style="background-image: url('images/hero_bg_2.jpg')"></div>
		<div class="img overlay"
			style="background-image: url('images/hero_bg_1.jpg')"></div>
	</div>

	<div class="container">
		<div class="row justify-content-center align-items-center">
			<div class="col-lg-9 text-center">

				<h1 class="heading" data-aos="fade-up">어디로 떠나실 계획이신가요?</h1>

				<form action="bnbList.do" method="get"
					class="narrow-w form-search mb-3" data-aos="fade-up"
					data-aos-delay="200">
					<div class="input-group">
						<input type="text" name="keyword" class="form-control px-4"
							placeholder="도시 또는 지역으로 검색" aria-label="Search"
							aria-describedby="search-button" />
						<button class="btn btn-primary" type="submit" id="search-button">
							<span class="icon-search"></span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>