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
					[${board.category.c_name}] ${board.subject} 
					<small><a href="#myModal" class="text-muted" data-toggle="modal" title="프로필 확인" onclick="getProfile('${board.m_id}')">${board.member.nickname}</a> | ${board.reg_date} | 모집 현황 : ${partiNum}/${board.m_count}</small>
				</span>
				<span>
					<!-- 현재 사용자가 로그인했고, 사용자가 보드의 writer는 아닌 경우 -->
					<c:if test="${not empty sessionScope.member && sessionScope.member.m_id != board.m_id}">
						<!-- 활동에 참여했다가 강퇴 || 탈퇴한 경우 재참여 불가능 -->
						
						<!-- 이미 활동에 참가 신청한 경우 -->
						<!-- 강퇴, 탈퇴한 경우 -->
						<!-- 참여자가 활동 최대 인원인 경우 -->
						<!-- 모집 종료한 경우 -->
						<c:if test="${requestPossible == false || full == true || banned == true || board.end == 'y'}">
							<button class="btn btn-primary btn-sm" disabled="disabled">참가 신청</button>						
						</c:if>
						
						<!-- 활동에 참가 신청되있지 않은 경우 -->
						<c:if test="${requestPossible == true && full == false && banned == false && board.end == 'n'}">
							<button class="btn btn-primary btn-sm" onclick="makeRequest()">참가 신청</button>						
						</c:if>
					</c:if>
					
					<!-- 현재 사용자가 글 작성자인 경우 -->					
					<c:if test="${not empty sessionScope.member && sessionScope.member.m_id == board.m_id}">
						<!-- 모집 종료한 경우 -->
						<c:if test="${board.end == 'y'}">
							<!-- 인원을 다 못채움 -->
							<c:if test="${full == false}">
								<a href="${_board}/recruitStart.do?b_no=${board.b_no}" class="btn btn-success btn-sm" onclick="startConfirm()">모집 재개</a>
							</c:if>
							<!-- 인원을 다 못채움 -->
							<c:if test="${full == true}">
								<button class="btn btn-success btn-sm" disabled="disabled">모집 재개</button>
							</c:if>
						</c:if>
						
						<!-- 모집 종료하지 않은 경우 -->
						<c:if test="${board.end == 'n'}">
							<a href="${_board}/recruitEnd.do?b_no=${board.b_no}" class="btn btn-success btn-sm" onclick="endConfirm()">모집 종료</a>
						</c:if>
					</c:if>
					
					<c:if test="${sessionScope.member.m_id == board.m_id}">
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
							${place} <a href="#" id="placeLink" title="상세보기" style="color: #000;"><i class="fas fa-link mg-l-5"></i></a>
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
	
	<div class="modal fade" id="myModal">
		<div class="modal-dialog" style="font-family: 'Noto Sans KR'">
			<div class="modal-content">
				<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
					<h4 id="profileTitle" class="modal-title"></h4>
				</div>
				<div class="modal-body flex-column align-center">
					<img id="profileImg" class="img-circle mg-b-10" alt="" src="" width="200" height="200" style="box-shadow: 0 0 3px #808080;">
					<ul id="profileContent" class="list-group" style="width: 90%; box-shadow: 0 0 2px #808080; border-radius: 4px;">
						<li class="list-group-item flex"></li>				
						<li class="list-group-item flex"></li>				
						<li class="list-group-item flex"></li>				
						<li class="list-group-item flex"></li>				
						<li class="list-group-item flex"></li>				
					</ul>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		if(document.querySelector('#request')) {
			$('#request').load('${_request}/list.do', 'b_no=${board.b_no}');			
		}
		$('#parti').load('${_parti}/list.do', 'b_no=${board.b_no}');
		$('#reply').load('${_reply}/list.do', 'b_no=${board.b_no}');
		
		var geocoder = new kakao.maps.services.Geocoder(),
			address = '${address}',
			place = '${place}';
		
		var map = new kakao.maps.Map(document.querySelector('#map'), {
		    level: 4,
		    center: new kakao.maps.LatLng(37.5, 127)
		});	
		//마커 정보 보여줄 오버레이
		var overlay = new kakao.maps.CustomOverlay({
			clickable: true,
			map: map,
			zIndex: 15
		});
		
		//검색 객체?
		var ps = new kakao.maps.services.Places();	
			
		geocoder.addressSearch(address, function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        var currCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        map.setCenter(currCenter);
			    
			   	var marker = new kakao.maps.Marker({
			        map: map,
			    	position: currCenter
			    });
			   	
			  	//마커 누르면 정보 노출 이벤트 리스너 달아주기
		        kakao.maps.event.addListener(marker, 'mouseover', function() {
		        	var	div = document.createElement('div');
				
					div.classList.add('wrap');
		        	
					var content = 
						'<ul class="list-group" style="margin: 0;">'+
						'<li class="list-group-item align-center" style="padding: 3px;">'+
						'<span class="ellipsis">'+place+'</span>'+
						'</li>'+
						'</ul>';
					
					div.innerHTML = content;
					
					overlay.setPosition(marker.getPosition());
					overlay.setContent(div);
					overlay.setMap(map);
				});
			  	
		        kakao.maps.event.addListener(marker, 'mouseout', function() {
		        	overlay.setMap(null);
				});
		    }
		});
		
		
		searchPlaces();
		
		//keyword로 장소 검색
		function searchPlaces() {
		    var keyword = address + ' ' + place

			ps.keywordSearch(keyword, placesSearchCB); 
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
		    	var url = data[0].place_url
		    	document.querySelector('#placeLink').href = url;

		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		        return;

		    } else if (status === kakao.maps.services.Status.ERROR) {
		        
		        return;
		    }
		}
		
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
		function getProfile(m_id) {
			var sendData = '{"m_id":"'+m_id+'"}';
			
			var title = document.querySelector('#profileTitle'),
				img = document.querySelector('#profileImg'),
				li = document.querySelectorAll('#profileContent > li');
			
			/* $.post('${_member}/getProfile.do', sendData, function() {
				title.textContent = data.nickname + '님의 프로필';
				img.src = '${_profile}/' + data.picture;
				
				li[0].innerHTML = '<span class="col-md-3 bold">레벨</span>' + data.level;				
				li[1].innerHTML = '<span class="col-md-3 bold">가입일</span>' + data.reg_date;				
				li[2].innerHTML = '<span class="col-md-3 bold">출몰지</span>' + data.place;				
				li[3].innerHTML = '<span class="col-md-3 bold">관심사</span>' + data.tag;				
				li[4].innerHTML = '<span class="col-md-3 bold">평점</span>' + data.rating;				
				
			}) */
			
			fetch('${_member}/getProfile.do', {
				method: 'POST',
				body: sendData,
				headers: {
					'Content-Type':'application/json;charset=utf-8'
				}
			}).then(function(response) {
				return response.json();
			}).then(function(data) {
				//닉네임 픽쳐 플레이스 레이팅 가입일 태그
				title.textContent = data.nickname + '님의 프로필';
				img.src = '${_profile}/' + data.picture;
				
				li[0].innerHTML = '<span class="col-md-3 bold">레벨</span><div class="col-md-9 pd-0 wordWrap">' + data.level + '</div>';
				li[1].innerHTML = '<span class="col-md-3 bold">가입일</span><div class="col-md-9 pd-0 wordWrap">' + data.reg_date + '</div>';			
				li[2].innerHTML = '<span class="col-md-3 bold">출몰지</span><div class="col-md-9 pd-0 wordWrap">' + data.place + '</div>';				
				li[3].innerHTML = '<span class="col-md-3 bold">관심사</span><div class="col-md-9 pd-0 wordWrap">' + data.tag + '</div>';				
				li[4].innerHTML = '<span class="col-md-3 bold">평점</span><div class="col-md-9 pd-0 wordWrap">' + data.rating + '</div>';
				
			})
			
		}
		
		function endConfirm() {
			if(!confirm('모집을 종료하시겠습니까?')) {
				event.preventDefault();
			}
		}
		function startConfirm() {
			if(!confirm('다시 모집을 시작하시겠습니까?')) {
				event.preventDefault();
			}			
		}
	</script>
</body>
</html>