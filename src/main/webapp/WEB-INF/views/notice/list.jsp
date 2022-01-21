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
			<jsp:include page="/WEB-INF/views/common/header_home.jsp" />		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div id="body" class="col-md-11 box" style="position:absolute; top: 20%; left: 50%; height: 75%; transform: translate(-50%, 0);">
			<!-- 공지사항 -->
			<div class="flex-column pd-b-15">
				<h2 class="align-center mg-l-15">
					<strong>공지사항</strong>
					<c:if test="${sessionScope.member.admin == 'y' }">
						<small><a href="${_notice}/insertForm.do" class="cursor mg-l-10" style="color: #505050;"><i class="fas fa-edit"></i></a></small>
					</c:if>
				</h2>
				<div id="profile" class="align-center">
					<ul class="list-group mg-b-5" style="width: 100%;">
						<li class="list-group-item">
							<div class="col-md-8 bold">공지명</div>
							<div class="col-md-2 bold">작성자</div>
							<div class="bold">작성일</div>
						</li>
						<c:if test="${empty noticeList}">
							<li class="list-group-item">
								<i class="fas fa-times-circle mg-r-5"></i>작성된 공지사항이 없습니다.
							</li>						
						</c:if>
						<c:if test="${not empty noticeList}">
							<c:forEach var="notice" items="${noticeList}">
								<li class="list-group-item">
									<div class="col-md-8">
										<a href="${_notice}/detail.do?no_no=${notice.no_no}" style="color: #000;">${notice.subject}</a>
									</div>
									<div class="col-md-2 bold">${notice.member.nickname}</div>
									<div class="bold">${notice.reg_date}</div>
								</li>
							</c:forEach>
						</c:if>
					</ul>
				</div>
				<div class="j-center">
				
					<ul class="pagination mg-t-5 mg-b-5">
						<li><a href="${_notice}/list.do?page=${page-5}">&laquo;</a></li>
						<c:forEach begin="${firstPage}" end="${lastPage}" varStatus="vs">
							<c:if test="${vs.current == page}">
								<li class="active"><a>${vs.current}</a></li>							
							</c:if>
							<c:if test="${vs.current != page}">
								<li><a href="${_notice}/list.do?page=${vs.current}">${vs.current}</a></li>							
							</c:if>
						</c:forEach>
						<li><a href="${_notice}/list.do?page=${page+5}">&raquo;</a></li>
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