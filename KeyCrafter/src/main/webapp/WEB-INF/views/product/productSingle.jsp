<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!--================Pagination & Search parameters =================-->
<form id="pageForm" action="/product/list" method="GET">
	<input type="hidden" name="page" value="${ cri.page }">
	<input type="hidden" name="show" value="${ cri.show }">
	<input type="hidden" name="type" value="${ cri.type }">
	<input type="hidden" name="keyword" value="${ cri.keyword }">
</form>

<!--================Single Product Area =================-->
<div class="product_image_area">
	<div class="container">
		<div class="row s_product_inner">
			<div class="col-lg-6">
				<div class="s_product_img">
					<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
						<ol class="carousel-indicators">
							<c:forEach items="${ product.attachList }" var="attach" varStatus="status">
								<li data-target="#carouselExampleIndicators" data-slide-to="${ status.index }"
								${ status.first ? ' class="active"' : '' }>
								
							<c:choose>
								<c:when test="${ attach.uploadPath eq 'default' }">
									<img class="img-fluid"
									src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/default/s_${ attach.fileName }"
									alt="${ product.pname }">
								</c:when>
								<c:otherwise>
									<img class="img-fluid"
									src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/${ attach.uploadPath }/s_${ attach.uuid }_${ attach.fileName }"
									alt="${ product.pname }">
								</c:otherwise>
							</c:choose>
								<!--
									<img src="/show?fileName=${ attach.uploadPath }/s_${ attach.uuid }_${ attach.fileName }"
									alt="${ product.pname }">
								-->
								</li>
							</c:forEach>
						</ol>
						<div class="carousel-inner">
							<c:forEach items="${ product.attachList }" var="attach" varStatus="status">
								<div class="carousel-item${ status.first ? ' active' : '' }">
								<c:choose>
								<c:when test="${ attach.uploadPath eq 'default' }">
									<img class="img-fluid"
									src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/default/m_${ attach.fileName }"
									alt="${ product.pname }">
								</c:when>
								<c:otherwise>
									<img class="img-fluid"
									src="https://upload-kc.s3.ap-northeast-2.amazonaws.com/upload/${ attach.uploadPath }/m_${ attach.uuid }_${ attach.fileName }"
									alt="${ product.pname }">
								</c:otherwise>
							</c:choose>
								<!-- 
									<img class="d-block w-100" src="/show?fileName=${ attach.uploadPath }/m_${ attach.uuid }_${ attach.fileName }"
									alt="Slide ${ status.index }">
								-->
								</div>
							</c:forEach>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-5 offset-lg-1">
				<div class="s_product_text">
					<h3>${ product.pname }</h3>
					<h2><fmt:formatNumber value="${ product.price }" pattern="#,###" />원</h2>
					<ul class="list">
						<li>
							<span>분류</span> : <!-- Household -->
							<c:forEach items="${ product.categoryList }" var="category" varStatus="status">
								${ category.catName }${ status.last ? '' : ',&nbsp;' }
							</c:forEach>
						</li>
						<li>
							<span>제조사</span> : ${ product.company }
						</li>
						<li>
							<span>제조국</span> : ${ product.madeIn }
						</li>
						<li>
							<span>등록일</span> : <fmt:formatDate value="${ product.regDate }" pattern="yyyy.MM.dd"/>
						</li>
						<li>
							<span>수정일</span> : <fmt:formatDate value="${ product.updateDate }" pattern="yyyy.MM.dd"/>
						</li>
					</ul>
					<p></p>
					<div class="product_count">
						<label for="qty">수량:</label>
				<c:choose>
					<c:when test="${ product.quantity > 0 }">
						<input type="text" name="qty" id="qty" maxlength="12" value="1" title="Quantity:" class="input-text qty">
						<button id="qty-up" class="increase items-count"><i class="lnr lnr-chevron-up"></i></button>
						<button id="qty-dn" class="reduced items-count"><i class="lnr lnr-chevron-down"></i></button>
					</c:when>
					<c:otherwise>
						<input type="text" name="qty" id="qty" maxlength="12" value="0" title="Quantity:" class="input-text qty">
						<button class="increase items-count"><i class="lnr lnr-chevron-up"></i></button>
						<button class="reduced items-count"><i class="lnr lnr-chevron-down"></i></button>
					</c:otherwise>
				</c:choose>
						
					</div>
					<div class="card_area">
						<form id="cartAddList" action="/cart/addList" method="post">
							<input type="hidden" name="pid" value="${ product.pid }">
							<input type="hidden" name="pname" value="${ product.pname }">
							<input type="hidden" name="price" value="${ product.price }">
							<input type="hidden" name="company" value="${ product.company }">
							<input type="hidden" name="attachList[0].uuid" value="${ product.attachList[0].uuid }">
							<input type="hidden" name="attachList[0].uploadPath" value="${ product.attachList[0].uploadPath }">
							<input type="hidden" name="attachList[0].fileName" value="${ product.attachList[0].fileName }">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</form>
						
				<c:choose>
					<c:when test="${ product.quantity > 0 }">
						<a class="main_btn" href="#">주문하기</a>
						<a class="icon_btn addToCart" href="#">
							<i class="lnr lnr lnr-cart"></i>
						</a>
					</c:when>
					<c:otherwise>
						<a class="null_btn" href="#">품&nbsp;&nbsp;절</a>
						<a class="icon_btn">
							<i class="lnr lnr lnr-cart"></i>
						</a>
					</c:otherwise>
				</c:choose>
						
						<a class="icon_btn" href="javascript: window.history.back();">
							<i class="fa fa-arrow-left"></i>
						</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--================End Single Product Area =================-->

<!--================Product Description Area =================-->
<section class="product_description_area">
	<div class="container">
		<ul class="nav nav-tabs" id="myTab" role="tablist">
			<li class="nav-item">
				<a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">상품 정보</a>
			</li>
			<li class="nav-item">
				<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">상품 후기</a>
			</li>
		</ul>
		<div class="tab-content" id="myTabContent">
			<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
				<p>${ product.productDesc }</p>
			</div>
			
			<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
				<div class="row">
					<div class="col-lg-6">
						<div class="comment_list">
							<!-- Replies are inserted here.
								Pagination is followed.
							-->
							
						</div>
					</div>
					<div class="col-lg-6">
						<div class="review_box">
							<h4>새 댓글 쓰기</h4>
							<form class="row contact_form" id="newParentReply">
							<sec:authorize access="isAnonymous()">
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control" name="name" placeholder="이름" maxlength="15" required>
									</div>
								</div>
								<div class="col-md-12">
									<div class="form-group">
										<input type="password" class="form-control" name="password" placeholder="비밀번호" maxlength="20" required>
									</div>
								</div>
							</sec:authorize>
							<sec:authorize access="isAuthenticated()">
								<div class="col-md-12">
									<div class="form-group">
										<input type="text" class="form-control" name="id"
										value='<sec:authentication property="principal.member.id"/>' readonly="readonly">
									</div>
								</div>
							</sec:authorize>
								<div class="col-md-12">
									<div class="form-group">
										<textarea class="form-control" name="content" rows="1" placeholder="내용" maxlength="200" required></textarea>
									</div>
								</div>
								<div class="col-md-12 text-right">
									<input type="submit" value="등록" class="btn btn-primary" name="newReplyBtn">
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>
<!--================End Product Description Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var pid = '<c:out value="${ product.pid }"/>';
	
	var attach = new Object();
	attach.uuid = "${ product.attachList[0].uuid }";
	attach.uploadPath = "${ product.attachList[0].uploadPath }";
	attach.fileName = "${ product.attachList[0].fileName }";
	
	var attachList = new Array();
	attachList.push(attach);
	
	var cartProduct = new Object();
	cartProduct.pid = pid;
	cartProduct.pname = "${ product.pname }";
	cartProduct.price = "${ product.price }";
	cartProduct.company = "${ product.company }";
	cartProduct.attachList = attachList;
	
	var qty = $("#qty");
	
	getReplyList(0);
	
	function getReplyList(page) {
		$.ajax({
			url: "/preply/list/" + pid + "/" + page,
			method: "GET",
			dataType: "JSON"
		}).done(function(result) {
			// console.log(result.count + " " + result.rootRnum);
			
			// 댓글 삭제 아이콘을 넣기 위한 현재 로그인 정보
			var name = $("#newParentReply .col-md-12 .form-group input[name='name']").val();
			var id = $("#newParentReply .col-md-12 .form-group input[name='id']").val();
			
			var str = "";
			var comment_list = $(".comment_list");
			
			comment_list.html("");
			comment_list.data("rnum", result.rootRnum);
			
			if (result.count == 0) {
				str += "<div class=\"review_item\"><div class=\"media\"><div class=\"media-body\"><h4 style=\"margin-left: 40%;\">댓글이 없습니다.</h4></div></div></div>";
				comment_list.append(str);
			}
			
			else {
				result.replyList.forEach(function(reply) {
					var padding = 28 * (reply.depth - 1);
					var date = new Date(reply.updateDate);
					
					str += "<div class=\"review_item\" style=\"padding-left: " + padding
						+ "px;\" data-padding=\"" + padding + "\" data-rnum=\"" + reply.rnum + "\">";
					str += "<div class=\"media\"><div class=\"media-body\"><h4>";
					
					if (reply.id == null) {
						str += reply.name;
					}
					else {
						str += reply.userName;
					}
					
					str += "</h4><h5>" + date.getFullYear() + "." + date.getMonth() + 1 + "." + date.getDate() + ". "
						+ date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "</h5>";
					
					if (reply.deleted == 'N') {
						// 비회원이 작성한 댓글
						if (reply.id == null) {
							str += "<a class=\"delete_btn\" href=\"" + reply.rnum + "\"><i class=\"fa fa-eraser\"></i></a>";
						}
						
						// 회원 자신이 작성한 댓글
						else if (reply.id != null && reply.id == id) {
							str += "<a class=\"delete_btn\" href=\"" + reply.rnum + "\"><i class=\"fa fa-eraser\"></i></a>";
						}
					}
					
					str += "<a class=\"reply_btn\" href=\"" + reply.rnum + "\"><i class=\"fa fa-comments\"></i></a>";
					
					var deletedContent = reply.deleted == 'Y' ? " class=\"deleted_reply\"" : ''; 
					str += "</div></div>" + "<p><span" + deletedContent + ">"
						+ reply.content + "</span></p><hr></div>"; 
				});
				
				var currPage, firstPage, lastPage, totalPage;
				
				totalPage = Math.ceil(result.count / 10);
				currPage = page == 0 ? totalPage : page;
				lastPage = Math.ceil(currPage / 5) * 5;
				firstPage = (lastPage - 4) < 0 ? 1 : lastPage - 4;
				lastPage = totalPage < lastPage ? totalPage : lastPage;
				
				// console.log(firstPage + " < " + currPage + " < " + lastPage + " [" + totalPage + "]");
				
				str += "<div class=\"row review_item mt-sm\">"
					+ "<nav class=\"cat_page mx-auto\" aria-label=\"Page navigation\">"
					+ "<ul class=\"pagination\" data-page=\"" + currPage + "\">";
				
				if (firstPage > 1) {
					str +=  "<li class=\"page-item\"><a class=\"page-link\" href=\"" + firstPage - 1 + "\">"
						+ "<i class=\"fa fa-chevron-left\" aria-hidden=\"true\"></i></a></li>";
				}
				
				for (var i = firstPage; i <= lastPage; i++) {
					str += "<li class=\"page-item" + (i == currPage ? " active\" data-disabled=\"T\"" : "") + "\"><a class=\"page-link\" href=\"" + i + "\">" + i + "</a></li>";
				}
				
				if (lastPage < totalPage) {
					str +=  "<li class=\"page-item\"><a class=\"page-link\" href=\"" + lastPage + 1 + "\">"
						+ "<i class=\"fa fa-chevron-right\" aria-hidden=\"true\"></i></a></li>";
				}
				
				str += "</ul></nav></div>";
				
				comment_list.append(str);
				comment_list.data("rnum", result.rootRnum);
			}
		});
	}
	
	function registerReply(reply, page, callback) {
		$.ajax({
			url: "/preply/insert",
			method: "POST",
			data: JSON.stringify(reply),
			contentType: "application/json;charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result, status, xhr) {
				if (callback) {
					callback(page);
				}
			}
		});
	}
	
	function deleteReply(reply, page, callback) {
		$.ajax({
			url: "/preply/delete/",
			method: "POST",
			data: JSON.stringify(reply),
			contentType: "application/json;charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result) {
				if (result == "forbidden") {
					alert("비밀번호가 맞지 않습니다.");
				}
				if (callback) {
					callback(page);
				}
			}
		});
	}
	
	$(".comment_list").on("click", ".pagination a", function(event) {
		event.preventDefault();
		
		var disabled = $(this).closest("li").data("disabled");
		
		if (disabled != "T") {
			getReplyList($(this).attr("href"));
		}
	});
	
	$(".comment_list").on("click", ".reply_btn", function(event) {
		event.preventDefault();
		
		var subReplyForm = $("#subReplyForm");
		var formStatus = subReplyForm.data("show");
		// console.log(formStatus);
		
		if (formStatus == undefined) {
			// 현재 로그인 상태 확인을 위한 정보
			var name = $("#newParentReply .col-md-12 .form-group input[name='name']").val();
			var id = $("#newParentReply .col-md-12 .form-group input[name='id']").val();
			
			var parentReply = $(this).closest(".review_item");
			var parentRnum = parentReply.data("rnum");
			var padding = parentReply.data("padding");
			padding += 28;
			
			var str = "<div id='subReplyForm' class='review_item' style='padding-left: " + padding + "px;'"
				+ "data-rnum='" + parentRnum + "' data-show='true'>"
				+ "<div class='media'><div class='media-body'>";
			
			if (name == undefined) {
				str += "<form class=\"row contact_form\"><div class=\"col-sm-12\"><div class=\"form-group\">"
					+ "<input type=\"text\" class=\"form-control\" name=\"id\""
					+ "value=\"" + id + "\" readonly=\"readonly\"></div></div>"
					+ "<div class=\"col-sm-12\"><div class=\"form-group\">"
					+ "<textarea class=\"form-control\" name=\"content\" rows=\"1\" placeholder=\"내용\" maxlength=\"200\" required></textarea>"
					+ "</div></div>";
			}
			
			else if (id == undefined) {
				str += "<form class=\"row contact_form\"><div class=\"col-sm-12\"><div class=\"form-group\">"
					+ "<input type=\"text\" class=\"form-control\" name=\"name\" placeholder=\"이름\" maxlength=\"15\" required></div></div>"
					+ "<div class=\"col-sm-12\"><div class=\"form-group\">"
					+ "<input type=\"password\" class=\"form-control\" name=\"password\" placeholder=\"비밀번호\" maxlength=\"20\" required></div></div>"
					+ "<div class=\"col-sm-12\"><div class=\"form-group\">"
					+ "<textarea class=\"form-control\" name=\"content\" rows=\"1\" placeholder=\"내용\" maxlength=\"200\" required></textarea>"
					+ "</div></div>";
			}
			
			str += "<div class=\"col-md-12 text-right\">"
				+ "<input type=\"submit\" value=\"등록\" class=\"btn btn-primary\" name=\"newSubReplyBtn\">&nbsp;"
				+ "<input type=\"button\" value=\"취소\" class=\"btn btn-secondary\" name=\"subReplyCancel\">"
				+ "</div></form></div></div><hr></div>";
			
			parentReply.after(str);
		}
		
		else {
			subReplyForm.remove();
		}
	});
	
	$(".comment_list").on("click", "input[name='subReplyCancel']", function() {
		$("#subReplyForm").remove();
	});
	
	$(".comment_list").on("click", "input[name='newSubReplyBtn']", function(event) {
		event.preventDefault();
		// console.log("New sub reply clicked");
		
		var replyForm = $("#subReplyForm").find("form");
		var parentRnum = $("#subReplyForm").data("rnum");
		var name = replyForm.find("input[name='name']").val();
		var id = replyForm.find("input[name='id']").val();
		var password = replyForm.find("input[name='password']").val();
		var content = replyForm.find("textarea[name='content']").val();
		
		var reply = new Object();
		
		if (name == undefined) {
			reply.id = id;
		}
		else if (id == undefined) {
			reply.name = name;
			reply.password = password;
		}
		reply.rnum = parentRnum;
		reply.pid = pid;
		reply.content = content;
		
		// console.log(reply);
		
		registerReply(reply, $(".pagination").data("page"), getReplyList);
	});
	
	$(".comment_list").on("click", ".delete_btn", function(event) {
		event.preventDefault();
		
		var deleteReplyForm = $("#deleteReplyForm");
		var formStatus = deleteReplyForm.data("show");
		// console.log(formStatus);
		
		if (formStatus == undefined) {
			// 현재 로그인 상태 확인을 위한 정보
			var name = $("#newParentReply .col-md-12 .form-group input[name='name']").val();
			var id = $("#newParentReply .col-md-12 .form-group input[name='id']").val();
			
			var parentReply = $(this).closest(".review_item");
			var parentRnum = parentReply.data("rnum");
			var padding = parentReply.data("padding");
			
			var str = "<div id='deleteReplyForm' class='review_item' style='padding-left: " + padding + "px;'"
				+ "data-rnum='" + parentRnum + "' data-show='true'>"
				+ "<div class='media'><div class='media-body'>";
			
			// 로그인한 회원의 댓글 삭제
			if (name == undefined) {
				str += "<div class=\"col-sm-12\"><h4>이 댓글을 삭제할까요?</h4></div>";
			}
			
			// 비로그인 사용자의 댓글 삭제
			else if (id == undefined) {
				str += "<div class=\"col-sm-12\"><h4>댓글을 삭제하려면 비밀번호를 입력하세요.</h4><div class=\"form-group\">"
					+ "<div class=\"input-group input-group-sm mb-3\"><div class=\"input-group-prepend\">"
	      			+ "<span class=\"input-group-text\" id=\"password-span\">비밀번호</span></div>"
	      			+ "<input type=\"password\" class=\"form-control\" id=\"deletePassword\" name=\"password\""
	      			+ " aria-describedby=\"password-span\" maxlength=\"20\" required>"
	      			+ "</div></div></div>";
			}
			
			str += "<div class=\"col-md-12 text-right\">"
				+ "<input type=\"button\" value=\"삭제\" class=\"btn btn-warning btn-sm\" name=\"deleteReplyBtn\">&nbsp;"
				+ "<input type=\"button\" value=\"취소\" class=\"btn btn-secondary btn-sm\" name=\"deleteReplyCancel\">"
				+ "</div></div></div><hr></div>";
			
			parentReply.after(str);
		}
		
		else {
			deleteReplyForm.remove();
		}
		
		// $("#replyModal").modal('toggle');
		/*
		var rnum = $(this).attr("href");
		
		*/
	});
	
	$(".comment_list").on("click", "input[name='deleteReplyBtn']", function() {
		// 현재 로그인 상태 확인을 위한 정보
		var name = $("#newParentReply .col-md-12 .form-group input[name='name']").val();
		var id = $("#newParentReply .col-md-12 .form-group input[name='id']").val();
		
		var reply = new Object();
		var password = $("#deletePassword").val();
		
		if (id == undefined && password == "") {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		// 비회원
		else if (id == undefined) {
			reply.password = password;
		}
		
		// 회원
		else if (name == undefined) {
			reply.id = id;
		}
		
		reply.rnum = $("#deleteReplyForm").data("rnum");
		
		deleteReply(reply, $(".pagination").data("page"), getReplyList);
	});
	
	$(".comment_list").on("click", "input[name='deleteReplyCancel']", function() {
		$("#deleteReplyForm").remove();
	});
	
	$("input[name='newReplyBtn']").on("click", function(event) {
		event.preventDefault();
		// console.log("New reply clicked");
		
		var replyForm = $("#newParentReply");
		var name = replyForm.find("input[name='name']");
		var id = replyForm.find("input[name='id']");
		var password = replyForm.find("input[name='password']");
		var content = replyForm.find("textarea[name='content']");
		
		var reply = new Object();
		
		if (name.val() == undefined) {
			reply.id = id.val();
		}
		else if (id.val() == undefined) {
			reply.name = name.val();
			reply.password = password.val();
		}
		reply.rnum = $(".comment_list").data("rnum");
		reply.pid = pid;
		reply.content = content.val();
		
		name.val("");
		password.val("");
		content.val("");
		
		// console.log(reply);
		
		registerReply(reply, 0, getReplyList);
	});
	
	$("#qty-up").on("click", function() {
		var num = qty.val();
		qty.val(++num);
	});
	
	$("#qty-dn").on("click", function() {
		var num = qty.val();
		if (num >= 2) {
			qty.val(--num);
		}
	});
	
	$(".addToCart").on("click", function(event) {
		event.preventDefault();
		
		cartProduct.quantity = qty.val();
		// console.log(cartProduct);
		
		$.ajax({
			url: "/cart/add",
			method: "POST",
			data: JSON.stringify(cartProduct),
			contentType: "application/json;charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			}
		}).done(function(result) {
			if (result == "success") {
				alert("장바구니에 추가되었습니다.");
			}
		});
		
	});
	
	$(".main_btn").on("click", function(event) {
		event.preventDefault();
		
		var str = "<input type='hidden' name='quantity' value='" + qty.val() + "'>";
		$("#cartAddList").append(str).submit();
	});
	
	$(".null_btn").on("click", function(event) {
		event.preventDefault();
	});
});
</script>

<%@ include file="../include/footer.jsp" %>