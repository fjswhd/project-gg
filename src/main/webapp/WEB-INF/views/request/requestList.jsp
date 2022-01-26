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
			<div>신청자 목록<div>
			<c:if test="${empty rqList }">
				<div>신청자가 없습니다.</div>
				<div><a href="request.do?b_no=1&m_id=b" class="btn btn-success">신청하기</a></div> 
			</c:if>
			<c:if test="${not empty rqList }">
				<c:forEach var="request" items="${rqList }">
					<div>
						<div>${request.m_id }</div>
					</div>
				</c:forEach>  
				<div>
					<!--  -->
					<%-- <c:if test="세션아이디==${request.m_id }">
						<a href="requestCancel.do?b_no=1&m_id=f"class="btn btn-success">신청 취소하기</a>
					</c:if>
					<c:if test="세션아이디!=${request.m_id }">
						<a href="request.do?b_no=1&m_id=f"class="btn btn-success">신청하기</a>
					</c:if>
					 --%>
					<a href="request.do?b_no=1&m_id=f"class="btn btn-success">신청하기</a>
					<a href="requestCancel.do?b_no=1&m_id=d"class="btn btn-success">신청 취소하기</a>
				</div>
			  
			</c:if>   
			<!--신청자가 있을 때 작성자 페이지-->
			<%-- <c:if test="${세션아이디 == 작성자 아이디 }"> --%>
				<c:if test="${not empty rqList }">
					<c:forEach var="request" items="${rqList }">
						<div>
							<div>
								${request.m_id }
								           <!--  int b_no은 board의 b_no --> 
								<a href="requestAccept.do?b_no=1&m_id=${request.m_id }" class="btn btn-primary">수락</a> 
								<a href="requestReject.do?b_no=1&m_id=${request.m_id }" class="btn btn-danger">거절</a>
							</div>
						</div>
					</c:forEach>
				</c:if>
			<%-- </c:if> --%>
		</div>
	</div>

</body>
</html>