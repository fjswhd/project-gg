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
			<form action="${_member}/findPw.do" method="post" name="frm">
				<div class="form-group">
					<label for="m_id">비밀번호를 초기화하실 이메일을 입력하세요.</label>
					<input type="email" id="m_id" name="m_id" class="form-control" required="required" placeholder="이메일">
					<div class="msg ok"></div>
				</div>				
				<div id="aCollapse" class="collapse">
					<div class="form-group">
						<label for="password">본인확인을 위해 이메일로 보낸 인증번호를 입력해주세요.</label>
						<input type="text" id="password" name="password" class="form-control" required="required" placeholder="인증번호">
						<div class="j-between">
							<div class="msg err"></div>
							<button type="submit" class="btn btn-primary mg-t-5" disabled="disabled">비밀번호 초기화</button>	
						</div>
					</div>
				</div>
			</form>
		</div>
		
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		frm.m_id.addEventListener('change', idChk)
		
		//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
		frm.addEventListener("keydown", function(event)  {
		    if ((event.keyCode || event.which) === 13) {
		    	event.target.blur();
		    	event.preventDefault();
		    }
		});
		
		//아이디 중복 체크
		async function idChk(event) {
			var id = document.querySelector('#m_id').value,
			msg = document.querySelectorAll('.msg')[0],
			sendData = 'm_id='+id,
			regExp = new RegExp('^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$', 'i');
			
			//입력한 아이디가 이메일 형식을 만족하지 않는 경우
			if(regExp.test(id)) {
				var result = await fetch('${_member}/idChk.do', {
					method :'POST',
					body: sendData,
					headers: {
						'Content-Type': 'application/x-www-form-urlencoded'
					}
				}).then(function(response) {
					return response.text();
				})
				
				if (result == '1') {
					msg.innerHTML = '존재하지 않는 이메일입니다.';
				} else if(result != '1') {
					msg.innerHTML = '이메일로 인증번호가 발송됩니다.';
					msg.classList.replace('err','ok');
					
					//인증 부분 열기
					$('#aCollapse').collapse('show');
					
					authMailSend(id);
					
					return;
				} 
			} else {
				msg.innerHTML = '이메일 형식과 맞지 않습니다.';
			}
			
			msg.classList.replace('ok','err');
			
			//비밀번호 부분이 열려있으면 비밀번호, 비밀번호 확인 input의 값을 지우고 닫음
			if ($('#aCollapse').hasClass('in') ) {
				$('#aCollapse').collapse('hide');
				document.querySelector('#password').value = '';
				document.querySelectorAll('.msg')[1].innerHTML = '';
			}
		}
		
		var num, pass = document.querySelector('#password');
				
		pass.onchange = function() {
			if (pass.value == num) {
				document.querySelectorAll('.msg')[1].classList.replace('err','ok');
				document.querySelectorAll('.msg')[1].innerHTML = '인증번호가 일치합니다.';
				document.querySelector('button[type="submit"]').removeAttribute('disabled');
			} else {
				document.querySelectorAll('.msg')[1].classList.replace('ok','err');
				document.querySelectorAll('.msg')[1].innerHTML = '인증번호가 일치하지 않습니다.';
				document.querySelector('button[type="submit"]').setAttribute('disabled', 'disabled');
			}			
		}
		
		function authMailSend(id) {
			//timer();
			$.post('${_member}/authUser.do', 'm_id='+id, function(data) {
				num = data	
			})
		}
		
		function timer() {
			var time = 180;
			var min, sec,
				msg = document.querySelectorAll('.msg')[1]
			
			var x = setInterval(function() {
				min = parseInt(time/60);
				sec = time%60;
				time--;
				
				msg.innerText = '남은 시간 : 0'+min+':'+fillZero(sec);
				
				if (time == 0) {
					clearInterval(x);
					msg.classList.add('err');
					msg.innerText = '세션이 만료되었습니다.';
				}
			}, 1000)
		}
		function fillZero(sec){
		    return parseInt(sec/10) == 0 ? '0'+sec : sec //남는 길이만큼 0으로 채움
		}
		
		/* function login(event) {
			//submit막기
			event.preventDefault();
			var sendData = $('form[name=frm]').serialize(),
				msg = document.querySelectorAll('.msg')[0];
			
			var prev = '${prev}';
			
			//ajax로 로그인 확인하자
			fetch('/project/member/findPw.do', {
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
		} */
	</script>
</body>
</html>