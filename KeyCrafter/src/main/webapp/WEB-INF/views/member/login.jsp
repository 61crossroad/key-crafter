<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp"%>

<!--================Login Box Area =================-->
<section class="login_box_area p_100 mt-sm">
	<div class="container">
		<div class="row">
			<div class="col-lg-6">
				<div class="login_box_img">
					<img class="img-fluid" src="/resources/img/login.jpg" alt="">
					<div class="hover">
						<h4>환영합니다!</h4>
						<p>고객분들의 다양한 취향에 맞춘 고품질 키보드를<br>
						<b>키크래프터</b>에서 만나보세요.
						</p>
						<a class="main_btn" href="/member/register">회원가입</a>
					</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="login_form_inner">
					<h3>로그인</h3>
					<form class="row login_form" action="/login" method="post" id="contactForm" novalidate="novalidate">
						<div class="col-md-12 form-group">
							<input type="text" class="form-control" id="username" name="username" placeholder="아이디" maxlength="12" autofocus>
						</div>
						<div class="col-md-12 form-group font-danger">
							<c:if test="${ error eq 'true' }">
								아이디/비밀번호가 맞지 않습니다
							</c:if>
						</div>
						<div class="col-md-12 form-group">
							<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" maxlength="12">
						</div>
						<div class="col-md-12 form-group">
							<div class="creat_account">
								<input type="checkbox" id="remember-me" name="remember-me">
								<label for="remember-me">자동 로그인</label>
							</div>
						</div>
						<div class="col-md-12 form-group">
							<button type="submit" value="submit" class="btn submit_btn">로그인</button>
							<!-- <a href="#">비밀번호 찾기</a> -->
						</div>
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }"/>
					</form>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Login Box Area =================-->
	
<%@ include file="../include/footer.jsp"%>