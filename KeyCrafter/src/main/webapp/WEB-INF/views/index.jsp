<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="include/header.jsp"%>
<%@ include file="include/modal.jsp" %>

<!--================Home Banner Slider =================-->
<section class="home_banner_area">
	<div class="overlay"></div>
	<div class="banner_inner d-flex align-items-center row no-gutters">
		<div id="homeBannerCaptions" class="row banner_content carousel slide no-gutters" data-ride="carousel">
			<ol class="carousel-indicators">
				<li data-target="#homeBannerCaptions" data-slide-to="0" class="active"></li>
				<li data-target="#homeBannerCaptions" data-slide-to="1"></li>
				<li data-target="#homeBannerCaptions" data-slide-to="2"></li>
			</ol>
			<div class="carousel-inner h-600">
				<div class="carousel-item active">
					<img src="/resources/img/banner/anne-pro-2.png" class="d-block w-100" alt="1st">
					<div class="carousel-caption d-none d-block">
						<h3>Anne Pro 2</h3>
						<h4>Nulla vitae elit libero, a pharetra augue mollis interdum.</h4>
					</div>
				</div>
				<div class="carousel-item">
					<img src="/resources/img/banner/hhkb02.png" class="d-block w-100" alt="2nd">
					<div class="carousel-caption d-none d-block">
						<h3>HHKB</h3>
						<h4>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</h4>
					</div>
				</div>
				<div class="carousel-item">
					<img src="/resources/img/banner/realforce01.png" class="d-block w-100" alt="3rd">
					<div class="carousel-caption d-none d-block">
						<h3>Leopold Realforce R2</h3>
						<h4>Praesent commodo cursus magna, vel scelerisque nisl consectetur.</h4>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<!--================Feature Product Area =================-->
<section class="feature_product_area section_gap">
	<div class="main_box">
		<div class="container-fluid">
			<div class="row">
				<div class="main_title">
					<h2>New Arrivals</h2>
					<p>신상품을 소개합니다.</p>
				</div>
			</div>
			<div class="row">
				<c:forEach items="${ list }" var="product" varStatus="status">
					<div class="col col${ status.index + 1 }">
						<div class="f_p_item">
							<div class="f_p_img">
								<a class="getProduct" href="/product/get?pid=${ product.pid }">
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
							<a class="getProduct" href="/product/get?pid=${ product.pid }">
								<h4>${ product.PName }</h4>
							</a>
							<h5>${ product.price }</h5>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
</section>

<!-- Modal -->
<!--
<div class="modal fade" id="resultCenter" tabindex="-1" role="dialog" aria-labelledby="resultCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="resultCenterTitle"></h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
      </div>
    </div>
  </div>
</div>
-->
<!--================End Feature Product Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var resultReg = '<c:out value="${result}"/>';

	toggleModal(resultReg);

	function toggleModal(result) {
		console.log("resultPid: " + result);
		if (result > 0) {
			$("#resultCenter .modal-body").html("환영합니다!");
			$("#resultCenter").modal("show");
		}
		else {
			return;
		}
	}
});
</script>

<%@ include file="include/footer.jsp"%>
<%-- @ page session="false" --%>
<!--
<html>
<head>
	<title>Home</title>
</head>
<body>
<h1>
	Hello world!  
</h1>

<P>  The time on the server is ${serverTime}. </P>
</body>
</html>
-->