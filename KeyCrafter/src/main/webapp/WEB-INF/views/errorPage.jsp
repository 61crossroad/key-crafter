<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" import="java.util.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Error Page</title>
<style>
	.container {
		width: 100%;
		padding: 10% 0%;
		text-align: center;
	}
</style>
</head>
<body>
	<div class="container">
			<h1>"오류가 발생했습니다."</h1>
			<h2>관리자에게 문의하세요.</h2>
	<!-- 
	<h4><c:out value="${ exception.getMessage() }"></c:out></h4>

	<ul>
		<c:forEach items="${ exception.getStackTrace() }" var="stack">
			<li><c:out value="${ stack }"/></li>
		</c:forEach>
	</ul>
	-->
	</div>
</body>
</html>