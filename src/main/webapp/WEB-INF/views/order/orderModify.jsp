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
					<label for="member_info">회원 정보로 바꾸기</label>
					
					<div class="principal"
						data-name='<sec:authentication property="principal.member.name"/>'
						data-contact='<sec:authentication property="principal.member.contact"/>'
						data-email='<sec:authentication property="principal.member.email"/>'
						data-address='<sec:authentication property="principal.member.address"/>'
						data-zipcode='<sec:authentication property="principal.member.zipCode"/>'>
					</div>
					<form class="row contact_form" action="/order/update" method="post" role="form">
						<div class="col-md-6 form-group p_star">
							<label for="name">이름</label>
							<input type="text" class="form-control" id="name" name="name" placeholder="이름" maxlength="15" 
							value="${ order.name }" required>
						</div>
						<div class="col-md-6 form-group"></div>
						<div class="col-md-6 form-group p_star">
							<label for="contact">연락처</label>
							<input type="text" class="form-control" id="contact" name="contact" placeholder="연락처" maxlength="15"
							value="${ order.contact }" required>
						</div>
						<div class="col-md-6 form-group p_star">
							<label for="email">이메일</label>
							<input type="text" class="form-control" id="email" name="email" placeholder="이메일" maxlength="30"
							value="${ order.email }" required>
						</div>
						<div class="col-md-12 form-group p_star">
							<label for="address">주소</label>
							<input type="text" class="form-control" id="address" name="address" placeholder="주소" maxlength="90"
							value="${ order.address }" required>
						</div>
						<div class="col-md-6 form-group p_star">
							<label for="zipCode">우편번호</label>
							<input type="text" class="form-control" id="zipCode" name="zipCode" placeholder="우편번호" maxlength="10"
							value="${ order.zipCode }" required>
						</div>
						<div class="col-md-6 form-group"></div>
						
					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
						<div class="col-md-6 form-group">
							<label for="status">주문 상태</label><br>
							<select id="status" name="status" class="form-control">
							<c:forEach items="${ statusList }" var="status">
								<option value="${ status.status }" ${ status.status eq order.status ? "selected" : "" }>${ status.message }</option>
							</c:forEach>
							</select>
						</div>
						
						<div class="col-md-6 form-group">
							<label for="trackingNum">운송장 번호</label>
							<input type="text" id="trackingNum" name="trackingNum" class="form-control" value="${ order.trackingNum }">
						</div>
					</sec:authorize>
						
						<div class="col-md-12 form-group">
							<div class="creat_account">
								<h3>배송 메시지</h3>
							</div>
							<input type="text" class="form-control" id="note" name="note" placeholder="전달 사항을 적어주세요" maxlength="100"
							value="${ order.note }">
						</div>
						
						<input type="hidden" name="onum" value="${ order.onum }">
						<input type="hidden" name="price" value="${ order.price }">
					<sec:authorize access="hasRole('ROLE_USER') and !hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
						<input type="hidden" name="status" value="${ order.status }">
						<input type="hidden" name="trackingNum" value="${ order.trackingNum }">
					</sec:authorize>
						
						<input type="hidden" name="page" value="${ cri.page }">
						<input type="hidden" name="show" value="${ cri.show }">
						<input type="hidden" name="cat" value="${ cri.cat }">
						<c:forEach items="${ cri.keyword }" varStatus="status">
							<input type="hidden" name="type" value="${ cri.type[status.index] }">
							<input type="hidden" name="keyword" value="${ cri.keyword[status.index] }">
						</c:forEach>
						
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
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
						<c:forEach items="${ order.productList }" var="product">
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
								<input type="radio" id="accountTransfer" name="payMethod" value="AT" ${ order.payMethod == "AT" ? "checked" : "" }>
								<label for="accountTransfer">계좌이체</label>
								<div class="check"></div>
							</div>
							<p>PG API 설치</p>
						</div>
						<div class="payment_item">
							<div class="radion_btn">
								<input type="radio" id="creditCard" name="payMethod" value="CC" ${ order.payMethod == "CC" ? "checked" : "" }>
								<label for="creditCard">카드결제</label>
								<img src="/resources/img/product/single-product/card.jpg" alt="">
								<div class="check"></div>
							</div>
							<p>PG API 설치</p>
						</div>
						<div class="row justify-content-center">
							<a href="javascript: window.history.back();">
								<input type="button" name="backBtn" class="genric-btn info" value="돌아가기">
							</a>&nbsp;&nbsp;
							<a href="#">
								<input type="button" name="modifyBtn" class="genric-btn success" value="수정 완료">
							</a>
						</div>
						<!-- <a class="main_btn" href="#">주문 완료</a> -->
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Checkout Area =================-->
<script type="text/javascript">
$(document).ready(function() {
	var name = '<c:out value="${ order.name }"/>';
	var contact = '<c:out value="${ order.contact }"/>';
	var email = '<c:out value="${ order.email }"/>';
	var address = '<c:out value="${ order.address }"/>';
	var zipCode = '<c:out value="${ order.zipCode }"/>';
	
	$("#member_info").on("change", function(event) {
		if ($(this).is(":checked") == true) {
			$("form div #name").val($(".principal").data("name"));
			$("form div #contact").val($(".principal").data("contact"));
			$("form div #email").val($(".principal").data("email"));
			$("form div #address").val($(".principal").data("address"));
			$("form div #zipCode").val($(".principal").data("zipcode"));
		}
		else {
			// $("form div input").val("");
			
			$("form div #name").val(name);
			$("form div #contact").val(contact);
			$("form div #email").val(email);
			$("form div #address").val(address);
			$("form div #zipCode").val(zipCode);
		}
	});
	
	$("input[name='modifyBtn']").on("click", function(event) {
		event.preventDefault();
		var payMethod = $("input[name='payMethod']:checked").val();
		var payOwner, payNum, payProvider;
		
		if (payMethod == "CC") {
			payOwner = "PG_입금자";
			payNum = "PG_카드번호";
			payProvider = "PG_입금 카드업체";
		}
		else if (payMethod == "AT") {
			payOwner = "PG_업체 계좌명";
			payNum = "PG_계좌번호";
			payProvider = "PG_업체 계좌 은행";
		}
		
		var str = ""; 
		str += "<input type='hidden' name='payMethod' value='" + payMethod + "'>"
			+ "<input type='hidden' name='payOwner' value='" + payOwner + "'>"
			+ "<input type='hidden' name='payNum' value='" + payNum + "'>"
			+ "<input type='hidden' name='payProvider' value='" + payProvider + "'>"
		
		var formObj = $("form[role='form']");
		formObj.append(str).submit();
	});
});
</script>
<%@ include file="../include/footer.jsp" %>