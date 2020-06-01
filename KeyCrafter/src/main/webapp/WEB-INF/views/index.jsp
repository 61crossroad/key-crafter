<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="include/header.jsp"%>

<!--================Home Banner Slider =================-->
<section class="home_banner_area">
	<div class="overlay"></div>
	<div class="banner_inner d-flex align-items-center row no-gutters">
		<div id="homeBannerCaptions" class="row banner_content carousel slide no-gutters" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#homeBannerCaptions" data-slide-to="0" class="active"></li>
				<li data-target="#homeBannerCaptions" data-slide-to="1"></li>
				<li data-target="#homeBannerCaptions" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner h-600">
				<div class="carousel-item active">
					<a href="/product/get?pid=10">					
						<img src="/resources/img/banner/anne-pro-2.png" class="d-block w-100" alt="1st">
					</a>					
					<div class="carousel-caption d-none d-block">
						<a href="/product/get?pid=10">
							<h3>Anne Pro 2</h3>
						</a>
						<h4>Nulla vitae elit libero, a pharetra augue mollis interdum.</h4>
					</div>
				</div>
				<div class="carousel-item">
					<a href="/product/get?pid=11">
						<img src="/resources/img/banner/hhkb02.png" class="d-block w-100" alt="2nd">
					</a>
					<div class="carousel-caption d-none d-block">
						<a href="/product/get?pid=11">
							<h3>HHKB</h3>
						</a>
						<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h4>
					</div>
				</div>
				<div class="carousel-item">
					<a href="/product/get?pid=7">
						<img src="/resources/img/banner/realforce01.png" class="d-block w-100" alt="3rd">
					</a>
					<div class="carousel-caption d-none d-block">
						<a href="/product/get?pid=7">
							<h3>Leopold Realforce R2</h3>
						</a>
						<h4>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--================Feature Product Area =================-->
<section class="feature_product_area section_gap">
	<div class="main_box">
		<div class="container-fluid">
			<div class="row">
				<div class="main_title">
					<h2>New Arrivals</h2>
					<p>신상품을 소개합니다.</p>
				</div>
			</div>
			<div class="row">
				<c:forEach items="${ list }" var="product" varStatus="status">
					<div class="col col${ status.index + 1 }">
						<div class="f_p_item">
							<div class="f_p_img">
								<a class="getProduct" href="/product/get?pid=${ product.pid }">
									<img class="img-fluid"
										src="/show?fileName=${ product.attachList[0].uploadPath }/m_${ product.attachList[0].uuid }_${ product.attachList[0].fileName }"
										alt="${ product.pname }">
								</a>
							</div>
							<a class="getProduct" href="/product/get?pid=${ product.pid }">
								<h4>${ product.pname }</h4>
							</a>
							<h5><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</h5>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<%@ include file="include/footer.jsp"%>