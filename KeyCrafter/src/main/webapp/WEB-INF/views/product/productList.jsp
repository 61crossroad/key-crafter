<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/modal.jsp" %>

<!--================Pagination & Search parameters =================-->
<form id="pageForm" action="/product/list" method="GET">
	<input type="hidden" name="page" value="${ pageMaker.cri.page }">
	<input type="hidden" name="show" value="${ pageMaker.cri.show }">
	<input type="hidden" name="cat" value="${ pageMaker.cri.cat }">
	<c:forEach items="${ pageMaker.cri.keyword }" varStatus="status">
		<input type="hidden" name="type" value="${ pageMaker.cri.type[status.index] }">
		<input type="hidden" name="keyword" value="${ pageMaker.cri.keyword[status.index] }">
	</c:forEach>
</form>

<!--================Category Product Area =================-->
<section class="cat_product_area mt-xl">
	<div class="container-fluid">
		<div class="row flex-row-reverse">
			<div class="col-lg-9">
				<div class="product_top_bar">
					<div class="left_dorp">
						<select class="sorting">
							<option value="1">Default sorting</option>
							<option value="2">Default sorting 01</option>
							<option value="4">Default sorting 02</option>
						</select>
						<select class="show">
							<c:forEach var="i" begin="0" end="2">
								<c:set var="show" value="${ i * 4 + 8 }" />
								<c:choose>
									<c:when test="${ show eq pageMaker.cri.show }">
										<option value="${ show }" selected>Show ${ show }</option>
									</c:when>
									<c:otherwise>
										<option value="${ show }">Show ${ show }</option>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</select>
					</div>
					
					<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
						<div class="right_page ml-auto">
							<a class="registProduct" href="/product/register">
								<button type="button" class="btn btn-primary">상품 등록</button>
							</a>
						</div>
					</sec:authorize>
					
					<div class="right_page ml-auto">
						<nav class="cat_page" aria-label="Page navigation example">
							<ul class="pagination">
								<c:if test="${ pageMaker.prev }">
									<li class="page-item">
										<a class="page-link" href="#">
											<i class="fa fa-chevron-left" aria-hidden="true"></i>
										</a>
									</li>
								</c:if>
								
								<c:forEach var="index" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
									<li class='page-item ${ pageMaker.cri.page == index ? "active" : "" }'>
										<a class="page-link" href="${ index }">${ index }</a>
									</li>
								</c:forEach>
								<c:if test="${ pageMaker.next }">
									<li class="page-item">
										<a class="page-link" href="#">
											<i class="fa fa-chevron-right" aria-hidden="true"></i>
										</a>
									</li>
								</c:if>
							</ul>
						</nav>
					</div>
				</div>
				<div class="latest_product_inner row">
					<c:forEach items="${ list }" var="product">
						<div class="col-lg-3 col-md-3 col-sm-6">
						<div class="f_p_item">
							<div class="f_p_img">
								<a class="getProduct" href="${ product.pid }">
									<img class="img-fluid"
										src="/show?fileName=${ product.attachList[0].uploadPath }/m_${ product.attachList[0].uuid }_${ product.attachList[0].fileName }"
										alt="${ product.PName }">
								</a>
								<sec:authorize access="hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')">
									<div class="p_icon">
										<a class="modifyProduct" href="${ product.pid }">
											<i id="modify" class="fa fa-pencil"></i>
										</a>
										<a class="deleteProduct" href="${ product.pid }">
											<i id="delete" class="fa fa-trash-o"></i>
										</a>
									</div>
								</sec:authorize>
							</div>
							<a class="getProduct" href="${ product.pid }">
								<h4>[${ product.company }]&nbsp;${ product.PName }</h4>
							</a>
							<h5><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</h5>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-lg-3">
			
			<%@ include file="../category/categoryList.jsp" %>
			
			</div>
		</div>

		<div class="row mt-lg mb-60">
			<nav class="cat_page mx-auto" aria-label="Page navigation example">
				<ul class="pagination">
					<c:if test="${ pageMaker.prev }">
						<li class="page-item">
							<a class="page-link" href="#">
								<i class="fa fa-chevron-left" aria-hidden="true"></i>
							</a>
						</li>
					</c:if>
					
					<c:forEach var="index" begin="${ pageMaker.startPage }" end="${ pageMaker.endPage }">
						<li class='page-item ${ pageMaker.cri.page == index ? "active" : "" }'>
							<a class="page-link" href="${ index }">${ index }</a>
						</li>
					</c:forEach>
					<c:if test="${ pageMaker.next }">
						<li class="page-item">
							<a class="page-link" href="#">
								<i class="fa fa-chevron-right" aria-hidden="true"></i>
							</a>
						</li>
					</c:if>
				</ul>
			</nav>
		</div>
	</div>
</section>
<!--================End Category Product Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var csrfParameterName = "${ _csrf.parameterName }";
	var csrfTokenValue = "${ _csrf.token }";
	
	var insertResult = '<c:out value="${ insertResult }"/>';
	var updateResult = '<c:out value="${ updateResult }"/>';
	var deleteResult = '<c:out value="${ deleteResult }"/>';
	
	var pageForm = $("#pageForm");
	
	toggleModal(insertResult, updateResult, deleteResult);
	
	function toggleModal(insertParam, updateParam, deleteParam) {
		console.log("insertResult: " + insertParam);
		console.log("updateResult: " + updateParam);
		
		if (insertParam > 0) {
			$("#resultCenter .modal-body").html(parseInt(insertParam) + "번 상품을 등록했습니다.");
			$("#resultCenter").modal("show");
		}
		else if (updateParam > 0){
			$("#resultCenter .modal-body").html(parseInt(updateParam) + "번 상품을 수정했습니다.");
			$("#resultCenter").modal("show");
		}
		else if (deleteParam > 0){
			$("#resultCenter .modal-body").html(parseInt(deleteParam) + "번 상품을 삭제했습니다.");
			$("#resultCenter").modal("show");
		}
		else {
			return;
		}
	}
	
	$(".show").on("change", function() {
		pageForm.find("input[name='show']").val($(this).val());
		pageForm.submit();
	});
	
	$(".page-item a").on("click", function(event) {
		event.preventDefault();
		
		pageForm.find("input[name = 'page']").val($(this).attr("href"));
		pageForm.submit();
	});
	
	$(".registProduct").on("click", function(event) {
		event.preventDefault();
		
		pageForm.attr("action", "/product/register");
		pageForm.submit();
	});
	
	$(".modifyProduct").on("click", function(event) {
		event.preventDefault();
		
		pageForm.append("<input type='hidden' name='pid' value='" + $(this).attr("href") + "'>");
		pageForm.attr("action", "/product/modify");
		pageForm.submit();
	});
	
	$(".deleteProduct").on("click", function(event) {
		event.preventDefault();
		
		if (confirm("상품을 삭제하시겠습니까?")) {
			var str = "<input type='hidden' name='pid' value='" + $(this).attr("href") + "'>" +
				"<input type='hidden' name='" + csrfParameterName + "' value='" + csrfTokenValue + "'>";
			pageForm.append(str);
			pageForm.attr("action", "/product/delete");
			pageForm.attr("method", "POST");
			pageForm.submit();
		}
	});
	
	$(".getProduct").on("click", function(event) {
		event.preventDefault();
		
		pageForm.append("<input type='hidden' name='pid' value='" + $(this).attr("href") + "'>");
		pageForm.attr("action", "/product/get");
		pageForm.submit();
	});
});
</script>
	
<%@ include file="../include/footer.jsp" %>