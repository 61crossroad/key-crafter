<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!--================Pagination & Search parameters =================-->
<form id="pageForm" action="/product/list" method="GET">
	<input type="hidden" name="page" value="${ cri.page }">
	<input type="hidden" name="show" value="${ cri.show }">
	<input type="hidden" name="type" value="${ cri.type }">
	<input type="hidden" name="keyword" value="${ cri.keyword }">
</form>

<!--================Single Product Area =================-->
<div class="product_image_area">
	<div class="container">
		<div class="row s_product_inner">
			<div class="col-lg-6">
				<div class="s_product_img">
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<c:forEach items="${ product.attachList }" var="attach" varStatus="status">
								<li data-target="#carouselExampleIndicators" data-slide-to="${ status.index }"
								${ status.first ? ' class="active"' : '' }>
								
									<img src="/show?fileName=${ attach.uploadPath }/s_${ attach.uuid }_${ attach.fileName }"
									alt="${ product.PName }">
								</li>
							</c:forEach>
						</ol>
						<div class="carousel-inner">
							<c:forEach items="${ product.attachList }" var="attach" varStatus="status">
								<div class="carousel-item${ status.first ? ' active' : '' }">
									<img class="d-block w-100" src="/show?fileName=${ attach.uploadPath }/m_${ attach.uuid }_${ attach.fileName }"
									alt="Slide ${ status.index }">
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-5 offset-lg-1">
				<div class="s_product_text">
					<h3>${ product.PName }</h3>
					<h2><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</h2>
					<ul class="list">
						<li>
							<span>분류</span> : <!-- Household -->
							<c:forEach items="${ product.categoryList }" var="category" varStatus="status">
								${ category.catName }${ status.last ? '' : ',&nbsp;' }
							</c:forEach>
						</li>
						<li>
							<span>제조사</span> : ${ product.company }
						</li>
						<li>
							<span>제조국</span> : ${ product.madeIn }
						</li>
						<li>
							<span>등록일</span> : <fmt:formatDate value="${ product.regDate }" pattern="yyyy.MM.dd"/>
						</li>
						<li>
							<span>수정일</span> : <fmt:formatDate value="${ product.updateDate }" pattern="yyyy.MM.dd"/>
						</li>
					</ul>
					<p></p>
					<div class="product_count">
						<label for="qty">수량:</label>
						<input type="text" name="qty" id="qty" maxlength="12" value="1" title="Quantity:" class="input-text qty">
						<button id="qty-up" class="increase items-count"><i class="lnr lnr-chevron-up"></i></button>
						<button id="qty-dn" class="reduced items-count"><i class="lnr lnr-chevron-down"></i></button>
					</div>
					<div class="card_area">
						<a class="main_btn" href="#">주문하기</a>
						<a class="icon_btn" href="#">
							<i class="lnr lnr lnr-cart"></i>
						</a>
						<a class="icon_btn" href="javascript: window.history.back();">
							<i class="fa fa-undo"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--================End Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">상품 정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">상품 후기</a>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<p>${ product.productDesc }</p>
			</div>
			
			<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
				<div class="row">
					<div class="col-lg-6">
						<div class="comment_list">
							<div class="review_item">
								<div class="media">
									<div class="d-flex">
										<img src="/resources/img/product/single-product/review-1.png" alt="">
									</div>
									<div class="media-body">
										<h4>Blake Ruiz</h4>
										<h5>12th Feb, 2017 at 05:56 pm</h5>
										<a class="reply_btn" href="#">Reply</a>
									</div>
								</div>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
							</div>
							<div class="review_item reply">
								<div class="media">
									<div class="d-flex">
										<img src="/resources/img/product/single-product/review-2.png" alt="">
									</div>
									<div class="media-body">
										<h4>Blake Ruiz</h4>
										<h5>12th Feb, 2017 at 05:56 pm</h5>
										<a class="reply_btn" href="#">Reply</a>
									</div>
								</div>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
							</div>
							<div class="review_item">
								<div class="media">
									<div class="d-flex">
										<img src="/resources/img/product/single-product/review-3.png" alt="">
									</div>
									<div class="media-body">
										<h4>Blake Ruiz</h4>
										<h5>12th Feb, 2017 at 05:56 pm</h5>
										<a class="reply_btn" href="#">Reply</a>
									</div>
								</div>
								<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
									aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
							</div>
						</div>
					</div>
					<div class="col-lg-6">
						<div class="review_box">
							<h4>댓글 달기</h4>
							<form class="row contact_form" action="contact_process.php" method="post" id="contactForm">
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<textarea class="form-control" name="message" id="message" rows="1" placeholder="내용" required></textarea>
									</div>
								</div>
								<div class="col-md-12 text-right">
									<button type="submit" value="submit" class="btn submit_btn">등록</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Product Description Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var qty = $("#qty");
	
	$("#qty-up").on("click", function() {
		var num = qty.val();
		qty.val(++num);
	});
	
	$("#qty-dn").on("click", function() {
		var num = qty.val();
		if (num >= 2) {
			qty.val(--num);
		}
	});
});
</script>

<%@ include file="../include/footer.jsp" %>