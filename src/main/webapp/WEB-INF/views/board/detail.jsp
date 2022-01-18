<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.css" />
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@api['map.api']"/>&libraries=services"></script>
</head>
<body>
	<div class="container flex-column" style="overflow: hidden">
		
		<!-- header -->
		<c:if test="${ empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_login.jsp" />		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div class="mg-auto box flex-column" style="position: relative; width:99%; height: 75%; top: 20%;">
			<!-- 제목, 닉네임, 등록일, 조회수-->
			<div class="align-center j-between shadow-bottom" style="height: 10%; padding: 10px;">
				<span class="h3">
					[${board.category.c_name}] ${board.subject} <small>${board.member.nickname} | ${board.reg_date} | 조회 : ${board.readcount }</small>
				</span>
				<span>
					<!-- 현재 사용자가 로그인했고, 사용자가 보드의 writer는 아닌 경우 -->
					<c:if test="${not empty sessionScope.member && sessionScope.member.m_id != board.m_id}">
						<!-- 활동에 참여했다가 강퇴 || 탈퇴한 경우 재참여 불가능 -->
						
						<!-- 이미 활동에 참가 신청한 경우 -->
						<button id="" class="btn btn-primary btn-sm" disabled="disabled">참가 신청</button>
						
						<!-- 참여자가 활동 최대 인원인 경우 -->
						<!-- 모집 종료한 경우 -->
						
						<!-- 활동에 참가 신청되있지 않은 경우 -->
						<button class="btn btn-primary btn-sm" onclick="makeRequest()">참가 신청</button>
					</c:if>
					
					<!-- 모집 종료하지 않은 경우 && 활동 최대 인원을 못 채운 경우 -->
					<c:if test="${sessionScope.member.m_id == board.m_id}">
						<button class="btn btn-success btn-sm">모집 종료</button>
					</c:if>
					
					<!-- 모집 종료한 경우 && 활동 최대 인원을 못 채운 경우 -->
					<c:if test="${sessionScope.member.m_id == board.m_id}">
						<button class="btn btn-success btn-sm">모집 재개</button>
					</c:if>
					<c:if test="${sessionScope.member.m_id == board.m_id}">
						<a href="${_board}/updateForm.do?b_no=${board.b_no}" class="btn btn-warning btn-sm">수정<i class="fas fa-undo-alt mg-l-5"></i></a>
					</c:if>
					<c:if test="${sessionScope.member.m_id == board.m_id}">
						<button class="btn btn-danger btn-sm">삭제<i class="fas fa-trash-alt mg-l-5"></i></button>
					</c:if>
				</span>
			</div>
			
			<div class="flex f-g mg-t-5" style="overflow: hidden;">
				<!-- 내용, 참여자 -->
				<div class="f-2 mg-r-5 scroll" style="overflow: auto; position: relative;">
					<div class="flex-column pd-b-5 pd-r-5" style="position: absolute; width: 100%;">
						<!-- 내용 -->
						<div id="viewer" class="shadow-bottom mg-b-5 pd-10"></div>
						
						<!-- 댓글 -->
						<div id="reply"></div>
					</div>
				</div>
				
				<!-- 신청자, 참여자, 활동일, 장소 -->
				<div class="f-1 pd-r-5 scroll" style="overflow: auto;">
					<!-- 신청, 참여  -->
					<div id="request"></div>					
					<div id="parti"></div>
					
					<ul class="list-group mg-b-5">
						<li class="list-group-item align-center" style="font-size: 16px;">
							<span class="col-md-1 j-center pd-0"><i class="far fa-calendar-check fa-lg"></i></span>
							${board.s_date} ~ ${board.e_date}
						</li>
						<li class="list-group-item align-center" style="font-size: 16px;">
							<span class="col-md-1 j-center pd-0"><i class="fas fa-compass fa-lg"></i></span>
							${place}
						</li>
						<li class="list-group-item align-center" style="font-size: 16px;">
							<span class="col-md-1 j-center pd-0"><i class="fas fa-map-marked-alt fa-lg"></i></span>
							${address}							
						</li>
						<li class="list-group-item" style="padding: 0;">
							<div id="map" style="width: 100%; height: 72.2%; border-bottom-left-radius: 3px; border-bottom-right-radius: 3px;"></div>
						</li>
					</ul>
				</div>
			</div>
		</div>	
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		if(document.querySelector('#request')) {
			$('#request').load('${_request}/list.do', 'b_no=${board.b_no}');			
		}
		$('#parti').load('${_parti}/list.do', 'b_no=${board.b_no}');
		$('#reply').load('${_reply}/list.do', 'b_no=${board.b_no}');
		
		var geocoder = new kakao.maps.services.Geocoder(),
		address = '${address}';
		
		geocoder.addressSearch(address, function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var currCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        var map = new kakao.maps.Map(document.querySelector('#map'), {
				    level: 4,
				    center: currCenter
				});	
			    
			   	var marker = new kakao.maps.Marker({
			        map: map,
			    	position: currCenter
			    });
		    }
		});
		
		var viewer = toastui.Editor.factory({
			el: document.querySelector('#viewer'),
			viewer: true,
			initialValue: '${board.content}'
		});
		
		function makeRequest() {
			var b_no = '${board.b_no}',
				m_id = '${sessionScope.member.m_id}';
			
			if(confirm('활동에 참가 신청하시겠습니까?')) {
				//alert(b_no+','+m_id);
				location.href = '${_request}/requestInsert.do?b_no='+b_no+'&m_id='+m_id;
			} 
		}
	</script>
</body>
</html>