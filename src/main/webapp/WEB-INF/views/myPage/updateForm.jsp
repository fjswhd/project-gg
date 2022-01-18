<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
// 중복체크안해도 submit 버튼 활성화 
	$(function() { 
		var nickname = '${member.nickname }'; 
			if (nickname == frm.nickname.value || nickname.equals(frm.nickname.value)) {
				$("#submit").attr('disabled', false); 
			} else {
				$("#submit").attr('disabled', true); 
	} 
	}); 
	
	// 닉네임 중복체크 function
	function(nickChk() {
		if(!frm.nickname.value) { 
			alert("닉네임을 입력하세요")
			frm.nickname.focus(); 
			frm.nickname.value=""; 
			return false; 
			} else { 
				$.post('nickChkMy.do', 'nickname='+frm.nickname.value+'&m_id='+'${member.m_id}', function(data) { 
					$('#nickChk').html(data); 
					if (data == '사용가능한 닉네임입니다.') { 
						$("#submit").attr('disabled', false); 
						} else {
							$("#submit").attr('disabled', true); 
							} 
					}); 
				} 
		} // 파일 업로드 미리보기 완성
	function preView(fis) { 
			var str = fis.value;
				$('.thumbnail').text(fis.value.substring(str.lastIndexOf("\\")+1)); 
				// 이미지를 변경
				var reader = new FileReader(); 
					reader.onload = function(e) {
						$('.thumbnail').attr('src',e.target.result); 
						}
					reader.readAsDataURL(fis.files[0]); 
					} 
				//파일이름 
				$(document).ready(function() { 
					var fileTarget = $('.filebox .upload-hidden');
						fileTarget.on('change', function() {
							// 값이 변경되면 
							if(window.FileReader){
								var filename = $(this)[0].files[0].name; 
							} else {
								$(this).siblings('.upload-name').val(filename); 
							); 
						});
</script>
<div class="col-md-5 mg-auto box">
			<form action="${_}/join" method="post" name="frm">
				<div id="eCollapse" class="collapse">
					<div class="form-group">
						<label for="email">이메일을 입력하세요.</label>
						<input type="email" id="email" name="email" class="form-control" required="required">
						<input type="button" onclick="idChk()" value="이메일 인증"
							class="btn_sm_full2">
						<div id="idChk" class="err"></div>
					</div>
					<div id="pCollapse" class="collapse">
						<div class="form-group">
							<label for="password">비밀번호를 입력하세요.</label> <input type="password"
								id="password" name="password" class="form-control"
								required="required" placeholder="비밀번호">
						</div>
						<div class="form-group">
							<label for="passwordChk">비밀번호를 확인해주세요.</label> <input
								type="password" id="passwordChk" name="passwordChk"
								class="form-control" required="required" placeholder="비밀번호 확인">
							<div class="msg err"></div>
						</div>
					</div>
					<div class="flex" style="justify-content: flex-end;">
						<button type="submit" class="btn btn-primary">가입하기</button>
					</div>
				</div>
			</form>
		</div>
</body>
</html>