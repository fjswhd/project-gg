<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default mg-b-5">
	<div class="panel-heading j-center">
		<a href="#collapseParti" class="h3 panel-title" data-toggle="collapse">
			참여자 목록<i class="fas fa-caret-down mg-l-5"></i>
		</a>
	</div>
	<div class="panel-collapse collapse in" id="collapseParti">
		<ul class="list-group">
			<c:if test="${empty partiList}">
				<li class="list-group-item">
					아직 참여자가 없습니다.
				</li>
			</c:if>
			
			<c:if test="${not empty partiList}">
				<c:forEach var="parti" items="${partiList}" varStatus="vs">
					<c:url var="ban" value="/parti/ban.do" >
						<c:param name="b_no" value="${parti.b_no}" />
						<c:param name="m_id" value="${parti.m_id}" />
					</c:url>
					<c:url var="cancel" value="/parti/cancel.do" >
						<c:param name="b_no" value="${parti.b_no}" />
						<c:param name="m_id" value="${parti.m_id}" />
					</c:url>
					<c:url var="cancelAccept" value="/parti/cancelAccept.do" >
						<c:param name="b_no" value="${parti.b_no}" />
						<c:param name="m_id" value="${parti.m_id}" />
					</c:url>
					<c:url var="cancelReject" value="/parti/cancelReject.do" >
						<c:param name="b_no" value="${parti.b_no}" />
						<c:param name="m_id" value="${parti.m_id}" />
					</c:url>
					<c:url var="reqCancel" value="/parti/return.do" >
						<c:param name="b_no" value="${parti.b_no}" />
						<c:param name="m_id" value="${parti.m_id}" />
					</c:url>
					
					<!-- 참여자가 탈퇴 신청하지 않은 경우 -->
					<c:if test="${parti.cancel == 'n'}">
						<c:if test="${sessionScope.member.m_id == board.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>
								<a href="${ban}" class="text-danger cursor-no-line" title="참여자 강퇴" onclick="ban('${parti.nickname}')">
									<i class="fas fa-times-circle"></i>																		
								</a>
							</li>
						</c:if>
						<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id == parti.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>
								<a href="${cancel}" class="text-danger cursor-no-line" title="활동 탈퇴" onclick="partiCancel()">
									<i class="fas fa-times-circle"></i>																		
								</a>
							</li>
						</c:if>
						<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id != parti.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>
							</li>
						</c:if>
					</c:if>
					
					<!-- 참여자가 탈퇴 신청한 경우 -->
					<c:if test="${parti.cancel == 'w'}">
						<c:if test="${sessionScope.member.m_id == board.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>님이 <strong class="text-danger">탈퇴를 신청</strong>하셨습니다.
								<a href="${cancelAccept}" class="text-success cursor-no-line" title="탈퇴 수락" onclick="cancelAccept('${parti.nickname}')">
									<i class="fas fa-check-circle"></i>																		
								</a>
								<a href="${cancelReject}" class="text-danger cursor-no-line" title="탈퇴 거절" onclick="cancelReject('${parti.nickname}')">
									<i class="fas fa-times-circle"></i>																		
								</a>
							</li>
						</c:if>
						<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id == parti.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>님이 <strong class="text-danger">탈퇴를 신청</strong>하셨습니다.
								<a href="${reqCancel}" class="text-danger cursor-no-line" title="신청 취소" onclick="reqCancel()">
									<i class="fas fa-times-circle"></i>																		
								</a>
							</li>
						</c:if>
						<c:if test="${sessionScope.member.m_id != board.m_id && sessionScope.member.m_id != parti.m_id}">
							<li class="list-group-item">
								<a href="#myModal" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a> <strong class="text-danger"> 탈퇴를 신청</strong>하셨습니다.
							</li>
						</c:if>
					</c:if>
				</c:forEach>			
			</c:if>
			
		</ul>
	</div>
</div>



<script type="text/javascript">
	function ban(nickname) {		
		if(!confirm('강퇴당한 사용자는 평점이 0점으로 처리됩니다.\r\n또한 다시 활동에 참가할 수 없게 됩니다.\r\n'+nickname+'님을 활동에서 강퇴하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function partiCancel() {		
		if(!confirm('탈퇴 신청이 수락되면 다시 활동에 참가하실 수 없습니다.\r\n정말 활동에서 탈퇴하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function cancelAccept(nickname) {
		if(!confirm(nickname+'님의 탈퇴 신청을 수락하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function cancelReject(nickname) {
		if(!confirm(nickname+'님의 탈퇴 신청을 거절하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	function reqCancel() {		
		if(!confirm('탈퇴 신청을 취소하시겠습니까?')) {
			event.preventDefault();
		} 
	}
	
</script>