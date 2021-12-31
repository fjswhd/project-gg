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
				<a href="${_}/joinForm" class="btn btn-lg btn-link">가입하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div class="col-md-4 mg-auto box">
			<form action="" method="post" name="frm">
				<div class="form-group">
					<label for="id">아이디를 입력하세요.</label>
					<input type="text" id="id" name="id" class="form-control" required="required" placeholder="아이디">
				</div>
				<div class="form-group">
					<label for="password">비밀번호를 입력하세요.</label>
					<input type="password" id="password" name="password" class="form-control" required="required" placeholder="비밀번호">
				</div>
				<div class="j-between">
					<a href="#" class="btn btn-link" style="padding-left: 0;">비밀번호를 잊으셨나요?</a>
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
	</script>
</body>
</html>