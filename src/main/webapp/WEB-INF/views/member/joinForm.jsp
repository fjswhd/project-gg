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
				<a href="${_member}/loginForm.do" class="btn btn-lg btn-link">로그인하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div class="col-md-5 mg-auto box">
			<form action="${_member}/join.do" method="post" name="frm">
				<div class="form-group">
					<label for="id">이메일을 입력하세요</label>
					<input type="email" id="m_id" name="m_id" class="form-control" required="required" placeholder="이메일">
					<div class="msg err"></div>
				</div>
				<div id="pCollapse" class="collapse">
					<div class="form-group">
						<label for="password">비밀번호를 입력하세요</label>
						<input type="password" id="password" name="password" class="form-control" required="required" placeholder="비밀번호">
					</div>
					<div class="form-group">
						<label for="passwordChk">비밀번호를 확인해주세요</label>
						<input type="password" id="passwordChk" name="passwordChk" class="form-control" required="required" placeholder="비밀번호 확인">
						<div class="msg err"></div>
					</div>				
				</div>
				<div id="nCollapse" class="collapse">
					<div class="form-group">
						<label for="email">사용하실 별명을 입력하세요</label>
						<input type="text" id="nickname" name="nickname" class="form-control" placeholder="별명" required="required">
						<div class="j-between">
							<div class="msg err"></div>
							<button type="submit" class="btn btn-primary mg-t-5" disabled="disabled">가입하기</button>						
						</div>
					</div>
				</div>
				
			</form>
		</div>
	</div>
	
	<div class="modal fade" id="myModal">
		<div class="modal-dialog j-center">
			<div class="modal-content col-md-8 pd-0">
				<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<h3 id="profileTitle" class="modal-title align-end" style="font-family: 'Noto Sans KR'">
						<i class="material-icons-outlined mg-r-5" style="font-size: 32px;">celebration</i>
						가입을 축하드려요!
					</h3>
				</div>
				<div class="modal-body" style="font-family: 'Noto Sans KR'">
					<p class="lead mg-b-5">원한다면<strong class="mg-r-5 mg-l-5">프로필 정보</strong>입력을 통해</p>
					<p class="lead mg-b-5">당신에 대해 더욱 표현해보세요!</p>
				</div>
				<div class="modal-footer">
					<button id="profileForm" class="btn btn-primary">GO!</button>
					<button id="loginForm"class="btn btn-default">건너뛰기</button>
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		
		frm.m_id.addEventListener('change', idChk)
		frm.password.addEventListener('change', passwordChk)
		frm.passwordChk.addEventListener('change', passwordChk)
		frm.nickname.addEventListener('change', nickChk)
		
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
					msg.innerHTML = '사용 가능한 이메일입니다.';
					msg.classList.replace('err','ok');
					
					//비밀번호 부분 열기
					$('#pCollapse').collapse('show');
					return;
				} else if(result != '1') {
					msg.innerHTML = '중복된 이메일입니다.';
				} 
			} else {
				msg.innerHTML = '이메일 형식과 맞지 않습니다.';
			}
			
			msg.classList.replace('ok','err');
			
			//비밀번호 부분이 열려있으면 비밀번호, 비밀번호 확인 input의 값을 지우고 닫음
			if ($('#pCollapse').hasClass('in') ) {
				$('#pCollapse').collapse('hide');
				document.querySelector('#password').value = '';
				document.querySelector('#passwordChk').value = '';
				document.querySelectorAll('.msg')[1].innerHTML = '';
			}
			
			//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
			if ($('#nCollapse').hasClass('in') ) {
				$('#nCollapse').collapse('hide');
				document.querySelector('#nickname').value = '';
			}
		}

		//비밀번호 유효성 검사
		function passwordChk(event) {
			var password, passwordChk, msg;
			password = document.querySelector('#password').value;
			passwordChk = document.querySelector('#passwordChk').value;
			msg = document.querySelectorAll('.msg')[1];
			
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
						
						//이메일 부분 열기
						$('#nCollapse').collapse('show');
						return;
					}
				}
			}
			
			//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
			if ($('#nCollapse').hasClass('in') ) {
				$('#nCollapse').collapse('hide');
				document.querySelector('#nickname').value = '';
			}
		}
		
		async function nickChk() {
			var nickname = document.querySelector('#nickname').value,
			msg = document.querySelectorAll('.msg')[2],
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
		
		frm.onsubmit = function() {
			event.preventDefault();
			var sendData = $('form[name=frm]').serialize();
			
			var div = document.createElement('div');
			div.className = 'loading';
			div.innerHTML = '<div><i class="fas fa-spinner fa-spin fa-5x mg-b-5"></i></div><div>Loading...</div>'
			
			document.querySelector('body').insertBefore(div,null);
			
			randomTime = parseInt(Math.random() * 1000) + 1000;
			
			setTimeout(function() {
				$.post('${_member}/join.do', sendData, function(data) {
					div.className = 'hide';
					if(data < 0) {
						alert('잘못된 접근입니다.');
						location.href = "${_}/home.do";
					} else if(data == 0) {
						alert('요청을 수행하지 못했습니다.');
						location.href = "${_}/home.do";
					} else {
						$('#myModal').modal({
							backdrop: 'static'
						});
						
						document.querySelector('#profileForm').addEventListener('click', function() {
							//m_id="아이디"쭉 붙는게 별로 보기 싫어서 form 만들어서 보냄
							var newForm = document.createElement('form');
							newForm.setAttribute('method', 'POST');
							newForm.setAttribute('action', '${_member}/profileForm.do');
							
							var newInput = document.createElement('input');
							newInput.setAttribute('type', 'text');
							newInput.setAttribute('name', 'm_id');
							newInput.setAttribute('value', data);
							
							newForm.appendChild(newInput);
							document.body.appendChild(newForm);

							newForm.submit();
						})
						document.querySelector('#loginForm').addEventListener('click', function() {
							location.href = '${_member}/loginForm.do';
						})
					}
				});
			}, randomTime);
		}
		
		function getByteLength(string){
			var byteLength, c, i;
		    for(byteLength = i = 0; c = string.charCodeAt(i++); byteLength += c>>11 ? 3 : c>>7 ? 2 : 1);
		    return byteLength;
		}
	</script>
</body>
</html>