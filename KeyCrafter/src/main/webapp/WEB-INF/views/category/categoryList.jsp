<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!--========================= Category List Side Bar ============================== -->
<div class="left_sidebar_area">
	<aside class="left_widgets cat_widgets">
		<div class="l_w_title col">
			<h3>카테고리
				<a href="#" style="float: right;">
					<button id="insertFormBtn" class="btn btn-primary">추가</button>
				</a>
			</h3>
		</div>
		<div class="widgets_inner">
			<ul class="list">
			</ul>
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
	
	// List category when a page is loaded
	getCatList();
	
	// select categories except default(1st) category which is 'empty' via REST 
	function getCatList() {
		$.getJSON("/category/list", function(data) {
			var str = "";
			$(".widgets_inner .list").html("");
			
			$.each(data, function(i, obj) {
				if (i) {
					str += "<li data-catnum='" + obj.catNum + "'>" + obj.catName;
					str += "<span style='margin-left: 1em;'><i class='fa fa-pencil' data-action='modify' data-catnum='" + obj.catNum +
						"' data-catname='" + obj.catName + "'></i></span>";
					str += "<span style='margin-left: 1em;'><i class='fa fa-remove' data-action='delete' data-catnum='" + obj.catNum +
						"' data-catname='" + obj.catName + "'></i></span></li>";
				}
			});
			
			$(".widgets_inner .list").append(str);
		});
	}
	
	$(".widgets_inner .list").on("click", "i", function() {
		var obj = $(event.target);
		var action = obj.data("action");
		var catNum = obj.data("catnum");
		var curCatName = obj.data("catname");
		var catModal = $("#categoryModal");
		var title = $(".modal-title");
		var insertBtn = $(".modal-footer #insertBtn");
		var updateBtn = $(".modal-footer #updateBtn");
		var deleteBtn = $(".modal-footer #deleteBtn");
		
		catModal.find(".modal-body #curCatName").val(curCatName).attr("type", "text").attr("readonly", true);
		catModal.find(".modal-body #catNum").val(catNum);
		insertBtn.attr("type", "hidden");
		
		
		if (action == "delete") {
			title.text("카테고리 삭제");
			catModal.find(".modal-body #catName").attr("type", "hidden");
			deleteBtn.attr("type", "button");
			updateBtn.attr("type", "hidden");
			console.log(updateBtn);
		}
		
		else if (action == "modify") {
			title.text("카테고리 수정");
			catModal.find(".modal-body #catName").attr("type", "text").val("");
			updateBtn.attr("type", "button");
			deleteBtn.attr("type", "hidden");
		}

		catModal.modal("show");
		
	});
	$("#insertFormBtn").on("click", function() {
		var catModal = $("#categoryModal");
		var title = $(".modal-title");
		var insertBtn = $(".modal-footer #insertBtn");
		var updateBtn = $(".modal-footer #updateBtn");
		var deleteBtn = $(".modal-footer #deleteBtn");
		
		title.text("카테고리 추가");
		catModal.find(".modal-body #curCatName").attr("type", "hidden");
		catModal.find(".modal-body #catName").attr("type", "text").val("");
		insertBtn.attr("type", "button");
		updateBtn.attr("type", "hidden");
		deleteBtn.attr("type", "hidden");
		
		catModal.modal("show");
	});
	
	$("#insertBtn").on("click", function() {
		console.log("Insert clicked");
		
		var catName = $("#catName").val();
		
		$.ajax({
			url: "/category/insert",
			method: "POST",
			data: catName,
			contentType: "text/plain; charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function() {
				getCatList();
				$("#categoryModal").modal("hide");
			}
		});
	});
	
	$("#updateBtn").on("click", function() {
		console.log("Update clicked");
		
		var catNum = $("#catNum").val();
		var catName = $("#catName").val();
		
		$.ajax({
			url: "/category/update",
			method: "PUT",
			data: JSON.stringify({catNum: catNum, catName: catName}),
			contentType: "application/json; charset=utf-8",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function() {
				getCatList();
				$("#categoryModal").modal("hide");
			}
		});
	});
	
	$("#deleteBtn").on("click", function() {
		var catNum = $("#catNum").val();
		
		$.ajax({
			url: "/category/delete/" + catNum,
			method: "DELETE",
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function() {
				getCatList();
				$("#categoryModal").modal("hide");
			}
		});
	});
});
</script>