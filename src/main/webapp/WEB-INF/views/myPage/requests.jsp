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
		<h2>나의 신청</h2>
		<table class="table table-bordered">
			<tr>
				<th>활동명</th>
				<th>신청 현황</th>
			</tr>
			<c:forEach var="requests" items="${myRequestList}">
				<tr>
					<th><a href="${_board}/detail.do?b_no=${requests.b_no}">${requests.board.subject}</a></th>
					<th>${requests.accept }</th>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>