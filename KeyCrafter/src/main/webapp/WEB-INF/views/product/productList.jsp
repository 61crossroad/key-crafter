<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/modal.jsp" %>

<!--================Category Product Area =================-->
<section class="cat_product_area mt-xl">
	<div class="container-fluid">
		<div class="row flex-row-reverse">
			<div class="col-lg-9">
				<div class="product_top_bar">
					<div class="left_dorp">
						<select class="sorting">
							<option value="1">Default sorting</option>
							<option value="2">Default sorting 01</option>
							<option value="4">Default sorting 02</option>
						</select>
						<select class="show">
							<option value="1">Show 12</option>
							<option value="2">Show 14</option>
							<option value="4">Show 16</option>
						</select>
					</div>
					<div class="right_page ml-auto">
						<a href="/product/register">
							<button type="button" class="btn btn-primary">상품 등록</button>
						</a>
					</div>
					<div class="right_page ml-auto">
						<nav class="cat_page" aria-label="Page navigation example">
							<ul class="pagination">
								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fa fa-long-arrow-left" aria-hidden="true"></i>
									</a>
								</li>
								<li class="page-item active">
									<a class="page-link" href="#">1</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">2</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">3</a>
								</li>
								<li class="page-item blank">
									<a class="page-link" href="#">...</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">6</a>
								</li>
								<li class="page-item">
									<a class="page-link" href="#">
										<i class="fa fa-long-arrow-right" aria-hidden="true"></i>
									</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
				<div class="latest_product_inner row">
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-1.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-2.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-3.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-4.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-5.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-4.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-3.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<img class="img-fluid" src="/resources/img/product/feature-product/f-p-4.jpg" alt="">
								<div class="p_icon">
									<a href="#">
										<i class="lnr lnr-heart"></i>
									</a>
									<a href="#">
										<i class="lnr lnr-cart"></i>
									</a>
								</div>
							</div>
							<a href="#">
								<h4>Long Sleeve TShirt</h4>
							</a>
							<h5>$150.00</h5>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-3">
			<%@ include file="../category/categoryList.jsp" %>
				<!--
				<div class="left_sidebar_area">
					<aside class="left_widgets cat_widgets">
						<div class="l_w_title col">
							<h3>카테고리
								<a href="#" style="float: right;">
									<button class="btn btn-primary">추가</button>
								</a>
							</h3>
						</div>
						<div class="widgets_inner">
							<ul class="list">
								<li>
									<a href="#">Fruits and Vegetables</a>
								</li>
								<li>
									<a href="#">Meat and Fish</a>
									<ul class="list">
										<li>
											<a href="#">Frozen Fish</a>
										</li>
										<li>
											<a href="#">Dried Fish</a>
										</li>
										<li>
											<a href="#">Fresh Fish</a>
										</li>
										<li>
											<a href="#">Meat Alternatives</a>
										</li>
										<li>
											<a href="#">Meat</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="#">Cooking</a>
									<ul class="list">
										<li>
											<a href="#">Frozen Fish</a>
										</li>
										<li>
											<a href="#">Dried Fish</a>
										</li>
										<li>
											<a href="#">Fresh Fish</a>
										</li>
										<li>
											<a href="#">Meat Alternatives</a>
										</li>
										<li>
											<a href="#">Meat</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="#">Beverages</a>
									<ul class="list">
										<li>
											<a href="#">Frozen Fish</a>
										</li>
										<li>
											<a href="#">Dried Fish</a>
										</li>
										<li>
											<a href="#">Fresh Fish</a>
										</li>
										<li>
											<a href="#">Meat Alternatives</a>
										</li>
										<li>
											<a href="#">Meat</a>
										</li>
									</ul>
								</li>
								<li>
									<a href="#">Home and Cleaning</a>
								</li>
							</ul>
						</div>
					</aside>
					<aside class="left_widgets p_filter_widgets">
						<div class="l_w_title">
							<h3>필터링</h3>
						</div>
						<div class="widgets_inner">
							<h4>Brand</h4>
							<ul class="list">
								<li>
									<a href="#">Apple</a>
								</li>
								<li>
									<a href="#">Asus</a>
								</li>
								<li class="active">
									<a href="#">Gionee</a>
								</li>
								<li>
									<a href="#">Micromax</a>
								</li>
								<li>
									<a href="#">Samsung</a>
								</li>
							</ul>
						</div>
						<div class="widgets_inner">
							<h4>Color</h4>
							<ul class="list">
								<li>
									<a href="#">Black</a>
								</li>
								<li>
									<a href="#">Black Leather</a>
								</li>
								<li class="active">
									<a href="#">Black with red</a>
								</li>
								<li>
									<a href="#">Gold</a>
								</li>
								<li>
									<a href="#">Spacegrey</a>
								</li>
							</ul>
						</div>
						<div class="widgets_inner">
							<h4>Price</h4>
							<div class="range_item">
								<div id="slider-range"></div>
								<div class="row m0">
									<label for="amount">Price : </label>
									<input type="text" id="amount" readonly>
								</div>
							</div>
						</div>
					</aside>
				</div>
				-->
			</div>
		</div>

		<div class="row mb-60">
			<nav class="cat_page mx-auto" aria-label="Page navigation example">
				<ul class="pagination">
					<li class="page-item">
						<a class="page-link" href="#">
							<i class="fa fa-chevron-left" aria-hidden="true"></i>
						</a>
					</li>
					<li class="page-item active">
						<a class="page-link" href="#">01</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">02</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">03</a>
					</li>
					<li class="page-item blank">
						<a class="page-link" href="#">...</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">09</a>
					</li>
					<li class="page-item">
						<a class="page-link" href="#">
							<i class="fa fa-chevron-right" aria-hidden="true"></i>
						</a>
					</li>
				</ul>
			</nav>
		</div>
	</div>
</section>
<!--================End Category Product Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var resultPid = '<c:out value="${result}"/>';
	
	toggleModal(resultPid);
	
	function toggleModal(result) {
		console.log("resultPid: " + result);
		if (result > 0) {
			$("#resultCenter .modal-body").html(parseInt(result) + "번 상품이 등록되었습니다.");
			$("#resultCenter").modal("show");
		}
		else {
			return;
		}
	}
});
</script>
	
<%@ include file="../include/footer.jsp" %>