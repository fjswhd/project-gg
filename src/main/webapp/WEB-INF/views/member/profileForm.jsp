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
		<div id="body" class="flex-column" style="height: 80%; position:absolute; width: 100%; top: 20%;">
			<div class="col-md-4 mg-auto box">
				<form action="${_member}/profileInsert.do" enctype="multipart/form-data" method="post" name="frm">
					<input type="hidden" name="m_id" value="${m_id}">
					<div class="j-center mg-b-10" style="color: #000; position: relative;">
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
					</div>				
					<div class="form-group">
						<label for="tag">당신의 관심사를 알려주세요.</label>
						<input type="text" id="tag" name="tag" class="form-control" placeholder="관심사">
					</div>
					<div class="j-end">
						<button type="submit" class="btn btn-primary mg-r-5">작성 완료</button>						
						<a href="${_member}/loginForm.do" class="btn btn-default">건너뛰기</a>						
					</div>
				</form>
			</div>
		</div>
	</div>
	
	<div class="modal fade" id="myModal" style="font-family: 'Noto Sans KR'">
		<div class="modal-dialog ">
			<div class="modal-content">
				<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<h4 id="profileTitle" class="modal-title"></h4>
				</div>
				<div class="modal-body flex-column align-center">
					<img id="profileImg" class="img-circle mg-b-10" alt="" src="" width="200" height="200" style="box-shadow: 0 0 3px #808080;">
					<ul id="profileContent" class="list-group mg-b-5" style="width: 80%; box-shadow: 0 0 2px #808080; border-radius: 4px;">
						<li class="list-group-item"></li>				
						<li class="list-group-item"></li>				
						<li class="list-group-item"></li>				
						<li class="list-group-item"></li>				
						<li class="list-group-item"></li>				
					</ul>
				</div>
				<div class="modal-footer">
					<a href="${_member}/loginForm.do" class="btn btn-primary">로그인</a>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		history.pushState(null, null, "http://localhost:8080/project/member/profileForm.do"); 
		window.onpopstate = function(event) { history.go(1); };
		
		document.querySelector("#picture").onchange = function (event) {
			var image = event.target.files[0],
				reader = new FileReader();
			
			if(!image.type.includes('image')) {
				event.target.value = '';
				alert('이미지 파일만 업로드가능합니다.');
				document.querySelector("div#image").innerHTML = '<i class="fas fa-user-circle fa-10x"></i>';
				return;
			}
				
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
		
		frm.onsubmit = function() {
			event.preventDefault();
			var sendData = new FormData(document.querySelector('form'));
			console.dir(sendData);
			var title = document.querySelector('#profileTitle'),
				img = document.querySelector('#profileImg'),
				li = document.querySelectorAll('#profileContent > li');
			
			var div = document.createElement('div');
			div.className = 'loading';
			div.innerHTML = '<div><i class="fas fa-spinner fa-spin fa-5x mg-b-5"></i></div><div>Loading...</div>'
			
			document.querySelector('body').insertBefore(div,null);
			
			randomTime = parseInt(Math.random() * 1000) + 1000;
			
			fetch('${_member}/profileInsert.do', {
				method: 'POST',
				body: sendData
			}).then(function(response) {
				return response.json();
			}).then(function(data) {
				//닉네임 픽쳐 플레이스 레이팅 가입일 태그
				title.textContent = '당신의 프로필을 확인하세요.';
				img.src = '${_profile}/' + data.picture;
				
				li[0].innerHTML = '<span class="col-md-3 bold">레벨</span>' + data.level;				
				li[1].innerHTML = '<span class="col-md-3 bold">가입일</span>' + data.reg_date;				
				li[2].innerHTML = '<span class="col-md-3 bold">출몰지</span>' + data.place;				
				li[3].innerHTML = '<span class="col-md-3 bold">관심사</span>' + data.tag;				
				li[4].innerHTML = '<span class="col-md-3 bold">평점</span>' + data.rating;				
				
				setTimeout(function() {
					div.className = 'hide';
					$('#myModal').modal({
						backdrop: 'static'
					});
				}, randomTime);
				
			})
			
		}
	</script>
</body>
</html>