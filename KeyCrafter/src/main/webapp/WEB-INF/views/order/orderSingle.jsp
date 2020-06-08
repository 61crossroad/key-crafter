<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp" %>

<!--================Order Details Area =================-->
<section class="order_details p_120">
	<div class="container">
		<div class="row order_d_inner">
			<div class="col-lg-3">
				<div class="details_item">
					<h4>주문 정보</h4>
					<ul class="list">
						<li>
							<a href="#">
								<span>주문 번호</span> : ${ order.onum }
							</a>
						</li>
						<li>
							<a href="#">
								<span>이름</span> : ${ order.name }
							</a>
						</li>
						<li>
							<a href="#">
								<span>이메일</span> : ${ order.email }
							</a>
						</li>
						<li>
							<a href="#">
								<span>연락처</span> : ${ order.contact }
							</a>
						</li>
						<li>
							<a href="#">
								<span>진행 상황</span> : ${ order.message }
							</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="details_item">
					<h4>결제 상태</h4>
					<ul class="list">
						<c:choose>
							<c:when test="${ order.payMethod == \"AT\" }">
								<c:set var="payMethod" value="계좌이체"/>
								<c:set var="payOwner" value="입금 계좌명"/>
								<c:set var="payNum" value="계좌 번호"/>
								<c:set var="payProvider" value="입금 은행"/>
							</c:when>
							<c:when test="${ order.payMethod == \"CC\" }">
								<c:set var="payMethod" value="카드 결제"/>
								<c:set var="payOwner" value="입금자"/>
								<c:set var="payNum" value="카드 번호"/>
								<c:set var="payProvider" value="카드 회사"/>
							</c:when>
						</c:choose>
						<li>
							<a href="#">
								<span>결제 방법</span> : ${ payMethod }
							</a>
						</li>
						<li>
							<a href="#">
								<span>${ payOwner }</span> : ${ order.payOwner }</a>
						</li>
						<li>
							<a href="#">
								<span>${ payNum }</span> : ${ order.payNum }</a>
						</li>
						<li>
							<a href="#">
								<span>${ payProvider }</span> : ${ order.payProvider }</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="details_item">
					<h4>배송지</h4>
					<ul class="list">
						<li>
							<a href="#">
								<span>주소</span> : ${ order.address }</a>
						</li>
						<li>
							<a href="#">
								<span>우편번호</span> : ${ order.zipCode }</a>
						</li>
						<li>
							<a href="#">
								<span>배송 메시지</span> : ${ order.note }</a>
						</li>
						<li>
							<a href="#">
								<span>배송 방법 </span> : 택배</a>
						</li>
						<li>
							<a href="#">
								<span>운송장 번호 </span> : 
								<c:choose>
									<c:when test="${ order.trackingNum == null }">
										N/A
									</c:when>
									<c:otherwise>
										${ order.trackingNum }
									</c:otherwise>
								</c:choose>
							</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="order_details_table">
			<h2>상세 사항</h2>
			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th scope="col">상품</th>
							<th scope="col">수량</th>
							<th scope="col">합계</th>
						</tr>
					</thead>
					<tbody>
					<c:forEach items="${ order.productList }" var="product">
						<tr>
							<td>
								<p><a href="/product/get?pid=${ product.pid }">[${ product.company }]&nbsp;${ product.pname }</a></p>
							</td>
							<td>
								<h5>x ${ product.quantity }</h5>
							</td>
							<td>
								<p><fmt:formatNumber value="${ product.price * product.quantity }" pattern="#,###" />원</p>
							</td>
						</tr>
					</c:forEach>
						<tr>
							<td>
								<h4>소계</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p><fmt:formatNumber value="${ order.price - 2500 }" pattern="#,###" />원</p>
							</td>
						</tr>
						<tr>
							<td>
								<h4>배송비</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p>2,500원</p>
							</td>
						</tr>
						<tr>
							<td>
								<h4>총 결제 금액</h4>
							</td>
							<td>
								<h5></h5>
							</td>
							<td>
								<p><fmt:formatNumber value="${ order.price }" pattern="#,###" />원</p>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row mt-sm justify-content-center">
			<a href="javascript: window.history.back();">
				<input type="button" name="back" class="genric-btn info" value="돌아가기">
			</a>&nbsp;&nbsp;
			<form action="/order/modify" method="get">
				<input type="hidden" name="page" value="${ cri.page }">
				<input type="hidden" name="show" value="${ cri.show }">
				<input type="hidden" name="cat" value="${ cri.cat }">
				<c:forEach items="${ cri.keyword }" varStatus="status">
					<input type="hidden" name="type" value="${ cri.type[status.index] }">
					<input type="hidden" name="keyword" value="${ cri.keyword[status.index] }">
				</c:forEach>
				<input type="hidden" name="onum" value="${ order.onum }">
				
				<input type="submit" name="modify" class="genric-btn success" value="정보 수정">
			</form>
		</div>
	</div>
</section>
<!--================End Order Details Area =================-->

<%@ include file="../include/footer.jsp" %>