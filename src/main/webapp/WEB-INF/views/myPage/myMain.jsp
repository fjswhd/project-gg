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
		<div id="body" class="col-md-11" style="position:absolute; top: 20%; left: 50%; transform: translate(-50%, 0); padding: 0 0 50px 0;">
			<div class="box">
				<!-- 마이 프로필 -->
				<div class="flex-column shadow-bottom pd-b-15">
					<h2 class="align-center mg-l-15">
						<strong>마이 프로필</strong>
						<small>
							<a href="profileUpdateForm.do" class="cursor mg-l-10" style="color: #505050;" title="프로필 변경" onclick="pwChk()"><i class="fas fa-user-edit"></i></a>
							<a href="pwUpdateForm.do" class="cursor mg-l-5" style="color: #505050;" title="비밀번호 변경" onclick="pwChk()"><i class="fas fa-unlock-alt"></i></a>
						</small>
					</h2>
					<div id="profile" class="align-center">
						<div id="imgContainer" class="col-md-3 j-center" style="">
							<img class="img-circle" alt="" src="${_profile}/${member.picture}" height="200" width="200">
						</div>
						<div id="profileDetail" class="col-md-9">
							<ul class="list-group mg-b-5">
								<li class="list-group-item flex ellipsis">
									<span class="col-md-3 bold">별명</span>
									<span>${member.nickname}</span>
								</li>
								<li class="list-group-item flex ellipsis">
									<span class="col-md-3 bold">생일 / 레벨</span>
									<span>${member.birthday} / lv : ${level}</span>
								</li>
								<li class="list-group-item flex ellipsis">
									<span class="col-md-3 bold">출몰지</span>
									<span>${member.place}</span>
								</li>
								<li class="list-group-item flex ellipsis">
									<span class="col-md-3 bold">관심사</span>
									<span>${member.tag}</span>
								</li>
								<li class="list-group-item flex ellipsis">
									<span class="col-md-3 bold">평점</span>
									<span>${member.rating}</span>
								</li>
							</ul>
						</div>
					</div>
				</div>
				
				<!-- 내가 작성한 게시글 -->
				<div class="flex-column shadow-bottom pd-b-15 mg-t-15">
					<h2 class="align-center mg-l-15">
						<strong>나의 작성 글</strong>
						<c:if test="${not empty myBoardList && myBoardList.size() > 5}">
							<small><a href="${_myPage}/myBoard.do?page=1" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
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
									나의 별점											
								</span>
								<span class="col-md-2 bold">
									상호평가											
								</span>
							</li>
							<c:if test="${empty myBoardList}">
								<li class="list-group-item align-center">
									<i class="fas fa-times-circle mg-r-5"></i>작성한 게시글이 없습니다.
									<span><a href="${_board}/insertForm.do" class="btn btn-link">새 글 작성하기</a></span>
								</li>							
							</c:if>
							<c:if test="${not empty myBoardList}">
								<c:forEach var="board" items="${myBoardList}" varStatus="vs">
									<c:if test="${vs.index < 5}">
										<li class="list-group-item align-center">
											<span class="col-md-6 ellipsis">
												<a href="${_board}/detail.do?b_no=${board.b_no}" class="cursor">[${board.category.c_name}] ${board.subject}</a>											
											</span>
											<span class="col-md-2">									
												<c:if test="${today < board.s_date}">
													<span class="text-muted">활동 예정</span>									
												</c:if>
												<c:if test="${board.s_date <= today && today <= board.e_date}">
													<span class="text-primary bold">활동 중</span>											
												</c:if>
												<c:if test="${today > board.e_date}">
													<span class="text-success bold">활동 종료</span>											
												</c:if>
											</span>
											<span class="col-md-2">
												<c:if test="${empty board.r_score}">
													<span class="text-muted">받은 별점이 없습니다.</span>
												</c:if>											
												<c:if test="${not empty board.r_score}">
													<span class="bold">${board.r_score}점</span>
												</c:if>											
											</span>
											<span class="col-md-2">
												<c:if test="${today <= board.e_date || today > board.e_date_after}">
													<a href="${_board}/detail.do?b_no=${board.b_no}" class="btn btn-primary btn-sm disabled">상호 평가</a>											
												</c:if>										
												<c:if test="${today > board.e_date && today <= board.e_date_after}">
													<button class="btn btn-primary btn-sm" onclick="eval('${board.b_no}')">상호 평가</button>											
												</c:if>	
											</span>
										</li>										
									</c:if>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				
				<!-- 내가 참여 신청을 한 글 -->
				<div class="flex-column shadow-bottom pd-b-15 mg-t-15">
					<h2 class="align-center mg-l-15">
						<strong>나의 신청</strong>
						<c:if test="${not empty myRequestList && myRequestList.size() > 5}">
							<small><a href="${_myPage}/myRequest.do?page=1" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
					</h2>
					<div id="myRequest">
						<ul class="list-group mg-t-10 mg-b-5">
							<li class="list-group-item align-center">
								<span class="col-md-6 bold">
									활동명											
								</span>
								<span class="col-md-6 bold">
									신청 상태											
								</span>
							</li>
							<c:if test="${empty myRequestList}">
								<li class="list-group-item align-center">
									<i class="fas fa-times-circle mg-r-5"></i>신청한 게시글이 없습니다.
								</li>							
							</c:if>
							<c:if test="${not empty myRequestList}">
								<c:forEach var="request" items="${myRequestList}" varStatus="vs">
									<c:if test="${vs.index < 5}">
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
									</c:if>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				
				<!-- 내가 참여한 활동 -->
				<div class="flex-column pd-b-15 mg-t-15">
					<h2 class="align-center mg-l-15">
						<strong>나의 활동</strong>
						<c:if test="${not empty myPartiList && myPartiList.size() > 5}">
							<small><a href="${_myPage}/myParti.do?page=1" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
					</h2>
					<div id="myParti">
						<ul class="list-group mg-t-10 mg-b-5">
							<li class="list-group-item align-center">
								<span class="col-md-6 bold">
									활동명											
								</span>
								<span class="col-md-2 bold">
									활동 상태											
								</span>
								<span class="col-md-2 bold">
									나의 별점											
								</span>
								<span class="col-md-2 bold">
									상호평가											
								</span>
							</li>
							
							<c:if test="${empty myPartiList}">
								<li class="list-group-item align-center">
									<i class="fas fa-times-circle mg-r-5"></i>참여한 게시글이 없습니다.
								</li>							
							</c:if>
							<c:if test="${not empty myPartiList}">
								<c:forEach var="parti" items="${myPartiList}" varStatus="vs">
									<c:if test="${vs.index < 5}">
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
													<span class="text-muted">받은 별점이 없습니다.</span>
												</c:if>											
												<c:if test="${not empty parti.r_score}">
													<span class="bold">${parti.r_score}점</span>
												</c:if>			
											</span>
											<span class="col-md-2">
												<c:if test="${parti.cancel == 'y' || parti.ban == 'y' || today <= parti.board.e_date || today > parti.board.e_date_after}">
													<a href="${_board}/detail.do?b_no=${board.b_no}" class="btn btn-primary btn-sm disabled">상호 평가</a>											
												</c:if>										
												<c:if test="${today > parti.board.e_date && today <= parti.board.e_date_after && parti.cancel != 'y' && parti.ban != 'y'}">
													<button class="btn btn-primary btn-sm" onclick="eval('${parti.b_no}')">상호 평가</button>											
												</c:if>	
											</span>
										</li>										
									</c:if>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				
				
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="pwChk"></div>
	<div class="modal fade" id="eval"></div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		function pwChk() {
			event.preventDefault();
			$('#pwChk').load('${_myPage}/pwChkForm.do', 'next='+event.target.parentNode.href, function() {
				$('#pwChk').modal({
					backdrop: 'static'
				});
			})
		}
		
		/* 평점 구현
		1. 서브쿼리문으로 보드, 파티리스트에 r_score값을 구해서 가져온다. 
		2. mybatis collection을 사용해본다.
		*/
		function eval(b_no) {
			$('#eval').load('${_myPage}/evalForm.do', 'b_no='+b_no, function() {
				$('#eval').modal({
					backdrop: 'static'
				});
			})
		}
		
	</script>
</body>
</html>