<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="../include/header.jsp"%>

<div class="whole-wrap mb-30">
	<div class="container">
		<div class="section-top-border">
			<div class="row mt-lg">
				<div class="col-lg-8 col-md-8">
					<h3 class="mb-30 title_color">회원 정보</h3>
					<form action="/member/update" method="post">
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user" aria-hidden="true"></i>
							</div>
							<input type="text" name="id" id="id" class="single-input"
								value="<sec:authentication property="principal.member.id" />" readonly="readonly">
						</div>
						<div class="mt-10 ml-20">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="password" class="single-input"
							placeholder="비밀번호 수정" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 수정'"
							maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="rePassword" class="single-input"
							placeholder="비밀번호 확인" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'"
							maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user-md" aria-hidden="true"></i>
							</div>
							<input type="text" name="name" class="single-input"
							value="<sec:authentication property="principal.member.name"/>"
							maxlength="30" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-envelope-o" aria-hidden="true"></i>
							</div>
							<input type="email" name="email" placeholder="이메일" class="single-input"
							value="<sec:authentication property="principal.member.email"/>"
							maxlength="40" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-phone" aria-hidden="true"></i>
							</div>
							<input type="text" name="contact" placeholder="전화번호" class="single-input"
							value="<sec:authentication property="principal.member.contact"/>"
							maxlength="20" required >
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i>
							</div>
							<input type="text" name="address" class="single-input"
							value="<sec:authentication property="principal.member.address"/>"
							maxlength="100" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-plane" aria-hidden="true"></i>
							</div>
							<input type="text" name="zipCode" class="single-input"
							value="<sec:authentication property="principal.member.zipCode"/>"
							maxlength="10" required >
						</div>
						<div class="mt-10">
							<input type="submit" class="genric-btn info" value="정보 수정">
						</div>
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>