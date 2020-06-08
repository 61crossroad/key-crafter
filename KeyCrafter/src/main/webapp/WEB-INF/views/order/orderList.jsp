<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../include/header.jsp"%>

<!--================ Pagination & Search parameters =================-->
<form id="pageForm" action="/order/list" method="GET">
	<input type="hidden" name="page" value="${ pageMaker.cri.page }">
	<input type="hidden" name="show" value="${ pageMaker.cri.show }">
	<input type="hidden" name="cat" value="${ pageMaker.cri.cat }">
	<c:forEach items="${ pageMaker.cri.keyword }" varStatus="status">
		<input type="hidden" name="type" value="${ pageMaker.cri.type[status.index] }">
		<input type="hidden" name="keyword" value="${ pageMaker.cri.keyword[status.index] }">
	</c:forEach>
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>
<!--============== End Pagination & Search parameters ===============-->

<!--========================== Order List ===========================-->
<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<h3 class="mt-lg mb-30 title_color">주문 내역</h3>
			<div class="progress-table-wrap">
			    <div class="progress-table">
			        <div class="table-head">
			            <div class="order-num">주문 번호</div>
		            <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
		            	<div class="order-id">아이디</div>
		            	<div class="product-name-admin">상품명</div>
		            </sec:authorize>
			        <sec:authorize access="hasRole('ROLE_USER') and !hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
			        	<div class="product-name-user">상품명</div>
			        </sec:authorize>
			            <div class="price">가격</div>
			            <div class="order-date">주문일</div>
			            <div class="order-status">상태</div>
			            <div class="order-action">관리</div>
			        </div>
			        
		        <c:forEach items="${ orderList }" var="order">
		        	<div class="table-row">
			            <div class="order-num">${ order.onum }</div>
		            <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
		            	<div class="order-id">${ order.id }</div>
		            	<div class="product-name-admin">
		            </sec:authorize>
			        <sec:authorize access="!hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
			        	<div class="product-name-user">
			        </sec:authorize>
			            <c:set var="product" value="${ order.productList[0] }"/>
			            	<a class="getLink" href="${ order.onum }">
			            	<!-- 
				                <img src="/show?fileName=${ product.attachList[0].uploadPath }/s_${ product.attachList[0].uuid }_${ product.attachList[0].fileName }" alt="${ product.pname }">
				            -->
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
				                [${ product.company }]&nbsp;${ product.pname }
			                
			            <c:set var="productCount" value="${ fn: length(order.productList) }"/>
			            <c:if test="${ productCount  > 1 }">
			            	외 ${ productCount - 1 }개
				            </c:if>
			            	</a>
			            </div>
			            <div class="price">
			            	<fmt:formatNumber pattern="#,###" value="${ order.price }"/>원
			            </div>
			            <div class="order-date">
			            	<fmt:formatDate pattern="yyyy. MM. dd." value="${ order.orderDate }"/>
			            </div>
			            <div class="order-status">
			            	${ order.message }
			            </div>
			            <div class="order-action">
			            	<a href="${ order.onum }">
			            		<input type="button" name="modifyBtn" class="genric-btn success-border small" value="수정">
			            	</a>
			            	<a href="${ order.onum }">
			            		<input type="button" name="cancelBtn" class="genric-btn primary-border small" value="취소"
			            		data-status="${ order.status }">
			            	</a>
			            </div>
			        </div>
		        </c:forEach>
		        
		        <sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
		        	<div class="table-row">
		        		<div class="form-group col-md-1">
		        			<select name="searchType" class="form-control">
		        				<option value="I" ${ fn: contains(pageMaker.cri.type[0], 'I') ? 'selected' : '' }>아이디</option>
		        				<option value="N" ${ fn: contains(pageMaker.cri.type[0], 'N') ? 'selected' : '' }>이름</option>
		        				<option value="T" ${ fn: contains(pageMaker.cri.type[0], 'T') ? 'selected' : '' }>연락처</option>
		        				<option value="E" ${ fn: contains(pageMaker.cri.type[0], 'E') ? 'selected' : '' }>이메일</option>
		        			</select>
		        		</div>
		        		<div class="form-group col-md-3">
		        			<input type="text" name="searchKeyword" class="form-control" maxlength="40" value="${ pageMaker.cri.keyword[0] }"> 
		        		</div>
		        		<div class="form-group col-md-1">
		        			<input type="button" name="searchBtn" class="btn btn-primary" value="검색">
		        		</div>
		        	</div>
		        </sec:authorize>
		        
			        <nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
						<c:if test="${ pageMaker.prev }">
						    <li class="page-item">
						        <a href="${ pageMaker.startPage - 1 }" class="page-link" aria-label="Previous">
						            <span aria-hidden="true">
						                <span class="lnr lnr-chevron-left"></span>
						            </span>
						        </a>
						    </li>
						</c:if>
						<c:forEach var="index" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
							<li class='page-item ${ pageMaker.cri.page == index ? "active" : "" }'>
						        <a href="${ index }" class="page-link">${ index }</a>
						    </li>
						</c:forEach>
						<c:if test="${ pageMaker.next }">
							<li class="page-item">
						        <a href="${ pageMaker.endPage + 1 }" class="page-link" aria-label="Next">
						            <span aria-hidden="true">
						                <span class="lnr lnr-chevron-right"></span>
						            </span>
						        </a>
						    </li>
						</c:if>
						</ul>
					</nav>
			    </div>
			</div>
		</div>
	</div>
</div>
<!--======================== End Order List =========================-->

<script type="text/javascript">
$(document).ready(function() {
	var page = '<c:out value="${ pageMaker.cri.page }"/>';
	var updateResult = '<c:out value="${ updateResult }"/>';
	var pageForm = $("#pageForm");
	
	/*
	(function(result) {
		console.log("Update result: " + result);
	})(updateResult);
	*/
	
	$(".getLink").on("click", function(event) {
		event.preventDefault();
		
		var str = "<input type='hidden' name='onum' value='" + $(this).attr("href") + "'>";
		pageForm.append(str).attr("action", "/order/get").submit();
	});
	
	$("input[name='cancelBtn']").on("click", function(event) {
		event.preventDefault();
		
		var status = $(this).data("status");
		
		if (1 <= status && status <= 2) {
			if (confirm("주문을 취소하시겠습니까?")) {
				var str = "<input type='hidden' name='onum' value='" + $(this).closest("a").attr("href") + "'>";
				pageForm.append(str).attr("action", "/order/cancel").attr("method", "POST").submit();
			}
		}
		else if (3 <= status && status <= 4) {
			alert("주문을 취소할 수 없습니다. 고객센터에 문의바랍니다.");
		}
		else if (status == 5) {
			alert("취소 요청을 처리 중입니다.");
		}
		else if (status == 6) {
			alert("환불 처리 중입니다.");
		}
		else if (status == 7) {
			alert("환불이 완료되었습니다.");
		}
	});
	
	$("input[name='modifyBtn']").on("click", function(event) {
		event.preventDefault();
		var str = "<input type='hidden' name='onum' value='" + $(this).closest("a").attr("href") + "'>";
		pageForm.append(str).attr("action", "/order/modify").submit();
	});
	
	$("input[name='searchBtn']").on("click", function() {
		var type = $("select[name='searchType']").val();
		var keyword = $("input[name='searchKeyword']").val();
		
		if (!keyword) {
			alert("검색어를 입력하세요");
			return;
		}
		
		var str = "<input type='hidden' name='type' value='" + type + "'>"
			+ "<input type='hidden' name='keyword' value='" + keyword + "'>";
		
		pageForm.find("input[name='type']").remove();
		pageForm.find("input[name='keyword']").remove();
		pageForm.append(str);
		pageForm.find("input[name='page']").val("1");
		pageForm.submit();
	});
	
	$(".page-item a").on("click", function(event) {
		event.preventDefault();
		
		if (page != $(this).attr("href")) {
			$("#pageForm").find("input[name='page']").val($(this).attr("href"));
			$("#pageForm").submit();
		}
	});
})
</script>

<%@ include file="../include/footer.jsp"%>