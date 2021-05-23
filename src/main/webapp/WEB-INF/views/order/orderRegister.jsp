<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../include/header.jsp" %>

<!--================Checkout Area =================-->
<section class="checkout_area section_gap mt-lg">
	<div class="container">
		<div class="billing_details">
			<div class="row">
				<div class="col-lg-7">
					<h3>주문 정보</h3>
					<input type="checkbox" id="member_info" name="member_info">
					<label for="member_info">회원 정보와 동일</label>
					<div class="principal"
						data-name='<sec:authentication property="principal.member.name"/>'
						data-contact='<sec:authentication property="principal.member.contact"/>'
						data-email='<sec:authentication property="principal.member.email"/>'
						data-address='<sec:authentication property="principal.member.address"/>'
						data-zipcode='<sec:authentication property="principal.member.zipCode"/>'>
					</div>
					<form class="row contact_form" action="/order/insert" method="post" role="form">
						<div class="col-md-6 form-group p_star">
							<label for="name">이름</label>
							<input type="text" class="form-control" id="name" name="name" placeholder="이름" maxlength="15" required>
						</div>
						<div class="col-md-6 form-group">
						</div>
						<div class="col-md-6 form-group p_star">
							<label for="contact">연락처</label>
							<input type="text" class="form-control" id="contact" name="contact" placeholder="연락처" maxlength="15" required>
						</div>
						<div class="col-md-6 form-group p_star">
							<label for="email">이메일</label>
							<input type="text" class="form-control" id="email" name="email" placeholder="이메일" maxlength="30" required>
						</div>
						<div class="col-md-12 form-group p_star">
							<label for="address">주소</label>
							<input type="text" class="form-control" id="address" name="address" placeholder="주소" maxlength="90" required>
						</div>
						<div class="col-md-6 form-group p_star">
							<label for="zipCode">우편번호</label>
							<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="우편번호" maxlength="10" required>
						</div>
						<div class="col-md-6 form-group">
						</div>
						<div class="col-md-12 form-group">
							<div class="creat_account">
								<h3>배송 메시지</h3>
							</div>
							<input type="text" class="form-control" id="note" name="note" placeholder="전달 사항을 적어주세요" maxlength="100">
						</div>
						
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						<input type="hidden" name="id" value='<sec:authentication property="principal.member.id"/>'>
						
					<c:forEach items="${ productList }" var="product" varStatus="i">
						<input type="hidden" name="productList[${ i.index }].pid" value="${ product.pid }">
						<input type="hidden" name="productList[${ i.index }].pname" value="${ product.pname }">
						<input type="hidden" name="productList[${ i.index }].company" value="${ product.company }">
						<input type="hidden" name="productList[${ i.index }].price" value="${ product.price }">
						<input type="hidden" name="productList[${ i.index }].quantity" value="${ product.quantity }">
					</c:forEach>
					</form>
				</div>
				<div class="col-lg-5">
					<div class="order_box">
						<h2>결제 정보</h2>
						<ul class="list">
							<li>
								<a href="#" style="font-weight: 500;">상품
									<span>합계</span>
								</a>
							</li>
						<c:set var="subTotal" value="0"/>
						<c:forEach items="${ productList }" var="product">
							<li>
								<a href="#">[${ product.company }]&nbsp;${ product.pname }
									<span class="last">
										<fmt:formatNumber value="${ product.price * product.quantity }" pattern="#,###" />원
									</span>
									<span class="middle">x ${ product.quantity }</span>
								</a>
							</li>
							<c:set var="subTotal" value="${ subTotal + product.price * product.quantity }"/>
						</c:forEach>
						</ul>
						<ul class="list list_2">
							<li>
								<a href="#">소계
									<span>
										<fmt:formatNumber value="${ subTotal }" pattern="#,###" />원
									</span>
								</a>
							</li>
							<li>
								<a href="#">배송비
									<span>택배: 2,500원</span>
								</a>
							</li>
							<li class="price" data-price="${ subTotal + 2500 }">
								<a href="#">전체 금액
									<span><fmt:formatNumber value="${ subTotal + 2500 }" pattern="#,###" />원</span>
								</a>
							</li>
						</ul>
						<div class="payment_item">
							<div class="radion_btn">
								<input type="radio" id="accountTransfer" name="payMethod" value="AT">
								<label for="accountTransfer">계좌이체</label>
								<div class="check"></div>
							</div>
							<p>PG API 설치</p>
						</div>
						<div class="payment_item">
							<div class="radion_btn">
								<input type="radio" id="creditCard" name="payMethod" value="CC">
								<label for="creditCard">카드결제</label>
								<img src="/resources/img/product/single-product/card.jpg" alt="">
								<div class="check"></div>
							</div>
							<p>PG API 설치</p>
						</div>
						<div class="row justify-content-center">
							<a class="null_btn" href="/">주문 취소</a>&nbsp;
							<a class="main_btn" href="#">주문 완료</a>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Checkout Area =================-->
<script type="text/javascript">
$(document).ready(function() {
	var regExpEmail = /^[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*@[a-zA-Z0-9]([-_.]?[a-zA-Z0-9])*\.[a-zA-Z]{2,3}$/;
	var regExpNum = /^[0-9]*$/;
	
	$("#member_info").on("change", function(event) {
		if ($(this).is(":checked") == true) {
			$("form div #name").val($(".principal").data("name"));
			$("form div #contact").val($(".principal").data("contact"));
			$("form div #email").val($(".principal").data("email"));
			$("form div #address").val($(".principal").data("address"));
			$("form div #zipCode").val($(".principal").data("zipcode"));
		}
		else {
			$("form div input").val("");
		}
	});
	
	$(".main_btn").on("click", function(event) {
		event.preventDefault();
		var payMethod = $("input[name='payMethod']:checked").val();
		var name = $("#name").val();
		var contact = $("#contact").val();
		var email = $("#email").val();
		var address = $("#address").val();
		var zipCode = $("#zipCode").val();
		
		// console.log(name);
		
		if (payMethod == undefined) {
			alert("결제를 진행해주세요.");
		}
		
		else if (name == undefined || name == null || name == "") {
			alert("이름을 입력하세요.");
		}
		
		else if (contact == undefined || contact == null || contact == "") {
			alert("연락처를 입력하세요.");
		}
		
		else if (!regExpNum.test(contact)) {
			alert("숫자만 입력할 수 있습니다.");
		}
		
		else if (email == undefined || email == null || email == "") {
			alert("이메일을 입력하세요.");
		}
		
		else if (!regExpEmail.test(email)) {
			alert("이메일 형식에 맞지 않습니다.");
		}
		
		else if (address == undefined || address == null || address == "") {
			alert("주소를 입력하세요.");
		}
		
		else if (zipCode == undefined || zipCode == null || zipCode == "") {
			alert("우편번호를 입력하세요.");
		}
		
		else if (!regExpNum.test(zipCode)) {
			alert("숫자만 입력할 수 있습니다.");
		}
		
		else {
			var payOwner, payNum, payProvider, status;
			
			if (payMethod == "CC") {
				payOwner = "PG_입금자";
				payNum = "PG_카드번호";
				payProvider = "PG_입금 카드업체";
				status = 2;
			}
			else if (payMethod == "AT") {
				payOwner = "PG_업체 계좌명";
				payNum = "PG_계좌번호";
				payProvider = "PG_업체 계좌 은행";
				status = 1;
			}
			
			var str = "<input type='hidden' name='price' value='" + $(".price").data("price") + "'>"; 
			str += "<input type='hidden' name='payMethod' value='" + payMethod + "'>"
				+ "<input type='hidden' name='payOwner' value='" + payOwner + "'>"
				+ "<input type='hidden' name='payNum' value='" + payNum + "'>"
				+ "<input type='hidden' name='payProvider' value='" + payProvider + "'>"
				+ "<input type='hidden' name='status' value='" + status + "'>";
			
			var formObj = $("form[role='form']");
			history.replaceState({}, null, "/cart/list");
			formObj.append(str).submit();
		}
	});
});
</script>
<%@ include file="../include/footer.jsp" %>