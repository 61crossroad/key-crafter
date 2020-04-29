<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp" %>
<%@ include file="../include/modal.jsp" %>

<section class="cat_product_area mt-xl mb-60">
	<div class="container-fluid">
		<div class="row flex-row-reverse">
			<div class="col-lg-9">
				<h3 class="mb-30 title_color">상품 등록</h3>
				<form action="/product/insert" method="post" role="form">
					<div class="form-group row">
						<label for="pName" class="col-sm-2 col-form-label single-label"><h5>상품명</h5></label>
						<div class="col-sm-10">
							<input type="text" class="form-control" name="pName" id="pName" maxlength="50" required>
						</div>
					</div>
					<div class="form-group row justify-content-start">
						<label for="price" class="col-sm-2 single-label"><h5>가격</h5></label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="price" id="price" maxlength="10" required>
						</div>
						<label for="quantity" class="col-sm-2 single-label"><h5>수량</h5></label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="quantity" id="quantity" maxlength="10" required>
						</div>
					</div>
					<div class="form-group row justify-content-start">
						<label for="company" class="col-sm-2 single-label"><h5>제조사</h5></label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="company" id="company" maxlength="50">
						</div>
						<label for="madeIn" class="col-sm-2 single-label"><h5>제조국</h5></label>
						<div class="col-sm-4">
							<input type="text" class="form-control" name="madeIn" id="madeIn" maxlength="20">
						</div>
					</div>
					<div class="form-group row justify-content-start">
						<label id="addCategory" class="col-sm-2 single-label">
							<a href="#"><h5>카테고리&nbsp;<i class="fa fa-plus"></i></h5></a>
						</label>
						<div class="col-sm-10">
							<div id="categoryList" class="row justify-content-start">
							</div>
						</div>
					</div>						
					<div class="form-group row">
						<label for="productDesc" class="single-label"><h5>상품 설명</h5></label>
						<textarea class="form-control" name="productDesc" id="productDesc" rows="5"></textarea>
					</div>
					<div class="form-group form-button">
						<div class="row">
							<input type="submit" value="등록" class="btn btn-primary">&nbsp;&nbsp;
							<input type="reset" value="삭제" class="btn btn-warning">&nbsp;&nbsp;
							<input type="button" value="뒤로" class="btn btn-secondary" onclick="history.back()">
						<!--
							<input type="submit" class="genric-btn info small" value="등록">&nbsp;&nbsp;
							<input type="reset" class="genric-btn primary" value="삭제">&nbsp;&nbsp;
							<input type="button" onclick="history.back()" class="genric-btn success" value="뒤로">
						-->
						</div>
						
					</div>
					<input type="hidden" name="page" value="${ cri.page }">
					<input type="hidden" name="show" value="${ cri.show }">
					<input type="hidden" name="type" value="${ cri.type }">
					<input type="hidden" name="keyword" value="${ cri.keyword }">
					
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
				</form>
				
				<div class="form-group row mt-25 justify-content-start">
					<div class="col-sm-2 single-label">
					<!-- <h3 class="title_color">이미지 파일</h3> -->
						<h5>이미지 파일</h5>
					</div>
					<!-- <div class="uploadDiv row"> -->
					<div class="uploadDiv col-sm-10">
						<input type="file" class="form-control-file" name="productAttach" id="productAttach" style="padding: 5px 0px 0px 0px;" multiple required>
					</div>
					<div class="uploadResult row justify-content-around mt-25">
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<%@ include file="../category/categoryList.jsp" %>
			</div>
		</div>
	</div>
</section>
<!--================End Category Product Area =================-->

<script type="text/javascript">
$(document).ready(function() {
	var formObj = $("form[role = 'form']");
	var cloneObj = $(".uploadDiv").clone();
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var resultPid = '<c:out value="${result}"/>';
	
	toggleModal(resultPid);
	
	// 상품 등록 후 모달 창 생성 
	function toggleModal(result) {
		console.log("resultPid: " + result);
		if (result > 0) {
			$("#resultCenter .modal-body").html(parseInt(result) + "번 상품이 등록되었습니다.");
			$("#resultCenter").modal("show");
		}
		else {
			return;
		}
	}
	
	// 카테고리 목록 추가
	$("#addCategory").on("click", function() {
		$.getJSON("/category/list", function(data) {
			var str = "<div class='col-sm-3 default-select'><select>";
			
			for (var i = 1; i < data.length; i++) {
				str += "<option value='" + data[i].catNum + "'>" + data[i].catName + "</option>";
			}
			
			str += "</select>&nbsp;<i class='fa fa-close'></i></div>";
			$("#categoryList").append(str);
		});
		
		console.log($("#categoryList select"));
	});
	
	// 카테고리 삭제
	$("#categoryList").on("click", "i", function() {
		console.log("category delete clicked");
		var targetDiv = $(this).closest("div");
		console.log(targetDiv);
		targetDiv.remove();
	});
	
	// 첨부파일 확장자 확인, 이미지 파일만 가능
	function checkExtension(fileName, fileSize) {
		var regExp = new RegExp("(.*?)\.(jpg|jpeg|png|gif|bmp)$");
		var maxSize = 20971520; // 5MB
		
		if (maxSize < fileSize) {
			alert("파일 용량 초과");
			$(".uploadDiv").html(cloneObj.html());
			return false;
		}
		
		if (!regExp.test(fileName)) {
			alert("이미지 파일만 업로드할 수 있습니다");
			$(".uploadDiv").html(cloneObj.html());
			return false;
		}
		
		return true;
	}
	
	// file 필드에 파일이 선택되면 임시로 파일 업로드
	$("input[type = 'file']").on("change", function(e) {
		var formData = new FormData();
		var inputFile = $("input[name = 'productAttach']");
		var files = inputFile[0].files;
		
		for (var i = 0; i < files.length; i++) {
			if (!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			
			formData.append("uploadFile", files[i]);
			console.log(formData);
		}

		$.ajax({
			url: '/uploadAjaxAction',
			type: 'post',
			processData: false,
			contentType: false,
			data: formData,
			dataType: 'json',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result) {
				console.log(result);
				showUploadResult(result);
				$(".uploadDiv").html(cloneObj.html());
				// $(".uploadDiv").replaceWith(cloneObj);
			}
		});
	});
	
	// 임시로 파일 업로드 후 확인과 삭제를 위한 div 생성
	function showUploadResult(result) {
		if (!result || result.length == 0) {
			return;
		}
		
		var uploadResult = $(".uploadResult");
		var str = "";
		
		$(result).each(function(i, obj) {
			var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
			str += "<div class='col-1' data-uuid='" + obj.uuid + "' data-uploadpath='" + obj.uploadPath +
					"' data-filename='" + obj.fileName + "'><img src='/show?fileName=" + fileCallPath +
					"'><span data-file='" + fileCallPath + "'><i class='fa fa-remove'></i></span></div>";
		});
		
		uploadResult.append(str);
	}
	
	// 임시 업로드 파일 삭제
	$(".uploadResult").on("click", "span", function() {
		var fileName = $(this).data("file");
		var targetDiv = $(this).closest("div");
		
		console.log("Delete file: " + fileName);
		
		$.ajax({
			url: '/deleteFile',
			type: 'post',
			data: {"fileName": fileName},
			dataType: 'text',
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(result) {
				result = decodeURIComponent(result);
				alert(result);
				targetDiv.remove();
			}
		});
	});
	
	// 등록 form에 첨부파일과 카테고리 추가 후 submit
	$("input[type = 'submit']").on("click", function(e) {
		e.preventDefault();
		
		var str="";
		$(".uploadResult div").each(function(i, obj) {
			var jobj = $(obj);
			
			str += "<input type='hidden' name='attachList[" + i + "].uuid' value='" + jobj.data("uuid") + "'>";
			str += "<input type='hidden' name='attachList[" + i + "].uploadPath' value='" + jobj.data("uploadpath") + "'>";
			str += "<input type='hidden' name='attachList[" + i + "].fileName' value='" + jobj.data("filename") + "'>";
			str += "<input type='hidden' name='attachList[" + i + "].mainImage' value='" + (i ? 'F' : 'T') + "'>";
		});
		
		$("#categoryList select").each(function(i, obj) {
			var jobj = $(obj);
			var target = jobj.children("option:selected");
			
			str += "<input type='hidden' name='categoryList[" + i + "].catNum' value='" + jobj.children("option:selected").val() + "'>";
			str += "<input type='hidden' name='categoryList[" + i + "].catName' value='" + jobj.children("option:selected").text() + "'>";
		});
		
		formObj.append(str).submit();
	});
});
</script>

<%@ include file="../include/footer.jsp" %>