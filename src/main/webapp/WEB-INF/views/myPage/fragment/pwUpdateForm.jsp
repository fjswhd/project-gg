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
		<div class="col-md-4 mg-auto box" style="position: relative; top: 20%;">
			<form action="${_myPage}/pwUpdate.do" method="post" name="frm">
				<div id="pCollapse" class="collapse in">
					<div class="form-group">
						<label for="password">변경할 비밀번호를 입력하세요</label>
						<input type="password" id="password" name="password" class="form-control" required="required" placeholder="비밀번호">
					</div>
					<div class="form-group">
						<label for="passwordChk">변경할 비밀번호를 확인해주세요</label>
						<input type="password" id="passwordChk" name="passwordChk" class="form-control" required="required" placeholder="비밀번호 확인">
						<div class="j-between">
							<div class="msg err"></div>
							<button type="submit" class="btn btn-primary mg-t-10" disabled="disabled">비밀번호 변경하기</button>						
						</div>
					</div>				
				</div>
			</form>
		</div>
	</div>
	
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		history.forward();
	
		frm.password.addEventListener('change', passwordChk)
		frm.passwordChk.addEventListener('change', passwordChk)
		
		//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
		frm.addEventListener("keydown", function(event)  {
		    if ((event.keyCode || event.which) === 13) {
		    	event.target.blur();
		    	event.preventDefault();
		    }
		});
		
		//비밀번호 유효성 검사
		function passwordChk(event) {
			var password, passwordChk, msg;
			password = document.querySelector('#password').value;
			passwordChk = document.querySelector('#passwordChk').value;
			msg = document.querySelectorAll('.msg')[0];
			
			//비밀번호 유효성 검사 >> 비밀번호가 유효해야 비밀번호 일치 불일치 판단
			if(/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,15}$/.test(password)) {
				msg.classList.replace('ok','err');
				msg.innerHTML = '비밀번호는 숫자, 영소문자, 영대문자의 조합 8~15자로 만들어주세요.';
			
			//비밀번호가 유효한 비밀번호인 경우
			} else {
				msg.classList.replace('err','ok');
				msg.innerHTML = '유효한 비밀번호입니다.';
				
				//비밀번호는 유효한데 확인과 일치하지 않음
				//비밀번호와 비밀번호 확인이 비어있지 않은 경우에만 둘을 비교
				if (password != null && passwordChk !== '') {
					if (password != passwordChk) {
						msg.classList.replace('ok','err');
						msg.innerHTML = '비밀번호가 일치하지 않습니다.';
						
					//비밀번호와 확인이 일치
					} else if (password == passwordChk) {
						msg.classList.replace('err','ok');
						msg.innerHTML = '비밀번호가 일치합니다.';
						
						//submit 버튼 열기
						document.querySelector('button[type="submit"]').removeAttribute('disabled');
						return;
					}
				}
			}
			
			document.querySelector('button[type="submit"]').setAttribute('disabled', 'disabled');
		}
		
		//문자열 바이트수 카운트
		function getByteLength(string){
			var byteLength, c, i;
		    for(byteLength = i = 0; c = string.charCodeAt(i++); byteLength += c>>11 ? 3 : c>>7 ? 2 : 1);
		    return byteLength;
		}
	</script>
</body>
</html>