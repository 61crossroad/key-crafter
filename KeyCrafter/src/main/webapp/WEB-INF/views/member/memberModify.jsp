<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="../include/header.jsp"%>

<div class="whole-wrap mb-30">
	<div class="container">
		<div class="section-top-border">
			<div class="row mt-lg">
				<div class="col-lg-8 col-md-8">
					<h3 class="mb-30 title_color">회원 정보</h3>
					
					<form action="/member/modify" method="post">
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user" aria-hidden="true"></i>
							</div>
							<input type="text" name="id" id="id" class="single-input"
								value="<c:out value="${ member.id }"/>" readonly="readonly">
						</div>
						<div class="mt-10 ml-20">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="password" class="single-input"
							placeholder="비밀번호 수정" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 수정'"
							maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-lock" aria-hidden="true"></i>
							</div>
							<input type="password" name="rePassword" class="single-input"
							placeholder="비밀번호 확인" onfocus="this.placeholder = ''" onblur="this.placeholder = '비밀번호 확인'"
							maxlength="16">
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-user-md" aria-hidden="true"></i>
							</div>
							<input type="text" name="name" class="single-input"
							value="<c:out value="${ member.name }"/>"
							maxlength="30" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-envelope-o" aria-hidden="true"></i>
							</div>
							<input type="email" name="email" placeholder="이메일" class="single-input"
							value="<c:out value="${ member.email }"/>"
							maxlength="40" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-phone" aria-hidden="true"></i>
							</div>
							<input type="text" name="contact" placeholder="전화번호" class="single-input"
							value="<c:out value="${ member.contact }"/>"
							maxlength="20" required >
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-map-marker" aria-hidden="true"></i>
							</div>
							<input type="text" name="address" class="single-input"
							value="<c:out value="${ member.address }"/>"
							maxlength="100" required>
						</div>
						<div class="input-group-icon mt-10">
							<div class="icon">
								<i class="fa fa-plane" aria-hidden="true"></i>
							</div>
							<input type="text" name="zipCode" class="single-input"
							value="<c:out value="${ member.zipCode }"/>"
							maxlength="10" required >
						</div>
						<div class="input-group mt-10">
							<div class="input-group-prepend">
								<label class="single-input" for="auth" style="color: #000000;">
									<i class="fa fa-tasks" aria-hidden="true" style="color: #60686f;"></i>
									<span style="margin-left: 8px;">회원 등급</span>
								</label>
							</div>
							<input type="hidden" name="authList[0].id" value="${ member.authList[0].id }">
							<select id="auth" name="authList[0].auth">
								<c:set var="auth" value="${ member.authList[0].auth }"/>
								<option value="ROLE_ADMIN" ${ auth eq "ROLE_ADMIN" ? "selected" : "" }>관리자</option>
								<option value="ROLE_MEMBER" ${ auth eq "ROLE_MEMBER" ? "selected" : "" }>운영자</option>
								<option value="ROLE_USER" ${ auth eq "ROLE_USER" ? "selected" : "" }>일반 회원</option>
							</select>		
						</div>
						<div class="input-group justify-content-center mt-sm">
							<a href="javascript: window.history.back();">
								<input type="button" class="genric-btn success" value="돌아가기">
							</a>&nbsp;
							<input type="submit" class="genric-btn info" value="정보 수정">
						</div>
						
						<input type="hidden" name="page" value="${ cri.page }">
						<input type="hidden" name="show" value="${ cri.show }">
						<input type="hidden" name="cat" value="${ cri.cat }">
						<c:forEach items="${ cri.keyword }" varStatus="status">
							<input type="hidden" name="type" value="${ cri.type[status.index] }">
							<input type="hidden" name="keyword" value="${ keyword[status.index] }">
						</c:forEach>
						
						<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }">
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>