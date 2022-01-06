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
		<div class="align-end head">
			<div class="col-md-9">
				<img id="logo" alt="" src="${logo}" height="100">
			</div>
			<div class="align-center" style="margin-bottom: 15px;">
				<span style="color: gray;"> 이미 가입하셨나요? </span>			
				<a href="${_}/loginForm.do" class="btn btn-lg btn-link">로그인하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div class="box flex-column" style="height: 75%; margin: 0 5px;">
			<!-- 제목, 닉네임, 등록일, 조회수-->
			<div class="align-center j-between shadow-bottom" style="height: 10%; padding: 10px;">
				<span class="h3">
					[${board.c_no}] ${board.subject} <small>${board.m_id} | ${board.reg_date} | 조회 : ${board.readcount }</small>
				</span>
				<span>
					<button class="btn btn-primary btn-sm">참가 신청</button>
					<button class="btn btn-warning btn-sm">수정<i class="fas fa-undo-alt mg-l-5"></i></button>
					<button class="btn btn-danger btn-sm">삭제<i class="fas fa-trash-alt mg-l-5"></i></button>
					<button class="btn btn-default btn-sm">목록<i class="fas fa-list mg-l-5"></i></button>
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
		
		$('#request').load('${_board}/request.do');
		$('#parti').load('${_board}/parti.do');
		$('#reply').load('${_board}/reply.do');
		
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
	</script>
</body>
</html>