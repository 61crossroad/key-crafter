<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<div class="row mt-lg">
				<div class="col-lg-8 col-md-8">
					<h3 class="mb-30 title_color">회원 가입</h3>
					<form action="/member/insert" method="post">
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user" aria-hidden="true"></i>
							</div>
							<input type="text" name="id" id="id" placeholder="아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'"
							 required class="single-input" maxlength="12">
						</div>
						<div class="mt-10 ml-20">
							3 ~ 12 글자로 영어 소문자와 숫자만 가능합니다.
							<!-- <span class="idCheck font-danger">test</span> -->
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="password" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'"
							 required class="single-input" maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="rePassword" placeholder="비밀번호 확인" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'"
							 required class="single-input" maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user-md" aria-hidden="true"></i>
							</div>
							<input type="text" name="name" placeholder="이름" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'"
							 required class="single-input" maxlength="30">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-envelope-o" aria-hidden="true"></i>
							</div>
							<input type="email" name="email" placeholder="이메일" onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일'"
							 required class="single-input" maxlength="40">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-phone" aria-hidden="true"></i>
							</div>
							<input type="text" name="contact" placeholder="전화번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '전화번호'"
							 required class="single-input" maxlength="20">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i>
							</div>
							<input type="text" name="address" placeholder="주소" onfocus="this.placeholder = ''" onblur="this.placeholder = '주소'"
							 required class="single-input" maxlength="100">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-plane" aria-hidden="true"></i>
							</div>
							<input type="text" name="zipCode" placeholder="우편번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '우편번호'"
							 required class="single-input" maxlength="10">
						</div>
						<div class="mt-10">
							<input type="submit" class="genric-btn info" value="가입하기">
						</div>
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$("#id").on("change", function() {
		var id = $("#id").val();
		var regExpId = /^[a-z0-9+]*$/;
		
		if (regExpId.test(id)) {
			alert("3 ~ 12 글자로 입력해주세요.");
			$("#id").focus();
			return;
		}
		
		$.ajax({
			url: "/member/checkId/" + id,
			type: "GET",
			success: function(result) {
				if (result == id) {
					alert("이미 존재하는 아이디입니다.");
				}
				
				$("#id").focus();
			}
		});
	});
});
</script>

<%@ include file="../include/footer.jsp"%>