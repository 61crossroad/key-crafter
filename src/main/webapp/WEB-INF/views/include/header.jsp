<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" href="/resources/img/favicon.png" type="image/png">
	<title>Key Crafter</title>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="/resources/css/bootstrap.css">
	<link rel="stylesheet" href="/resources/vendors/linericon/style.css">
	<link rel="stylesheet" href="/resources/css/font-awesome.min.css">
	<link rel="stylesheet" href="/resources/vendors/owl-carousel/owl.carousel.min.css">
	<link rel="stylesheet" href="/resources/vendors/lightbox/simpleLightbox.css">
	<link rel="stylesheet" href="/resources/vendors/nice-select/css/nice-select.css">
	<link rel="stylesheet" href="/resources/vendors/animate-css/animate.css">
	<link rel="stylesheet" href="/resources/vendors/jquery-ui/jquery-ui.css">
	<!-- main css -->
	<link rel="stylesheet" href="/resources/css/style.css">
	<link rel="stylesheet" href="/resources/css/responsive.css">
</head>

<body>

	<!--================Header Menu Area =================-->
	<header class="header_area">
		<div class="main_menu">
			<nav class="navbar navbar-expand-lg navbar-light">
				<div class="container-fluid">
					<!-- Brand and toggle get grouped for better mobile display -->
					<a class="navbar-brand logo_h" href="/">
						<img src="/resources/img/logo.png" alt="" height="40px">
					</a>
					<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
					 aria-expanded="false" aria-label="Toggle navigation">
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse offset" id="navbarSupportedContent">
						<div class="row w-100">
							<div class="col-lg-7 pr-0">
								<ul class="nav navbar-nav center_nav pull-right">
									<li class="nav-item submenu dropdown">
										<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">키보드</a>
										<ul class="dropdown-menu">
											<li class="nav-item">
												<a class="nav-link" href="/product/list?cat=2">모든 키보드</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?type=C&keyword=HHKB">HHKB</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?type=C&keyword=레오폴드">레오폴드</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?type=C&keyword=바밀로">바밀로</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?type=C&keyword=키크론">키크론</a>
											</li>
										</ul>
									</li>
									<li class="nav-item submenu dropdown">
										<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">악세사리</a>
										<ul class="dropdown-menu">
											<li class="nav-item">
												<a class="nav-link" href="/product/list?cat=3">모든 키캡</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?cat=10">Cherry 키캡</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?cat=11">OEM 키캡</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="/product/list?cat=12">DSA 키캡</a>
											</li>
										</ul>
									</li>
									
									<!--
									<li class="nav-item submenu dropdown">
										<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">고객지원</a>
										<ul class="dropdown-menu">
											<li class="nav-item">
												<a class="nav-link" href="category.html">공지사항</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="single-product.html">문의하기</a>
											</li>
										</ul>
									</li>
									-->
									
									<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
										<li class="nav-item submenu dropdown">
											<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">관리/설정</a>
											<ul class="dropdown-menu">
												<li class="nav-item">
													<a class="nav-link" href="/category/modify">카테고리</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="/product/list?cat=1">전체상품</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="/product/register">상품등록</a>
												</li>
											<sec:authorize access="hasRole('ROLE_ADMIN')">
												<li class="nav-item">
													<a class="nav-link" href="/member/list">회원관리</a>
												</li>
											</sec:authorize>
												<li class="nav-item">
													<a class="nav-link" href="/order/list">주문관리</a>
												</li>
											</ul>
										</li>
									</sec:authorize>
									
									<!-- 
									<sec:authorize access="hasRole('ROLE_ADMIN')">
										<li class="nav-item submenu dropdown">
											<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">회원관리</a>
											<ul class="dropdown-menu">
												<li class="nav-item">
													<a class="nav-link" href="category.html">공지사항</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="single-product.html">문의하기</a>
												</li>
											</ul>
										</li>
									</sec:authorize>
									-->
								</ul>
							</div>

							<div class="col-lg-5">
								<ul class="nav navbar-nav navbar-right right_nav pull-right">
									<hr>
									<li class="nav-item">
										<a href="#" class="icons" id="showSearch">
											<i class="fa fa-search" aria-hidden="true"></i>
										</a>
									</li>

									<hr>

									<li class="nav-item submenu dropdown">
										<sec:authorize access="isAnonymous()">
											<a href="/member/login" class="icons">
												<i class="fa fa-user" aria-hidden="true"></i>
											</a>	
										</sec:authorize>
										
										<sec:authorize access="isAuthenticated()">
											<a href="#" class="dropdown-toggle icons" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
												<i class="fa fa-user" aria-hidden="true"></i>
											</a>
											<ul class="dropdown-menu">
												<li class="nav-item">
													<a class="nav-link" href="/member/info">내 정보</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="/order/list?type=I&keyword=<sec:authentication property='principal.member.id'/>">주문내역</a>
												</li>
												<li class="nav-item">
													<a id="logoutBtn" class="nav-link" href="#">로그아웃</a>
												</li>
											</ul>
										</sec:authorize>
									</li>

									<hr>

									<li class="nav-item">
										<a href="/cart/list" class="icons">
											<i class="lnr lnr lnr-cart"></i>
										</a>
									</li>

									<hr>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</nav>
		</div>
	</header>
	<!--================End Header Menu Area =================-->
	
	<!--==================Search Modal ===================-->
	<div class="modal" id="searchModal" tabindex="-1" role="dialog">
	  <div class="modal-dialog modal-lg">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">상품 검색</h5>
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	          <span aria-hidden="true">&times;</span>
	        </button>
	      </div>
	      <div class="modal-body">
	      	<form id="searchForm" action="/product/list" method="GET">
	      		<div class="input-group mb-3">
					<input type="text" class="form-control" id="keyword" name="keyword">
					<input type="hidden" name="type" value="CDGP">
					<div class="input-group-append">
					  <button class="btn btn-outline-secondary" type="submit" id="searchBtn">
					  	<i class="fa fa-search" aria-hidden="true"></i>
					  </button>
					</div>
				</div>
			</form>
	      </div>
	    </div>
	  </div>
	</div>
	<!--==================End Search Modal ===================-->
	
	<script src="/resources/js/jquery-3.2.1.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			$("#logoutBtn").on("click", function(event) {
				event.preventDefault();
				
				$.ajax({
					url: '/member/logout',
					type: 'post',
					beforeSend: function(xhr) {
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
					},
					success: function(result) {
						window.location.href="/";
					}
				});
			});
			
			$("#showSearch").on("click", function(event) {
				event.preventDefault();
				$("#searchModal").modal("show");
			});
			
			$("#searchBtn").on("click", function(event) {
				event.preventDefault();
				
				var keyword = $("#keyword").val();
				
				if (keyword == null || keyword == "") {
					$("#searchModal").modal("hide");
				}
				$("#searchForm").submit();
			});
		});
	</script>