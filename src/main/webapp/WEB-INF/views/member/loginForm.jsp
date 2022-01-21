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
				<span style="color: gray;"> 아직 회원이 아니신가요? </span>			
				<a href="${_member}/joinForm.do" class="btn btn-lg btn-link">가입하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div class="col-md-4 mg-auto box">
			<form action="" method="post" name="frm">
				<div class="form-group">
					<label for="m_id">이메일을 입력하세요.</label>
					<input type="email" id="m_id" name="m_id" class="form-control" required="required" placeholder="이메일">
				</div>
				<div class="form-group">
					<label for="password">비밀번호를 입력하세요.</label>
					<input type="password" id="password" name="password" class="form-control" required="required" placeholder="비밀번호">
				</div>
				<div class="j-between">
					<a href="${_member}/findPwForm.do" class="btn btn-link" style="padding-left: 0;">비밀번호를 잊으셨나요?</a>
					<button type="submit" class="btn btn-primary">로그인</button>						
				</div>				
				<div id="mCollapse" class="msg err flex collapse" style="margin-top: 10px">
				</div>
			</form>
		</div>
		
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		frm.addEventListener('submit', login);
		
		function login(event) {
			//submit막기
			event.preventDefault();
			var sendData = $('form[name=frm]').serialize(),
				msg = document.querySelectorAll('.msg')[0];
			
			var prev = '${prev}';
			sendData += '&prev='+prev;
			
			//ajax로 로그인 확인하자
			fetch('/project/member/login.do', {
				method :'POST',
				body: sendData,
				headers: {
					'Content-Type': 'application/x-www-form-urlencoded'
				}
			}).then(function(response) {
				return response.text();
			}).then(function(result) {
				
				//아이디 없음
				if(result < 0) {
					msg.innerHTML = '존재하지 않는 아이디입니다.';
					msg.classList.replace('ok','err');
					//아이디 있음, 비밀번호 틀림
				} else if (result == 0) {
					msg.innerHTML = '잘못된 비밀번호입니다.';
					msg.classList.replace('ok','err');
					//로그인 성공
				} else {
					location.href = result;
				} 
				//메시지 부분 열기
				$('#mCollapse').collapse('show');
			});
		}
	</script>
</body>
</html>