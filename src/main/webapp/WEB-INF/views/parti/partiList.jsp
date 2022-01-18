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
	<div align="center">
		<div>
			<div>참여자 목록</div>
			<c:if test="${empty ptList }">
				<div>a</div>
			</c:if>
			<c:if test="${not empty ptList }">
				<div>
					a
					<!-- 작성자 아이디 -->
				</div>
				<c:forEach var="parti" items="${ptList }">
					<div>
						${parti.m_id } <a href="partiOut.do?b_no=1&m_id=${parti.m_id }"
							class="btn btn-danger">강퇴</a>
					</div>
				</c:forEach>
					<a href="partiCancel.do?b_no=1&m_id=c"class="btn btn-danger">탈퇴 신청</a>
					<a href="partiReCancel.do?b_no=1&m_id=c"class="btn btn-danger">탈퇴 신청 취소</a>
			</c:if>
				<c:if test="${not empty ptCancelList }">
					<c:forEach var="parti" items="${ptCancelList }">
						<div>
						${parti.m_id }님이 탈퇴 신청하였습니다. 
						<a href="partiCancelAccess.do?b_no=1&m_id=${parti.m_id }" class="btn btn-primary">수락</a>
						<a href="partiCancelReject.do?b_no=1&m_id=${parti.m_id }" class="btn btn-danger">거절</a>
					</div>
					</c:forEach>
				</c:if>
		</div>
	</div>
</body>
</html>