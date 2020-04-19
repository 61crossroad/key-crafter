<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ include file="include/header.jsp" %>

<div class="whole-wrap">
	<div class="container">
		<div class="section-top-border">
			<h3 class="mt-lg mb-30 title_color">주문내역</h3>
			<div class="progress-table-wrap">
			    <div class="progress-table">
			        <div class="table-head">
			            <div class="serial">#</div>
			            <div class="country">Countries</div>
			            <div class="visit">Visits</div>
			            <div class="percentage">Percentages</div>
			        </div>
			        <div class="table-row">
			            <div class="serial">01</div>
			            <div class="country">
			                <img src="/resources/img/elements/f1.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-1" role="progressbar" style="width: 10%" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <!--
			        <div class="table-row">
			            <div class="serial">02</div>
			            <div class="country">
			                <img src="/resources/img/elements/f2.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-2" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">03</div>
			            <div class="country">
			                <img src="/resources/img/elements/f3.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-3" role="progressbar" style="width: 55%" aria-valuenow="55" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">04</div>
			            <div class="country">
			                <img src="/resources/img/elements/f4.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-4" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">05</div>
			            <div class="country">
			                <img src="/resources/img/elements/f5.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-5" role="progressbar" style="width: 40%" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">06</div>
			            <div class="country">
			                <img src="/resources/img/elements/f6.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-6" role="progressbar" style="width: 70%" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">07</div>
			            <div class="country">
			                <img src="/resources/img/elements/f7.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-7" role="progressbar" style="width: 30%" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        <div class="table-row">
			            <div class="serial">08</div>
			            <div class="country">
			                <img src="/resources/img/elements/f8.jpg" alt="flag">Canada</div>
			            <div class="visit">645032</div>
			            <div class="percentage">
			                <div class="progress">
			                    <div class="progress-bar color-8" role="progressbar" style="width: 60%" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100"></div>
			                </div>
			            </div>
			        </div>
			        -->
			        <nav class="blog-pagination justify-content-center d-flex">
						<ul class="pagination">
						    <li class="page-item">
						        <a href="#" class="page-link" aria-label="Previous">
						            <span aria-hidden="true">
						                <span class="lnr lnr-chevron-left"></span>
						            </span>
						        </a>
						    </li>
						    <li class="page-item">
						        <a href="#" class="page-link">01</a>
						    </li>
						    <li class="page-item active">
						        <a href="#" class="page-link">02</a>
						    </li>
						    <li class="page-item">
						        <a href="#" class="page-link">03</a>
						    </li>
						    <li class="page-item">
						        <a href="#" class="page-link">04</a>
						    </li>
						    <li class="page-item">
						        <a href="#" class="page-link">09</a>
						    </li>
						    <li class="page-item">
						        <a href="#" class="page-link" aria-label="Next">
						            <span aria-hidden="true">
						                <span class="lnr lnr-chevron-right"></span>
						            </span>
						        </a>
						    </li>
						</ul>
					</nav>
			    </div>
			</div>
		</div>
	</div>
</div>
	
<%@ include file="include/footer.jsp" %>