<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%@ include file="../include/header.jsp"%>

<!--================ Pagination & Search parameters =================-->
<form id="pageForm" action="/member/list" method="GET">
	<input type="hidden" name="page" value="${ pageMaker.cri.page }">
	<input type="hidden" name="show" value="${ pageMaker.cri.show }">
	<input type="hidden" name="cat" value="${ pageMaker.cri.cat }">
	<c:forEach items="${ pageMaker.cri.keyword }" varStatus="status">
		<input type="hidden" name="type" value="${ pageMaker.cri.type[status.index] }">
		<input type="hidden" name="keyword" value="${ pageMaker.cri.keyword[status.index] }">
	</c:forEach>
</form>
<!--============== End Pagination & Search parameters ===============-->

<!--========================== Member List ===========================-->
<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<h3 class="mt-lg mb-30 title_color">회원 목록</h3>
			<div class="progress-table-wrap">
			    <div class="progress-table">
			        <div class="table-head">
			            <div class="member-id">아이디</div>
		            	<div class="member-name">이름</div>
			        	<div class="member-email">이메일</div>
			        	<div class="member-contact">연락처</div>
			            <div class="member-role">회원 등급</div>
			        </div>
			        
		        <c:forEach items="${ memberList }" var="member">
		        	<div class="table-row">
				            <div class="member-id">
				            	<a class="getLink" href="/member/get?id=${ member.id }">
				            		${ member.id }
				            	</a>
				            </div>
				            <div class="member-name">
				            	<a class="getLink" href="/member/get?id=${ member.id }">
				            		${ member.name }
				            	</a>
				            </div>
				            <div class="member-email">
				            	<a class="getLink" href="/member/get?id=${ member.id }">
				            		${ member.email }
				            	</a>
				            </div>
				            <div class="member-contact">
				            	<a class="getLink" href="/member/get?id=${ member.id }">
				            		${ member.contact }
				            	</a>
				            </div>
				            <div class="member-role">
				            	<a class="getLink" href="/member/get?id=${ member.id }">
				            		${ member.role }
				            	</a>
				            </div>
			        </div>
		        </c:forEach>
		        
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
<!--======================== End member List =========================-->

<script type="text/javascript">
$(document).ready(function() {
	var page = '<c:out value="${ pageMaker.cri.page }"/>';
	var pageForm = $("#pageForm");
	
	$(".page-item a").on("click", function(event) {
		event.preventDefault();
		
		if (page != $(this).attr("href")) {
			pageForm.find("input[name='page']").val($(this).attr("href"));
			pageForm.submit();
		}
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
})
</script>

<%@ include file="../include/footer.jsp"%>