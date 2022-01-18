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
						<small><a href="#" class="cursor mg-l-10" style="color: #505050;"><i class="fas fa-user-edit"></i></a></small>
					</h2>
					<div id="profile" class="align-end">
						<div id="imgContainer" class="col-md-3 j-center" style="">
							<img class="img-circle" alt="" src="${_profile}/${sessionScope.member.picture}" height="200" width="200">
						</div>
						<div id="profileDetail" class="col-md-9">
							<table class="table table-bordered mg-b-5">
								<tr>
									<th class="col-md-3">별명</th>
									<td>${sessionScope.member.nickname}</td>
								</tr>
								<tr>
									<th>생일 / 레벨</th>
									<td>${sessionScope.member.birthday} / lv : ${level}</td>
								</tr>
								<tr>
									<th>출몰지</th>
									<td>${sessionScope.member.place}</td>
								</tr>
								<tr>
									<th>관심사</th>
									<td>${sessionScope.member.tag}</td>
								</tr>
	
								<tr>
									<th>평점</th>
									<td>${sessionScope.member.rating}</td>
								</tr>
							</table>
							
						</div>
					</div>
				</div>
				
				<!-- 내가 작성한 게시글 -->
				<div class="flex-column shadow-bottom pd-b-15 mg-t-15">
					<h2 class="align-center mg-l-15">
						<strong>나의 작성 글</strong>
						<c:if test="${not empty myBoardList && myBoardList.size() > 5}">
							<small><a href="#" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
					</h2>
					<div id="myBoard">
						<ul class="list-group mg-t-10 mg-b-5">
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
											<a href="${_board}/detail.do?b_no=${board.b_no}" class="cursor" >[${board.category.c_name}] ${board.subject}</a>
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
							<small><a href="#" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
					</h2>
					<div id="myBoard">
						<ul class="list-group mg-t-10 mg-b-5">
							<c:if test="${empty myRequestList}">
								<li class="list-group-item align-center">
									<i class="fas fa-times-circle mg-r-5"></i>신청한 게시글이 없습니다.
								</li>							
							</c:if>
							<c:if test="${not empty myRequestList}">
								<c:forEach var="request" items="${myRequestList}" varStatus="vs">
									<c:if test="${vs.index < 5}">
										<li class="list-group-item align-center">
											<h5 style="margin: 0;">
												<a href="${_board}/detail.do?b_no=${request.b_no}" class="cursor">[${request.board.category.c_name}] ${request.board.subject}</a>
												<c:if test="${request.accept == 'w' && request.cancel == 'n'}">
													<small class="mg-l-10">신청 대기중</small>												
												</c:if>
												<c:if test="${request.accept == 'n'}">
													<small class="mg-l-10 text-danger"><strong>신청이 거절되었습니다.</strong></small>												
												</c:if>
												<c:if test="${request.cancel == 'y'}">
													<small class="mg-l-10 text-danger"><strong>신청을 취소했습니다.</strong></small>												
												</c:if>
											</h5>
										</li>										
									</c:if>
								</c:forEach>
							</c:if>
						</ul>
					</div>
				</div>
				
				<!-- 내가 참여한 활동 -->
				<div class="flex-column shadow-bottom pd-b-15 mg-t-15">
					<h2 class="align-center mg-l-15">
						<strong>나의 활동</strong>
						<c:if test="${not empty myBoardList && myBoardList.size() > 5}">
							<small><a href="#" class="cursor mg-l-10" title="더보기" style="color: #505050;"><i class="fas fa-plus-square"></i></a></small>
						</c:if>
					</h2>
					<div id="myBoard">
						<ul class="list-group mg-t-10 mg-b-5">
							<c:if test="${empty myBoardList}">
								<li class="list-group-item align-center">
									<i class="fas fa-times-circle mg-r-5"></i>작성한 게시글이 없습니다.
									<span><a href="#" class="btn btn-link">새 글 작성하기</a></span>
								</li>							
							</c:if>
							<c:if test="${not empty myBoardList}">
								<c:forEach var="board" items="${myBoardList}" varStatus="vs">
									<c:if test="${vs.index < 5}">
										<li class="list-group-item align-center">
											<a href="${_board}/detail.do?b_no=${board.b_no}" class="cursor">[${board.category.c_name}] ${board.subject}</a>
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
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		
	</script>
</body>
</html>