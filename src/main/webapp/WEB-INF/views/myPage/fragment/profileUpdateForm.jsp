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
		<c:if test="${ empty sessionScope.member }">
			<script type="text/javascript">
				location.href = '${_}/error.do';
			</script>		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div id="body" class="flex-column" style="height: 80%; position:absolute; width: 100%; top: 20%;">
			<div class="col-md-4 mg-auto box">
				<form action="${_member}/profileUpdate.do" enctype="multipart/form-data" method="post" name="frm">
					<input type="hidden" name="m_id" value="${member.m_id}">
					<div class="j-center mg-b-10" style="color: #000; position: relative;">
						<label class="btn btn-sm img-btn" for="picture">
							<i class="far fa-images mg-r-5"></i><strong>등록</strong>
						</label>
						<input type="file" id="picture" name="picture" class="hide">
						<div id="image"><img alt="" src="${_profile}/${member.picture}" class="img-circle" width="140" height="140"></div>
					</div>
					<div class="form-group mg-t-5">
						<label for="birthday">사용하실 닉네임을 입력해주세요.</label>
						<input type="text" id="nickname" name="nickname" class="form-control" onchange="nickChk()" value="${member.nickname}">
						<div class="msg err"></div>
					</div>
					<div class="form-group mg-t-5">
						<label for="birthday">레벨 측정을 위해 생일을 입력해주세요.</label>
						<input type="date" id="birthday" name="birthday" class="form-control" min="1900-01-01" value="${member.birthday}">
					</div>
					<div class="form-group">
						<label for="place">주요 출몰지(활동 지역)를 알려주세요.</label>
						<input type="text" id="place" name="place" class="form-control" placeholder="주요 출몰지" value="${member.place}">
						<div class="msg err"></div>
					</div>				
					<div class="form-group">
						<label for="tag">당신의 관심사를 알려주세요.</label>
						<input type="text" id="tag" name="tag" class="form-control" placeholder="관심사" value="${member.tag}">
					</div>
					<div class="j-end">
						<button type="submit" class="btn btn-primary mg-r-5">수정 완료</button>						
						<a href="${_myPage}/main.do" class="btn btn-default">취소</a>						
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
						<li class="list-group-item"></li>				
					</ul>
				</div>
				<div class="modal-footer">
					<a href="${_myPage}/main.do" class="btn btn-primary">마이 페이지</a>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
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
		
		async function nickChk() {
			var nickname = document.querySelector('#nickname').value,
			msg = document.querySelectorAll('.msg')[0],
			sendData = 'nickname='+nickname;
			
			var result = await fetch('${_member}/nickChk.do', {
				method :'POST',
				body: sendData,
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				}
			}).then(function(response) {
				return response.text();
			})
			
			if (nickname.trim() == '' || nickname == null) {
				msg.innerHTML = '별명을 입력하세요.';
			} else if (/[^가-힣|\w]/.test(nickname)) { //한글 오탈자나 특수문자
				msg.innerHTML = '별명에 특수문자는 입력할 수 없습니다.';
			} else if (getByteLength(nickname) > 15) {
				msg.innerHTML = '별명은 최대 한글 5글자, 영숫자 15글자입니다.';
			} else if (result == '1') {
				msg.innerHTML = '사용 가능한 별명입니다.';
				msg.classList.replace('err','ok');
				document.querySelector('button[type="submit"]').removeAttribute('disabled');
				return;
			} else if(result != '1') {
				msg.innerHTML = '중복된 별명입니다.';
			} 
			
			msg.classList.replace('ok','err');
			document.querySelector('button[type="submit"]').setAttribute('disabled', 'disabled');
		}
		
		function getByteLength(string){
			var byteLength, c, i;
		    for(byteLength = i = 0; c = string.charCodeAt(i++); byteLength += c>>11 ? 3 : c>>7 ? 2 : 1);
		    return byteLength;
		}
		
		frm.onsubmit = function() {
			event.preventDefault();
			var sendData = new FormData(document.querySelector('form'));
			console.dir(sendData);
			var title = document.querySelector('#profileTitle'),
				img = document.querySelector('#profileImg'),
				li = document.querySelectorAll('#profileContent > li');
			
			/* var div = document.createElement('div');
			div.className = 'loading';
			div.innerHTML = '<div><i class="fas fa-spinner fa-spin fa-5x mg-b-5"></i></div><div>Loading...</div>'
			
			document.querySelector('body').insertBefore(div,null);
			
			randomTime = parseInt(Math.random() * 1000) + 1000; */
			
			fetch('${_member}/profileUpdate.do', {
				method: 'POST',
				body: sendData
			}).then(function(response) {
				return response.json();
			}).then(function(data) {
				//닉네임 픽쳐 플레이스 레이팅 가입일 태그
				title.textContent = '당신의 프로필을 확인하세요.';
				img.src = '${_profile}/' + data.picture;
				
				li[0].innerHTML = '<span class="col-md-3 bold">별명</span>' + data.nickname;				
				li[1].innerHTML = '<span class="col-md-3 bold">레벨</span>' + data.level;				
				li[2].innerHTML = '<span class="col-md-3 bold">가입일</span>' + data.reg_date;				
				li[3].innerHTML = '<span class="col-md-3 bold">출몰지</span>' + data.place;				
				li[4].innerHTML = '<span class="col-md-3 bold">관심사</span>' + data.tag;				
				li[5].innerHTML = '<span class="col-md-3 bold">평점</span>' + data.rating;				
				
				$('#myModal').modal({
					backdrop: 'static'
				});
			})
		}
	</script>
</body>
</html>