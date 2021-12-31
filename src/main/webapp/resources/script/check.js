function idChk(event) {
	var id = document.querySelector('#id').value;
	var msg = document.querySelectorAll('.msg')[0];
	
	if(id != 'java') {
		msg.innerHTML = '중복된 아이디입니다.';
		msg.classList.replace('ok','err');
		
		//비밀번호 부분이 열려있으면 비밀번호, 비밀번호 확인 input의 값을 지우고 닫음
		if ($('#pCollapse').hasClass('in') ) {
			$('#pCollapse').collapse('hide');
			document.querySelector('#password').value = '';
			document.querySelector('#passwordChk').value = '';
		}
		
		//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
		if ($('#eCollapse').hasClass('in') ) {
			$('#eCollapse').collapse('hide');
			document.querySelector('#email').value = '';
		}
	} else {
		msg.innerHTML = '사용 가능한 아이디입니다.';
		msg.classList.replace('err','ok');
		
		//비밀번호 부분 열기
		$('#pCollapse').collapse('show');
	}
}

function passwordChk(event) {
	var password, passwordChk, msg;
	password = document.querySelector('#password').value;
	passwordChk = document.querySelector('#passwordChk').value;
	msg = document.querySelectorAll('.msg')[1];
	
	//비밀번호 유효성 검사 >> 비밀번호가 유효해야 비밀번호 일치 불일치 판단
	if(!/^[a-zA-Z0-9]{8,15}$/.test(password)) {
		msg.classList.replace('ok','err');
		msg.innerHTML = '비밀번호는 숫자와 영문자의 조합 8~15자로 만들어주세요.';
		
		//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
		if ($('#eCollapse').hasClass('in') ) {
			$('#eCollapse').collapse('hide');
			document.querySelector('#email').value = '';
		}
		
	} else {
		//비밀번호가 유효한 비밀번호인 경우
		msg.classList.replace('err','ok');
		msg.innerHTML = '유효한 비밀번호입니다.';
		
		//비밀번호는 유효한데 확인과 일치하지 않음
		//비밀번호와 비밀번호 확인이 비어있지 않은 경우에만 둘을 비교
		if (password != null && passwordChk !== '') {
			if (password != passwordChk) {
				msg.classList.replace('ok','err');
				msg.innerHTML = '비밀번호가 일치하지 않습니다.';
				
				//이메일 부분이 열려있으면 이메일 input의 값을 지우고 닫음
				if ($('#eCollapse').hasClass('in') ) {
					$('#eCollapse').collapse('hide');
					document.querySelector('#email').value = '';
				}
				
			//비밀번호와 확인이 일치
			} else if (password == passwordChk) {
				msg.classList.replace('err','ok');
				msg.innerHTML = '비밀번호가 일치합니다.';
				
				//이메일 부분 열기
				$('#eCollapse').collapse('show');
			}
		}
	}
}