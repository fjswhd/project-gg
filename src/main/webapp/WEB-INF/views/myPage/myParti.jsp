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
					<strong>나의 활동</strong>
				</h2>
				<div id="myBoard">
					<ul class="list-group mg-t-10 mg-b-5">
						<li class="list-group-item align-center">
							<span class="col-md-6 bold">
								활동명											
							</span>
							<span class="col-md-2 bold">
								활동 상태											
							</span>
							<span class="col-md-2 bold">
								별점											
							</span>
							<span class="col-md-2 bold">
								상호평가											
							</span>
						</li>
						<c:forEach var="parti" items="${myPartiList}">
							<li class="list-group-item align-center">
								<span class="col-md-6 ellipsis">
									<a href="${_board}/detail.do?b_no=${parti.b_no}" class="cursor">[${parti.board.category.c_name}] ${parti.board.subject}</a>											
								</span>
								<span class="col-md-2">
									<c:if test="${parti.cancel == 'y' }">
										<span class="text-danger bold">탈퇴</span>
									</c:if>										
									<c:if test="${parti.ban == 'y' }">
										<span class="text-danger bold">강퇴</span>
									</c:if>										
									<c:if test="${today < parti.board.s_date && parti.cancel != 'y' && parti.ban != 'y'}">
										<span class="text-muted">활동 예정</span>									
									</c:if>
									<c:if test="${parti.board.s_date <= today && today <= parti.board.e_date && parti.cancel != 'y' && parti.ban != 'y'}">
										<span class="text-primary bold">활동 중</span>											
									</c:if>
									<c:if test="${today > parti.board.e_date && parti.cancel != 'y' && parti.ban != 'y'}">
										<span class="text-success bold">활동 종료</span>											
									</c:if>
								</span>
								<span class="col-md-2">
									<c:if test="${empty parti.r_score}">
										<span class="text-muted">평가 전</span>
									</c:if>											
									<c:if test="${not empty parti.r_score}">
										<span class="bold">${parti.r_score}</span>
									</c:if>			
								</span>
								<span class="col-md-2">
									<c:if test="${parti.cancel == 'y' || parti.ban == 'y' || today <= parti.board.e_date}">
										<a href="${_board}/detail.do?b_no=${board.b_no}" class="btn btn-primary btn-sm disabled">상호 평가</a>											
									</c:if>										
									<c:if test="${today > parti.board.e_date && parti.cancel != 'y' && parti.ban != 'y'}">
										<button class="btn btn-primary btn-sm" onclick="eval('${parti.b_no}', '${sessionScope.member.m_id}')">상호 평가</button>											
									</c:if>	
								</span>
							</li>										
						</c:forEach>
					</ul>
				</div>
				
				<div class="j-center">
					<ul class="pagination mg-t-5 mg-b-5">
						<li><a href="${_myPage}/myParti.do?page=${page-5}">&laquo;</a></li>
						<c:forEach begin="${firstPage}" end="${lastPage}" varStatus="vs">
							<c:if test="${vs.current == page}">
								<li class="active"><a>${vs.current}</a></li>							
							</c:if>
							<c:if test="${vs.current != page}">
								<li><a href="${_myPage}/myParti.do?page=${vs.current}">${vs.current}</a></li>							
							</c:if>
						</c:forEach>
						<li><a href="${_myPage}/myParti.do?page=${page+5}">&raquo;</a></li>
					</ul>
				</div>
				
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="eval"></div>
	
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		function eval(b_no, m_id_eval) {
			$('#eval').load('${_myPage}/evalForm.do', 'b_no='+b_no+'&m_id_eval='+m_id_eval, function() {
				$('#eval').modal({
					backdrop: 'static'
				});
			})
		}
		
	</script>
</body>
</html>