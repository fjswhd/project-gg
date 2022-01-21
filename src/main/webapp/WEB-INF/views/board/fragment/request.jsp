<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default mg-b-5">
	<div class="panel-heading j-center">
		<a href="#collapseReq" class="h3 panel-title" data-toggle="collapse">
			신청자 목록<i class="fas fa-caret-down mg-l-5"></i>
		</a>
	</div>
	<div class="panel-collapse collapse in" id="collapseReq">
		<ul class="list-group">
			<c:if test="${empty requestList}">
				<li class="list-group-item">
					현재 신청자가 없습니다.
				</li>
			</c:if>
			
			<c:if test="${not empty requestList}">
				<c:forEach var="request" items="${requestList}" varStatus="vs">
					<c:url var="accept" value="/request/requestAccept.do" >
						<c:param name="b_no" value="${request.b_no}" />
						<c:param name="m_id" value="${request.m_id}" />
					</c:url>
					<c:url var="reject" value="/request/requestReject.do" >
						<c:param name="b_no" value="${request.b_no}" />
						<c:param name="m_id" value="${request.m_id}" />
					</c:url>
					<c:url var="cancel" value="/request/requestCancel.do" >
						<c:param name="b_no" value="${request.b_no}" />
						<c:param name="m_id" value="${request.m_id}" />
					</c:url>
					<c:if test="${sessionScope.member.m_id == board.m_id}">
						<li class="list-group-item">
							<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${request.m_id}')">${request.nickname}</a>님이 <strong class="text-success">참가를 신청</strong>하셨습니다.
							<a href="${accept}" class="text-success cursor-no-line" title="신청 수락" onclick="accept('${request.nickname}')">
								<i class="fas fa-check-circle"></i>																		
							</a>
							<a href="${reject}" class="text-danger cursor-no-line" title="신청 거절" onclick="reject('${request.nickname}')">
								<i class="fas fa-times-circle"></i>																		
							</a>
						</li>
					</c:if>
					<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id == request.m_id}">
						<li class="list-group-item">
							<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${request.m_id}')">${request.nickname}</a>님이 <strong class="text-success">참가를 신청</strong>하셨습니다.
							<a href="${cancel}" class="text-danger cursor-no-line" title="신청 취소" onclick="cancel()">
								<i class="fas fa-times-circle"></i>																		
							</a>
						</li>
					</c:if>
					<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id != request.m_id}">
						<li class="list-group-item">
							신청자 ${vs.count}님이 <strong class="text-success">참가를 신청</strong>하셨습니다.
						</li>
					</c:if>
				</c:forEach>			
			</c:if>
		</ul>
	</div>
</div>
<script type="text/javascript">
	function accept(nickname) {		
		if(!confirm(nickname+'님의 참여 신청을 수락하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function reject(nickname) {		
		if(!confirm(nickname+'님의 참여 신청을 거절하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function cancel() {		
		if(!confirm('참여 신청을 취소하시겠습니까?')) {
			event.preventDefault();
		} 
	}
</script>