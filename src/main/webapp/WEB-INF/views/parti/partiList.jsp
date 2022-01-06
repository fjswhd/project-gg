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
			<label for="">참여자 현황</label>
			<c:if test="${empty rqList }">
				<div>작성자 아이디</div>
			</c:if>
			<c:if test="${not empty rqList }">
				<c:if test="${empty 신청 수락여부y &&신청 취소여부가 y인 리스트 }">
					<c:forEach var="parti" items="${rqList }">
						<div>
							${parti.id } <a href="partiOut.do?m_id=${parti.id }" class="btn btn-danger">강퇴</a>
						</div>
					</c:forEach>
				</c:if>
				<c:if test="${not empty 신청 수락여부y &&신청 취소여부가 y인 리스트 }">
					<c:forEach var="yy참여자" items="${yy참여자자리스트 }">
						<div>
							${yy참여자.id } 
							<a href="/partiCancelAccess?m_id=${yy참여자.id }" class="btn btn-primary">수락</a>
							<a href="/partiCancelReject?m_id=${yy참여자.id }" class="btn btn-danger">거절</a>
						</div>
					</c:forEach>
				</c:if>
				
			</c:if>

		</div>
	</div>

</body>
</html>