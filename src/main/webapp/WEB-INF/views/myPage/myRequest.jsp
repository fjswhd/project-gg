<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>같이 가치</title>
</head>
<body>
	<div class="container flex-column no-scroll" style="overflow-y: auto;">
		<!-- head -->
		<c:if test="${ empty sessionScope.member }">
			<script type="text/javascript">
				location.href = '${_}/error.do';
			</script>		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div id="body" class="col-md-11 box" style="position:absolute; top: 20%; left: 50%; height: 75%; transform: translate(-50%, 0);">
			<!-- 공지사항 -->
			<div class="flex-column pd-b-15">
				<h2 class="align-center mg-l-15">
					<strong>나의 신청</strong>
				</h2>
				<div id="myBoard">
					<ul class="list-group mg-t-10 mg-b-5">
						<li class="list-group-item align-center">
							<span class="col-md-6 bold">
								활동명											
							</span>
							<span class="col-md-6 bold">
								신청 상태											
							</span>
						</li>
						
						<c:forEach var="request" items="${myRequestList}">
							<li class="list-group-item align-center">
								<span class="col-md-6 ellipsis">
									<a href="${_board}/detail.do?b_no=${request.b_no}" class="cursor">[${request.board.category.c_name}] ${request.board.subject}</a>
								</span>
								<c:if test="${request.accept == 'w' && request.cancel == 'n'}">
									<span class="col-md-6 text-muted">신청 처리 대기 중입니다.</span>								
								</c:if>
								<c:if test="${request.accept == 'n'}">
									<span class="col-md-6 text-danger"><strong>신청이 거절되었습니다.</strong></span>												
								</c:if>
								<c:if test="${request.cancel == 'y'}">
									<span class="col-md-6 text-danger"><strong>신청을 취소했습니다.</strong></span>												
								</c:if>
							</li>													
						</c:forEach>
					</ul>
				</div>
				
				<div class="j-center">
					<ul class="pagination mg-t-5 mg-b-5">
						<li><a href="${_myPage}/myRequest.do?page=${page-5}">&laquo;</a></li>
						<c:forEach begin="${firstPage}" end="${lastPage}" varStatus="vs">
							<c:if test="${vs.current == page}">
								<li class="active"><a>${vs.current}</a></li>							
							</c:if>
							<c:if test="${vs.current != page}">
								<li><a href="${_myPage}/myRequest.do?page=${vs.current}">${vs.current}</a></li>							
							</c:if>
						</c:forEach>
						<li><a href="${_myPage}/myRequest.do?page=${page+5}">&raquo;</a></li>
					</ul>
				</div>
				
			</div>
		</div>
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		
	</script>
</body>
</html>