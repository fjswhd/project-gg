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

	<div class="container flex-column">
		<!-- head -->
		<div class="align-end head">
			<div class="col-md-7">
				<img id="logo" alt="" src="${logo}" height="100">
			</div>
		
			<div class="j-end align-end f-1" style="margin-bottom: 15px;">
				<div class="pd-3">
					<a href="${_}/loginForm" class="btn btn-link"><b>공지사항</b></a>				
					<a href="${_}/loginForm" class="btn btn-primary">로그인</a>				
					<a href="${_}/joinForm" class="btn btn-default">회원가입</a>
				</div>
			</div>
		
		</div>
		
		<!-- body -->
		<div class="flex-column f-1" style="padding-bottom: 50px; background: red;">
			<div class="flex-column f-1">
				<div class="col-md-8 mg-auto form-inline"> 
					<div class="form-group align-center">
						<label style="font-size: 40px">언제 떠나시나요?</label>
						<input type="date" class="form-control">					
						<input type="date" class="form-control">					
					</div>
				</div>
				<div class="col-md-8 mg-auto"> 
					<h1>언제 떠나시나요?</h1>
				</div>
			
			</div>
			<!-- 스크롤 다운 버튼 -->
			<div class="j-center align-center bounce" style="height: 50px;">
				<button class="btn btn-link btn-lg" style="width: 20%; font-size: 40px;">
					<span class="glyphicon glyphicon-chevron-down"></span>
				</button>
			</div>
			
		</div>
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
</body>
</html>

	<!-- <div class="container flex">
		<div id="map" style="width: 70%; background: red;"></div>
	</div>
	<script>
		navigator.geolocation.getCurrentPosition(function(pos) {
			let latitude, longitude;
		    latitude = pos.coords.latitude;
		    longitude = pos.coords.longitude;
		    
		   
			var map = new kakao.maps.Map(document.querySelector('#map'), {
			    level: 3,
			    center: new kakao.maps.LatLng(latitude, longitude),
			});
		});
	</script> -->