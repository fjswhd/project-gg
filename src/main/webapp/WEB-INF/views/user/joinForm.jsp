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
		<div class="col-md-5 mg-auto box">
			<form action="${_}/join" method="post" name="frm">
				<div class="form-group">
					<label for="id">사용하실 아이디를 입력하세요.</label>
					<input type="text" id="id" name="id" class="form-control" required="required" placeholder="아이디">
					<div class="msg err"></div>
				</div>
				<div id="pCollapse" class="collapse">
					<div class="form-group">
						<label for="password">비밀번호를 입력하세요.</label>
						<input type="password" id="password" name="password" class="form-control" required="required" placeholder="비밀번호">
					</div>
					<div class="form-group">
						<label for="passwordChk">비밀번호를 확인해주세요.</label>
						<input type="password" id="passwordChk" name="passwordChk" class="form-control" required="required" placeholder="비밀번호 확인">
						<div class="msg err"></div>
					</div>				
				</div>
				<div id="eCollapse" class="collapse">
					<div class="form-group">
						<label for="email">이메일을 입력하세요.</label>
						<input type="email" id="email" name="email" class="form-control" required="required">
					</div>
					<div class="flex" style="justify-content: flex-end;">
						<button type="submit" class="btn btn-primary">가입하기</button>						
					</div>
				</div>
				
			</form>
		</div>
		
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
	
		frm.id.addEventListener('change', idChk)
		frm.password.addEventListener('change', passwordChk)
		frm.passwordChk.addEventListener('change', passwordChk)
		
		//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
		frm.addEventListener("keydown", function(event)  {
		    if ((event.keyCode || event.which) === 13) {
		    	event.target.blur();
		    	event.preventDefault();
		    }
		});
	</script>
</body>
</html>