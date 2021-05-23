<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ include file="../include/header.jsp" %>

<!--=========================Parameters ========================-->
<form id="categoryForm" action="/category" method="POST">
	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>

<!--================Category Modification View =================-->
<section class="cat_product_area mt-xl mb-60">
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-6 list-group">
			<h3>카테고리 관리</h3>
				<c:set var="depth" value="-1"/>
				<c:set var="size" value="${ fn:length(list) }"/>
				<c:forEach items="${ list }" var="category" varStatus="status">
					<c:choose>
						<c:when test="${ depth < category.depth}">
							<ul class="unordered-list">
							<c:set var="depth" value="${ category.depth }"/>
						</c:when>
						
						<c:when test="${ depth > category.depth}">
							<ul class="unordered-list">
								<li class="mt-10">
									<div class="input-group">
										<input type="text" name="catName" placeholder="새 카테고리" onfocus="this.placeholder = ''" onblur="this.placeholder = '새 카테고리'"
										 maxlength="20" class="single-input-primary form-control" data-parent="${ list[status.index - 1].catNum }">
										 <div class="input-group-append">
										 	<button class="btn btn-outline-secondary insert" type="button">추가</button>
										 </div>
									</div>
								</li>
							</ul>
							
							<c:forEach begin="${ category.depth }" end="${ depth - 1 }" varStatus="i">
								</li>
								<li class="mt-10">
									<div class="input-group">
										<c:set var="parent" value="-1"/>
										<c:forEach begin="1" end="${ status.index }" varStatus="j">
											<c:if test="${ parent < 0 }">
												<c:if test="${ (depth + category.depth - i.index) > list[status.index - j.index].depth }">
													<c:set var="parent" value="${ list[status.index - j.index].catNum }"/>
												</c:if>
											</c:if>
										</c:forEach>
										
										<input type="text" name="catName" placeholder="새 카테고리" onfocus="this.placeholder = ''" onblur="this.placeholder = '새 카테고리'"
										 maxlength="20" class="single-input-primary form-control" data-parent="${ parent }">
										 <div class="input-group-append">
										 	<button class="btn btn-outline-secondary insert" type="button">추가</button>
										 </div>
									 </div>
								</li>
								</ul>
							</c:forEach>
							</li>
							<c:set var="depth" value="${ category.depth }"/>
						</c:when>
						
						<c:otherwise>
							<ul class="unordered-list">
								<li class="mt-10">
									<div class="input-group">
										<input type="text" name="catName" placeholder="새 카테고리" onfocus="this.placeholder = ''" onblur="this.placeholder = '새 카테고리'"
										 maxlength="20" class="single-input-primary form-control" data-parent="${ list[status.index - 1].catNum }">
										 <div class="input-group-append">
										 	<button class="btn btn-outline-secondary insert" type="button">추가</button>
										 </div>
									</div>
								</li>
							</ul>
							</li>
						</c:otherwise>
					</c:choose>
					<li class="mt-10">
						<div class="input-group">
							<c:choose>
								<c:when test="${ category.depth == 0 }">
									<input type="text" name="catName" value="${ category.catName }" onblur="this.value = '${ category.catName}'"
										 maxlength="20" class="single-input-primary form-control" readonly>
								</c:when>
								<c:otherwise>
									<input type="text" name="catName" value="${ category.catName }" data-catnum="${ category.catNum }" 
										 maxlength="20" class="single-input-primary form-control">
									<div class="input-group-append">
										<button class="btn btn-outline-secondary update" type="button">수정</button>
										<button class="btn btn-outline-secondary delete" type="button">삭제</button>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
				</c:forEach>
				
				<ul class="unordered-list">
					<li class="mt-10">
						<div class="input-group">
							<input type="text" name="catName" placeholder="새 카테고리" onfocus="this.placeholder = ''" onblur="this.placeholder = '새 카테고리'"
							 maxlength="20" class="single-input-primary form-control" data-parent="${ list[size - 1].catNum }">
							 <div class="input-group-append">
							 	<button class="btn btn-outline-secondary insert" type="button">추가</button>
							 </div>
						</div>
					</li>
				</ul>
				
				<c:if test="${ size > 1 }">
					<c:forEach begin="0" end="${ depth - 1 }" varStatus="i">
						</li>
							<li class="mt-10">
								<div class="input-group">
									<c:set var="parent" value="-1"/>
									<c:forEach begin="1" end="${ size }" varStatus="j">
										<c:if test="${ parent < 0 }">
											<c:if test="${ (depth - i.index) > list[size - j.index].depth }">
												<c:set var="parent" value="${ list[size - j.index].catNum }"/>
											</c:if>
										</c:if>
									</c:forEach>
											
									<input type="text" name="catName" placeholder="새 카테고리" onfocus="this.placeholder = ''" onblur="this.placeholder = '새 카테고리'"
									 maxlength="20" class="single-input-primary form-control" data-parent="${ parent }">
									 <div class="input-group-append">
									 	<button class="btn btn-outline-secondary insert" type="button">추가</button>
									 </div>
								 </div>
							</li>
						</ul>
					</c:forEach>
				</c:if>
				
				</li></ul>
			</div>
			<!--
			<div class="col-lg-6">
			</div>
			-->
		</div>
	</div>
</section>

<script type="text/javascript">
$(document).ready(function() {
	var categoryForm = $("#categoryForm");
	
	$(".list-group").on("click", ".insert", function() {
		// console.log("Insert clicked");
		
		var inputSource = $(this).closest("div").siblings("input");
		// console.log("parent: " + inputSource.data("parent") + " value: " + inputSource.val());
		var str = "<input type='hidden' name='catNum' value='" + inputSource.data("parent") + "'>";
		str += "<input type='hidden' name='catName' value='" + inputSource.val() + "'>";
		
		categoryForm.append(str);
		categoryForm.attr("action", "/category/insert");
		categoryForm.submit();
	});
	
	$(".list-group").on("click", ".update", function() {
		// console.log("Update clicked");
		
		var inputSource = $(this).closest("div").siblings("input");
		
		// console.log("catNum: " + inputSource.data("catnum") + "catName: " + inputSource.val());
		
		var str = "<input type='hidden' name='catNum' value='" + inputSource.data("catnum") + "'>";
		str += "<input type='hidden' name='catName' value='" + inputSource.val() + "'>";
		
		categoryForm.append(str);
		categoryForm.attr("action", "/category/update");
		categoryForm.submit();
	});
	
	$(".list-group").on("click", ".delete", function() {
		var inputSource = $(this).closest("div").siblings("input");
		
		var str = "<input type='hidden' name='catNum' value='" + inputSource.data("catnum") + "'>";
		categoryForm.append(str);
		categoryForm.attr("action", "/category/delete");
		categoryForm.submit();
	});
});
</script>

<%@ include file="../include/footer.jsp" %>