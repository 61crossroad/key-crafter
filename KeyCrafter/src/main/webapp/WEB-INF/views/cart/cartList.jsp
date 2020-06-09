<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp" %>

<!--================Cart Area =================-->
<section class="cart_area">
	<div class="container mt-sm">
		<div class="cart_inner">
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">상품</th>
							<th scope="col">가격</th>
							<th scope="col">수량</th>
							<th scope="col" style="width: 110px">합계</th>
						</tr>
					</thead>
					<tbody>
					<c:set var="subTotal" value="0"/>
					<!-- Session item cartList -->
					<c:forEach items="${ cartList }" var="product">
						<tr>
							<td>
								<div class="media">
									<div class="d-flex">
										<c:choose>
									<c:when test="${ product.attachList[0].uploadPath eq 'default' }">
										<img class="img-fluid"
										src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/default/s_${ product.attachList[0].fileName }"
										alt="${ product.pname }">
									</c:when>
									<c:otherwise>
										<img class="img-fluid"
										src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/${ product.attachList[0].uploadPath }/s_${ product.attachList[0].uuid }_${ product.attachList[0].fileName }"
										alt="${ product.pname }">
									</c:otherwise>
								</c:choose>
									<!--
										<img src="/show?fileName=${ product.attachList[0].uploadPath }/s_${ product.attachList[0].uuid }_${ product.attachList[0].fileName }"
											alt="${ product.pname }">
									-->
									</div>
									<div class="media-body">
										<p>[${ product.company }]&nbsp;${ product.pname }</p>
									</div>
								</div>
							</td>
							<td name="price" data-price="${ product.price }">
								<h5><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</h5>
							</td>
							<td name="product" data-pid="${ product.pid }">
								<div class="product_count">
									<input type="text" name="qty" maxlength="12" value="${ product.quantity }" title="Quantity:" class="input-text qty">
									<button name="qty-up" class="increase items-count"><i class="lnr lnr-chevron-up"></i></button>
									<button name="qty-down" class="reduced items-count"><i class="lnr lnr-chevron-down"></i></button>
								</div>
							</td>
							<td name="sum" data-sum="${ product.price * product.quantity }">
								<h5><fmt:formatNumber value="${ product.price * product.quantity }" pattern="#,###" />원</h5>
								<c:set var="subTotal" value="${ subTotal + product.price * product.quantity }"/>
							</td>
						</tr>
					</c:forEach>
						<tr>
							<td></td>
							<td></td>
							<td>
								<h5>소계</h5>
							</td>
							<td>
								<h5 class="subTotal" data-subtotal="${ subTotal }">
									<fmt:formatNumber value="${ subTotal }" pattern="#,###" />원
								</h5>
							</td>
						</tr>
						<tr class="shipping_area">
							<td></td>
							<td></td>
							<td>
								<h5>배송비</h5>
							</td>
							<td>
								<div class="shipping_box">
									<ul class="list">
										<li class="active" data-price="2500">
											<a href="#">택배: 2,500원</a>
										</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr class="out_button_area">
							<td></td>
							<td></td>
							<td></td>
							<td>
								<div class="checkout_btn_inner">
									<a class="gray_btn" href="javascript: window.history.back();">쇼핑 계속</a>
									<a class="main_btn" href="/order/register">주문하기</a>
								<!-- 
								<sec:authorize access="isAuthenticated()">
									<a class="main_btn" href="/order/register">주문하기</a>
								</sec:authorize>
								<sec:authorize access="isAnonymous()">
									<a class="main_btn" href="/member/login">주문하기</a>
								</sec:authorize>
								-->
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</section>
<!--================End Cart Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$("button[name='qty-up']").on("click", function() {
		var pid = $(this).closest("td[name='product']").data("pid");
		var thisObj = $(this);

		checkQuantity(pid, function(result) {
			var qty = thisObj.siblings("input");
			var num = qty.val();
			var parseNum = parseInt(num);
			var parseRes = parseInt(result);
			
			
			if (parseRes < parseNum + 1) {
				alert("수량이 너무 많습니다. 관리자에게 문의해주세요.");
				return;
			}
			
			qty.val(++num);
			
			updateCart(thisObj);
			setSum(thisObj, num);
			setSubTotal(thisObj.closest("td").siblings("td[name='price']").data("price"));
		});
	});

	function checkQuantity(pid, callback) {
		$.ajax({
			url: "/product/quantity/" + pid,
			method: "GET",
			success: function(result) {
				if (callback) {
					callback(result);
				}
			}
		});
	}
	
	$("button[name='qty-down']").on("click", function() {
		var qty = $(this).siblings("input[name='qty']");
		var num = qty.val();
		
		if (num >= 2) {
			qty.val(--num);
			num = qty.val();
			updateCart($(this), num);
			setSum($(this), num);
			setSubTotal($(this).closest("td").siblings("td[name='price']").data("price") * -1);
		}
		
		else if (num == 1) {
			qty.val(--num);
			updateCart($(this), num);
			setSubTotal($(this).closest("td").siblings("td[name='price']").data("price") * -1);
			$(this).closest("tr").remove();
		}
	});
	
	$(".main_btn").on("click", function(event) {
		event.preventDefault();
		var subTotal = $(".subTotal").data("subtotal");
		
		if (subTotal <= 0) {
			alert("상품이 없습니다.");

			return;
		}
		
		// console.log($(this).get(0).href);
		window.location.href = $(this).get(0).href;
	});
	
	function updateCart(source) {
		var pid = source.closest("td").data("pid");
		var qty = source.siblings("input[name='qty']").val();
		
		$.ajax({
			url: "/cart/update?pid=" + pid + "&quantity=" + qty,
			method: "PUT",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}
		});
	}
	
	function setSum(source, qty) {
		var price = source.closest("td").siblings("td[name='price']");
		var sum = price.data("price") * qty;
		
		source.closest("td").siblings("td[name='sum']").children("h5").html(numberWithCommas(sum) + "원");
	}
	
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	function setSubTotal(price) {
		var subTotal = $("tbody tr td .subTotal");
		var value = subTotal.data("subtotal");
		
		value += price;
		subTotal.data("subtotal", value);
		$("tbody tr td .subTotal").html(numberWithCommas(value) + "원");
	}
});
</script>

<%@ include file="../include/footer.jsp" %>