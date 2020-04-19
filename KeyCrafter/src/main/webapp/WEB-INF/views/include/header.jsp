<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<!DOCTYPE html>
<html lang="en">

<head>
	<!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<link rel="icon" href="img/favicon.png" type="image/png">
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
												<a class="nav-link" href="category.html">HHKB</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="single-product.html">바밀로</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="checkout.html">키크론</a>
											</li>
										</ul>
									</li>
									<li class="nav-item submenu dropdown">
										<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">악세사리</a>
										<ul class="dropdown-menu">
											<li class="nav-item">
												<a class="nav-link" href="category.html">Cherry 키캡</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="single-product.html">OEM 키캡</a>
											</li>
											<li class="nav-item">
												<a class="nav-link" href="checkout.html">포인트 키캡</a>
											</li>
										</ul>
									</li>
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
									
									<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
										<li class="nav-item submenu dropdown">
											<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">상품관리</a>
											<ul class="dropdown-menu">
												<li class="nav-item">
													<a class="nav-link" href="/product/list">목록</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="/product/register">등록</a>
												</li>
												<li class="nav-item">
													<a class="nav-link" href="single-product.html">수정/삭제</a>
												</li>
											</ul>
										</li>
									</sec:authorize>
									
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
									
								</ul>
							</div>

							<div class="col-lg-5">
								<ul class="nav navbar-nav navbar-right right_nav pull-right">
									<hr>
									<li class="nav-item">
										<a href="#" class="icons">
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
													<a class="nav-link" href="/member/order">주문내역</a>
												</li>
												<li class="nav-item">
													<input type="button" value="로그아웃" id="logoutBtn" class="nav-link logout" style="border: none; width: 100%; text-align: left;">
													<!--
													<form action="/member/logout" method="post">
														<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
														<input class="nav-link logout" type="submit" value="로그아웃" style="border: none; width: 100%; text-align: left;">
													</form>
													-->
												</li>
											</ul>
										</sec:authorize>
									</li>

									<hr>

									<li class="nav-item">
										<a href="#" class="icons">
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
	
	<script src="/resources/js/jquery-3.2.1.min.js"></script>
	
	<script type="text/javascript">
		$(document).ready(function() {
			var csrfHeaderName = "${_csrf.headerName}";
			var csrfTokenValue = "${_csrf.token}";
			
			$("#logoutBtn").on("click", function() {
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
		});
	</script>

	<!--================Header Menu Area =================-->