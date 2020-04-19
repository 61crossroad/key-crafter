<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/header.jsp" %>

<!--================Single Product Area =================-->
	<div class="product_image_area">
		<div class="container">
			<div class="row s_product_inner">
				<div class="col-lg-6">
					<div class="s_product_img">
						<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
							<ol class="carousel-indicators">
								<li data-target="#carouselExampleIndicators" data-slide-to="0" class="active">
									<img src="/resources/img/product/single-product/s-product-s-2.jpg" alt="">
								</li>
								<li data-target="#carouselExampleIndicators" data-slide-to="1">
									<img src="/resources/img/product/single-product/s-product-s-3.jpg" alt="">
								</li>
								<li data-target="#carouselExampleIndicators" data-slide-to="2">
									<img src="/resources/img/product/single-product/s-product-s-4.jpg" alt="">
								</li>
							</ol>
							<div class="carousel-inner">
								<div class="carousel-item active">
									<img class="d-block w-100" src="/resources/img/product/single-product/s-product-1.jpg" alt="First slide">
								</div>
								<div class="carousel-item">
									<img class="d-block w-100" src="/resources/img/product/single-product/s-product-1.jpg" alt="Second slide">
								</div>
								<div class="carousel-item">
									<img class="d-block w-100" src="/resources/img/product/single-product/s-product-1.jpg" alt="Third slide">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-5 offset-lg-1">
					<div class="s_product_text">
						<h3>Faded SkyBlu Denim Jeans</h3>
						<h2>$149.99</h2>
						<ul class="list">
							<li>
								<a class="active" href="#">
									<span>분류</span> : Household</a>
							</li>
							<li>
								<a href="#">
									<span>재고 상태</span> : In Stock</a>
							</li>
						</ul>
						<p>Mill Oil is an innovative oil filled radiator with the most modern technology. If you are looking for something that
							can make your interior look awesome, and at the same time give you the pleasant warm feeling during the winter.</p>
						<div class="product_count">
							<label for="qty">수량:</label>
							<input type="text" name="qty" id="sst" maxlength="12" value="1" title="Quantity:" class="input-text qty">
							<button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst )) result.value++;return false;"
							 class="increase items-count" type="button">
								<i class="lnr lnr-chevron-up"></i>
							</button>
							<button onclick="var result = document.getElementById('sst'); var sst = result.value; if( !isNaN( sst ) &amp;&amp; sst > 0 ) result.value--;return false;"
							 class="reduced items-count" type="button">
								<i class="lnr lnr-chevron-down"></i>
							</button>
						</div>
						<div class="card_area">
							<a class="main_btn" href="#">주문하기</a>
							<a class="icon_btn" href="#">
								<i class="lnr lnr lnr-cart"></i>
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
					<a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">댓글 보기</a>
				</li>
			</ul>
			<div class="tab-content" id="myTabContent">
				<div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
					<p>Beryl Cook is one of Britain’s most talented and amusing artists .Beryl’s pictures feature women of all shapes and sizes
						enjoying themselves .Born between the two world wars, Beryl Cook eventually left Kendrick School in Reading at the
						age of 15, where she went to secretarial school and then into an insurance office. After moving to London and then
						Hampton, she eventually married her next door neighbour from Reading, John Cook. He was an officer in the Merchant
						Navy and after he left the sea in 1956, they bought a pub for a year before John took a job in Southern Rhodesia with
						a motor company. Beryl bought their young son a box of watercolours, and when showing him how to use it, she decided
						that she herself quite enjoyed painting. John subsequently bought her a child’s painting set for her birthday and it
						was with this that she produced her first significant work, a half-length portrait of a dark-skinned lady with a vacant
						expression and large drooping breasts. It was aptly named ‘Hangover’ by Beryl’s husband and</p>
					<p>It is often frustrating to attempt to plan meals that are designed for one. Despite this fact, we are seeing more and
						more recipe books and Internet websites that are dedicated to the act of cooking for one. Divorce and the death of
						spouses or grown children leaving for college are all reasons that someone accustomed to cooking for more than one
						would suddenly need to learn how to adjust all the cooking practices utilized before into a streamlined plan of cooking
						that is more efficient for one person creating less</p>
				</div>
				
				<div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
					<div class="row">
						<div class="col-lg-6">
							<div class="comment_list">
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/resources/img/product/single-product/review-1.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2017 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
										aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
								</div>
								<div class="review_item reply">
									<div class="media">
										<div class="d-flex">
											<img src="/resources/img/product/single-product/review-2.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2017 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
										aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
								</div>
								<div class="review_item">
									<div class="media">
										<div class="d-flex">
											<img src="/resources/img/product/single-product/review-3.png" alt="">
										</div>
										<div class="media-body">
											<h4>Blake Ruiz</h4>
											<h5>12th Feb, 2017 at 05:56 pm</h5>
											<a class="reply_btn" href="#">Reply</a>
										</div>
									</div>
									<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna
										aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo</p>
								</div>
							</div>
						</div>
						<div class="col-lg-6">
							<div class="review_box">
								<h4>의견을 적어주세요!</h4>
								<form class="row contact_form" action="contact_process.php" method="post" id="contactForm">
									<div class="col-md-12">
										<div class="form-group">
											<input type="text" class="form-control" id="name" name="name" placeholder="이름" required>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<input type="password" class="form-control" id="password" name="password" placeholder="비밀번호" required>
										</div>
									</div>
									<div class="col-md-12">
										<div class="form-group">
											<textarea class="form-control" name="message" id="message" rows="1" placeholder="내용" required></textarea>
										</div>
									</div>
									<div class="col-md-12 text-right">
										<button type="submit" value="submit" class="btn submit_btn">등록</button>
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

<%@ include file="../include/footer.jsp" %>