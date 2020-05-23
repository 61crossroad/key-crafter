<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--========================== Category Search Form =============================== -->
<form id="categoryForm" action="/product/list" method="GET">
	<input type="hidden" name="page" value="${ pageMaker.cri.page }">
	<input type="hidden" name="show" value="${ pageMaker.cri.show }">
	<input type="hidden" name="cat" value="${ pageMaker.cri.cat }">
	<c:forEach items="${ pageMaker.cri.keyword }" varStatus="status">
		<input type="hidden" name="type" value="${ pageMaker.cri.type[status.index] }">
		<input type="hidden" name="keyword" value="${ pageMaker.cri.keyword[status.index] }">
	</c:forEach>
</form>

<!--========================= Category List Side Bar ============================== -->
<div class="left_sidebar_area">
	<aside class="left_widgets cat_widgets">
		<div class="l_w_title col">
			<h3>카테고리
			</h3>
		</div>
		<div class="widgets_inner">
			<!-- Categories will be listed here -->
		</div>
	</aside>
</div>
<!--========================= End Category List Side Bar ========================== -->

<!--========================= Category Modify Modal =============================== -->
<div class="modal fade" id="categoryModal" tabindex="-1" role="dialog" aria-labelledby="categoryModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="categoryModalLabel">Key Crafter</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form>
          <div class="form-group">
            <label for="curCatName" class="col-form-label">카테고리:</label>
            <input type="text" id="curCatName" class="form-control">
          </div>
          <div class="form-group">
            <input type="text" id="catName" class="form-control" placeholder="새 이름">
            <input type="hidden" id="catNum">
          </div>
        </form>
      </div>
      <div class="modal-footer">
      	<input type="button" value="추가" id="insertBtn" class="btn btn-primary">
      	<input type="button" value="수정" id="updateBtn" class="btn btn-info">
      	<input type="button" value="삭제" id="deleteBtn" class="btn btn-warning">
        <input type="button" value="취소" class="btn btn-secondary" data-dismiss="modal">
      </div>
    </div>
  </div>
</div>
<!--====================== End Category Modify Modal ============================== -->

<script type="text/javascript">
$(document).ready(function (){
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	var cat = "${ pageMaker.cri.cat }";
	console.log("Selected Cat: " + cat);
	
	// List category when a page is loaded
	getCatList();
	
	// Get category list via REST GET method
	function getCatList() {
		$.getJSON("/category/list?cat=1&all=1", function(data) {
			var depth = 0;
			var str = "";
			// $(".widgets_inner").html("");
			
			for (var i = 1; i < data.length; i++) {
				if (depth < data[i].depth) {
					depth = data[i].depth;
					str += "<ul class='list'>";
				}
				else if (depth > data[i].depth) {
					for (var j = data[i].depth; j < depth; j++) {
						str += "</li></ul>";
					}
					str += "</li>";
					depth = data[i].depth;
				}
				else {
					str += "</li>";
				}
				
				
				if (data[i].catNum == cat) {
					str += "<li><a class='categoryMove' href='" + data[i].catNum + "'><b>" + data[i].catName + "</b></a>";
				}
				else {
					str += "<li><a class='categoryMove' href='" + data[i].catNum + "'>" + data[i].catName + "</a>";
				}
				
				if (i + 1 < data.length && depth < data[i + 1].depth) {
					str += "&nbsp;&nbsp;<a class='subList' href='#'><i class='fa fa-chevron-down'></i></a>";
				}
			}
			
			for (var i = 0; i < depth; i++) {
				str += "</li></ul>";
			}
			
			$(".widgets_inner").append(str);
		});
	}
	
	$(".widgets_inner").on("click", ".subList", function(event) {
		event.preventDefault();
		console.log("icon clicked");
		$(this).closest("li").children("ul").toggle();
	});
	
	$(".widgets_inner").on("click", ".categoryMove", function(event) {
		console.log("category clicked");
		event.preventDefault();
		
		var categoryForm = $("#categoryForm");
		// console.log($(this));
		categoryForm.find("input[name = 'cat']").val($(this).attr("href"));
		
		console.log(categoryForm.find("input[name = 'cat']").val());
		
		categoryForm.submit();
	});
});
</script>