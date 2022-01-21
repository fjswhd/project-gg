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
		<h2>나의 활동</h2>
		<table class="table table-bordered">
			<tr>
				<th>활동명</th>
				<th>활동 상태</th>
				<th>별점</th>
				<th>상호 평가</th>
			</tr>
			<c:forEach var="partis" items="${myPartiList}">
				<tr>
					<th><a href="${_board}/detail.do?b_no=${partis.b_no}">${partis.board.subject}</a></th>
					<th><c:if test="${partis.cancel == 'y' }">
													탈퇴
												</c:if> <c:if test="${partis.ban == 'y' }">
													강퇴
												</c:if> <c:if
							test="${today < partis.board.s_date && partis.cancel != 'y' && partis.ban != 'y'}">
													활동 예정											
												</c:if> <c:if
							test="${partis.board.s_date <= today && today < partis.board.e_date && partis.cancel != 'y' && partis.ban != 'y'}">
													활동 중											
												</c:if> <c:if
							test="${today > partis.board.s_date && partis.cancel != 'y' && partis.ban != 'y'}">
													활동 종료											
												</c:if></th>
					<%-- <th><c:forEach var="rating" items="${member}">${member.rating }</c:forEach></th> --%>
					<%-- <th><c:forEach var="eval" items="${member}">${member.rating }</c:forEach></th> --%>
				</tr>
			</c:forEach>
		</table>
	</div>
</body>
</html>