<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp"%>

<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<div class="row mt-lg">
				<div class="col-lg-8 col-md-8">
					<h3 class="mb-30 title_color">회원 가입</h3>
					<form name="regForm" action="/member/insert" method="post">
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user" aria-hidden="true"></i>
							</div>
							<input type="text" name="id" placeholder="아이디" onfocus="this.placeholder = ''" onblur="this.placeholder = '아이디'"
							 class="single-input" maxlength="12" required>
						</div>
						<div class="mt-10 ml-20 mb-20">
							3 ~ 12 글자로 영어 소문자와 숫자만 가능합니다.
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="password" placeholder="비밀번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호'"
							 class="single-input" maxlength="16" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="rePassword" placeholder="비밀번호 확인" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'"
							 class="single-input" maxlength="16" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user-md" aria-hidden="true"></i>
							</div>
							<input type="text" name="name" placeholder="이름" onfocus="this.placeholder = ''" onblur="this.placeholder = '이름'"
							 class="single-input" maxlength="30" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-envelope-o" aria-hidden="true"></i>
							</div>
							<input type="email" name="email" placeholder="이메일" onfocus="this.placeholder = ''" onblur="this.placeholder = '이메일'"
							 class="single-input" maxlength="40" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-phone" aria-hidden="true"></i>
							</div>
							<input type="text" name="contact" placeholder="전화번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '전화번호'"
							 class="single-input" maxlength="20" required >
						</div>
						<div class="mt-10 ml-20 mb-20">
							숫자만 입력해주세요.
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i>
							</div>
							<input type="text" name="address" placeholder="주소" onfocus="this.placeholder = ''" onblur="this.placeholder = '주소'"
							 class="single-input" maxlength="100" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-plane" aria-hidden="true"></i>
							</div>
							<input type="text" name="zipCode" placeholder="우편번호" onfocus="this.placeholder = ''" onblur="this.placeholder = '우편번호'"
							 class="single-input" maxlength="10" required>
						</div>
						<div class="mt-10 ml-20 mb-20">
							숫자만 입력해주세요.
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
	var csrfHeaderName = "${ _csrf.headerName }";
	var csrfTokenValue = "${ _csrf.token }";
	
	var regExpId = /^[a-z0-9+]{3,12}$/;
	var regExpEmail = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,3}$/;
	var regExpNum = /^[0-9]*$/;
	
	$("input").on("change", function() {
		var inputName = $(this).attr("name");
		var inputVal = $(this).val();
		
		if (inputName == "id") {
			if (!regExpId.test(inputVal)) {
				alert("형식에 맡지 않는 아이디입니다.");
				$(this).focus();
				return;
			}
			
			var member = new Object();
			member.id = inputVal;
			
			$.ajax({
				url: "/member/check",
				type: "POST",
				data: JSON.stringify(member),
				contentType: "application/json;charset=utf-8",
				dataType: "text",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function(result) {
					if (result == "id") {
						alert("이미 존재하는 아이디입니다.");
						$("input[name='id']").focus();
					}
				}
			});
		}
		
		else if (inputName == "password" && inputVal.length < 4) {
			alert("비밀번호는 4글자 이상이어야 합니다.");
			$(this).focus();
		}
		
		else if (inputName == "rePassword") {
			var password = $("input[name='password']").val();
			
			if (inputVal != password) {
				alert("비밀번호가 일치하지 않습니다.");
				$(this).focus();
			}
		}
		
		else if (inputName == "email") {
			if (!regExpEmail.test(inputVal)) {
				alert("이메일 형식에 맞지 않습니다.");
				$(this).focus();
				return;
			}
			
			var member = new Object();
			member.email = inputVal;
			
			$.ajax({
				url: "/member/check",
				type: "POST",
				data: JSON.stringify(member),
				contentType: "application/json;charset=utf-8",
				dataType: "text",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function(result) {
					if (result == "email") {
						alert("이미 존재하는 이메일 주소입니다.");
						$("input[name='email']").focus();
					}
				}
			});
		}
		
		else if (inputName == "contact") {
			if (!regExpNum.test(inputVal)) {
				alert("숫자만 입력해주세요.");
				$(this).focus();
				return;
			}
			
			var member = new Object();
			member.contact = inputVal;
			
			$.ajax({
				url: "/member/check",
				type: "POST",
				data: JSON.stringify(member),
				contentType: "application/json;charset=utf-8",
				dataType: "text",
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function(result) {
					if (result == "contact") {
						alert("이미 존재하는 전화번호입니다.");
						$("input[name='contact']").focus();
					}
				}
			});
		}
		
		else if (inputName == "zipCode" && !regExpNum.test(inputVal)) {
			alert("숫자만 입력해주세요.");
			$(this).focus();
		}
	});
	
	$("input[type='submit']").on("click", function(event) {
		event.preventDefault();
		
		var id = $("input[name='id']");
		var password = $("input[name='password']");
		var rePassword = $("input[name='rePassword']");
		var email = $("input[name='email']");
		var contact = $("input[name='contact']");
		var zipCode = $("input[name='zipCode']");
		
		if (!regExpId.test(id.val())) {
			alert("형식에 맡지 않는 아이디입니다.");
			id.focus();
			return;
		}
		
		else if (password.val() < 4) {
			alert("비밀번호는 4글자 이상이어야 합니다.");
			password.focus();
			return;
		}
		
		else if (rePassword.val() != password.val()) {
			alert("비밀번호가 일치하지 않습니다.");
			rePassword.focus();
			return;
		}
		
		else if (!regExpEmail.test(email.val())) {
			alert("이메일 형식에 맞지 않습니다.");
			email.focus();
			return;
		}
		
		else if (!regExpNum.test(contact.val())) {
			alert("숫자만 입력해주세요.");
			contact.focus();
			return;
		}
		
		else if (!regExpNum.test(zipCode.val())) {
			alert("숫자만 입력해주세요.");
			zipCode.focus();
			return;
		}

		else {
			var member = new Object();
			member.id = id.val();
			member.email = email.val();
			member.contact = contact.val();
			
			checkInfo(member, function(result) {
				$("form[name='regForm']").submit();
			});
		}
	});
	
	function checkInfo(member, callback) {
		$.ajax({
			url: "/member/check",
			type: "POST",
			data: JSON.stringify(member),
			contentType: "application/json;charset=utf-8",
			dataType: "text",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result) {
				if (result == "id") {
					alert("이미 존재하는 아이디입니다.");
					$("input[name='id']").focus();
				}
				
				else if (result == "email") {
					alert("이미 존재하는 이메일 주소입니다.");
					$("input[name='email']").focus();
				}
				
				else if (result == "contact") {
					alert("이미 존재하는 전화번호입니다.");
					$("input[name='contact']").focus();
				}
				
				else if(callback) {
					callback(result);
				}
			}
		});
	}
});
</script>

<%@ include file="../include/footer.jsp"%>