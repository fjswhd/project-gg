<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h2>나의 작성글</h2>
		<table class="table table-bordered">
			<tr>
				<th>활동명</th>
			</tr>
			<c:forEach var="boards" items="${myBoardList}">
				<tr>
					<th><a href="${_board}/detail.do?b_no=${boards.b_no}">${boards.subject}</a></th>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>