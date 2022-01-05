var randNum = Math.floor(Math.random() * 60) + 20;
$('#background').css('background-position', randNum+'% bottom');

//로고 누르면 홈 화면으로
document.querySelector('#logo').onclick = function() {
	location.href = '/project/home.do';
}

//로그인
function login(event) {
	//submit막기
	event.preventDefault();
	var sendData = $('form[name=frm]').serialize(),
		msg = document.querySelectorAll('.msg')[0];
	
	//ajax로 로그인 확인하자
	fetch('/project/login', {
		method :'POST',
		body: sendData,
		headers: {
			'Content-Type': 'application/x-www-form-urlencoded'
		}
	}).then((response) => {
		return response.text();
	}).then((result) => {
		
		//아이디 없음
		if(result < 0) {
			msg.innerHTML = '존재하지 않는 아이디입니다.';
			msg.classList.replace('ok','err');
			//아이디 있음, 비밀번호 틀림
		} else if (result == 0) {
			msg.innerHTML = '잘못된 비밀번호입니다.';
			msg.classList.replace('ok','err');
			//로그인 성공
		} else if (result > 0) {
			msg.innerHTML = '로그인 성공';
			msg.classList.replace('err','ok');
		} 
		
		//메시지 부분 열기
		$('#mCollapse').collapse('show');
	});
	
}

//아이디 중복 체크
function idChk(event) {
	var id = document.querySelector('#id').value;
	var msg = document.querySelectorAll('.msg')[0];
	
	if (id == 'java') {
		msg.innerHTML = '사용 가능한 아이디입니다.';
		msg.classList.replace('err','ok');
		
		//비밀번호 부분 열기
		$('#pCollapse').collapse('show');
		return;
	
	//
	} else if (id == '' || id == null) {
		msg.innerHTML = '아이디를 입력하세요.';
	} else if(id != 'java') {
		msg.innerHTML = '중복된 아이디입니다.';
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
	if ($('#eCollapse').hasClass('in') ) {
		$('#eCollapse').collapse('hide');
		document.querySelector('#email').value = '';
	}
}

//비밀번호 유효성 검사
function passwordChk(event) {
	var password, passwordChk, msg;
	password = document.querySelector('#password').value;
	passwordChk = document.querySelector('#passwordChk').value;
	msg = document.querySelectorAll('.msg')[1];
	
	//비밀번호 유효성 검사 >> 비밀번호가 유효해야 비밀번호 일치 불일치 판단
	if(!/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,15}$/.test(password)) {
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
				$('#eCollapse').collapse('show');
				return;
			}
		}
	}
	
	//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
	if ($('#eCollapse').hasClass('in') ) {
		$('#eCollapse').collapse('hide');
		document.querySelector('#email').value = '';
	}
}