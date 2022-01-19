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
		<!-- header -->
		<div class="align-end head">
			<div class="col-md-9">
				<img id="logo" alt="" src="${logo}" height="100">
			</div>
			<div class="align-center" style="margin-bottom: 15px;">
				<span style="color: gray;"> 이미 가입하셨나요? </span>			
				<a href="${_}/loginForm" class="btn btn-lg btn-link">로그인하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div id="body" class="flex-column" style="height: 160%; position:absolute; width: 100%; top: 20%;">
			<!-- 상단 -->
			<div class="flex-column" style="height: 50%; padding-bottom: 50px;">
				<!-- 캐러셀 -->
				<div class="flex-column f-1">
					<div class="col-md-8 mg-auto f-1 box" style="background: cyan;"> 
						가입을 축하드려요!<br>
						원하신다면 프로필 정보 입력을 통해<br>
						당신에 대해 더욱 표현해보세요!
					</div>
				</div>
				
				<!-- 스크롤 다운 버튼 -->
				<div class="j-center align-center">
					<a class="btn btn-default" onclick="scrollDown()" style="width: 20%;">
						<strong class="mg-r-5">프로필 작성하기</strong><i class="fas fa-arrow-down"></i>
					</a>
				</div>
			</div>
			
			<!-- 하단 -->
			<div class="col-md-4 mg-auto box">
				<form action="${_member}/profileInsert.do" enctype="multipart/form-data" method="post" name="frm">
					<input type="hidden" name="m_id" value="${member.m_id}">
					<div class="j-center mg-b-10" style="color: #808080; position: relative;">
						<label class="btn btn-sm img-btn" for="picture">
							<i class="far fa-images mg-r-5"></i><strong>등록</strong>
						</label>
						<input type="file" id="picture" name="picture" class="hide">
						<div id="image"><i class="fas fa-user-circle fa-10x"></i></div>
					</div>
					<div class="form-group mg-t-5">
						<label for="birthday">레벨 측정을 위해 생일을 입력해주세요.</label>
						<input type="date" id="birthday" name="birthday" class="form-control" min="1900-01-01">
					</div>
					<div class="form-group">
						<label for="place">주요 출몰지(활동 지역)를 알려주세요.</label>
						<input type="text" id="place" name="place" class="form-control" placeholder="주요 출몰지">
						<div class="msg err"></div>
					</div>				
					<div class="form-group">
						<label for="tag">당신의 관심사를 알려주세요.</label>
						<input type="text" id="tag" name="tag" class="form-control" placeholder="#관심사">
					</div>
					<div class="j-end">
						<button type="submit" class="btn btn-primary mg-r-5">작성 완료</button>						
						<a href="${_member}/loginForm.do" class="btn btn-default">건너뛰기</a>						
					</div>
					
				</form>
			</div>
		</div>
		
		
		
	
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		function scrollDown() {
			$('#body').animate({top: '-60%'}, 800);
		}
		
		document.querySelector("#picture").onchange = function (event) {
			var image = event.target.files[0],
			reader = new FileReader();
				
			reader.onload = function(event) {
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				img.setAttribute("class", "img-circle");
				img.setAttribute("height", "140");
				img.setAttribute("width", "140");
				document.querySelector("div#image").innerHTML = '';
				document.querySelector("div#image").appendChild(img);
			};
				
			console.log(image);
			reader.readAsDataURL(image);
			
		}
	</script>
</body>
</html>