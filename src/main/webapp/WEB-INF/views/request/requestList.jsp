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
			<label for="">신청자 현황</label>
			<!--신청자가 없을 때-->
			<c:if test="${empty rqList }">
				<div>신청자가 없습니다.</div>
			</c:if>
			<!--신청자가 있을 때 기본 페이지-->
			<%-- <c:if test="${세션아이디 != 작성자 아이디 }"> --%>
				<c:if test="${not empty rqList }">
					<c:forEach var="request" items="${rqList }">
						<div>
							<div>${request.m_id }</div>
						</div>
					</c:forEach>
					<div>
						<a href="/request" class="btn btn-success">신청하기</a>
					</div>
				</c:if>
			<%-- </c:if> --%>
			<!--신청자가 있을 때 작성자 페이지-->
			<%-- <c:if test="${세션아이디 == 작성자 아이디 }"> --%>
				<c:if test="${not empty rqList }">
					<c:forEach var="request" items="${rqList }">
						<div>
							<div>
								${request.m_id }님이 모임에 들어오기를 원합니다. 
								<a href="/requestAccept/${request.m_id }" class="btn btn-primary">수락</a> 
								<a href="requestReject/${request.m_id }" class="btn btn-danger">거절</a>
							</div>
						</div>
					</c:forEach>
				</c:if>
			<%-- </c:if> --%>
		</div>
	</div>

</body>
</html>