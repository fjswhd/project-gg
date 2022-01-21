<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이 가치</title>
</head>
<body>
	<script type="text/javascript">
	frm.nickname.addEventListener('change', nickChk)
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
		} else if (result == '1') {
			msg.innerHTML = '사용 가능한 별명입니다.';
			msg.classList.replace('err','ok');
			document.querySelector('button[type="submit"]').removeAttribute('disabled');
			return;
		} else if(result != '1') {
			msg.innerHTML = '중복된 별명입니다.';
		}
	}
	
</script>
	<div class="col-md-5 mg-auto box">
		<form action="${_myPage}/Update.do" method="post" name="frm" enctype="multipart/form-data">
			<input type="hidden" name="m_id" value="${member.m_id }">
			<div class="j-center mg-b-10"
				style="color: #808080; position: relative;">
				<label class="btn btn-sm img-btn" for="picture"> <i
					class="far fa-images mg-r-5"></i><strong>등록</strong>
				</label> <input type="file" id="picture" name="picture" class="hide">
				<div id="image">
					<i class="fas fa-user-circle fa-10x"></i>
				</div>
			</div>
			<div class="form-group">
				<label for="nickname">수정할 별명을 입력해주세요.</label> <input type="text"
					id="nickname" name="nickname" class="form-control" placeholder="별명">
				<div class="j-between">
					<div class="msg err"></div>
				</div>
			</div>
			<div class="form-group mg-t-5">
				<label for="birthday">레벨 측정을 위해 생일을 입력해주세요.</label> <input
					type="date" id="birthday" name="birthday" class="form-control"
					min="1900-01-01">
			</div>
			<div class="form-group">
				<label for="place">주요 출몰지(활동 지역)를 알려주세요.</label> <input type="text"
					id="place" name="place" class="form-control" placeholder="주요 출몰지">
				<div class="msg err"></div>
			</div>
			<div class="form-group">
				<label for="tag">당신의 관심사를 알려주세요.</label> <input type="text" id="tag"
					name="tag" class="form-control" placeholder="#관심사">
			</div>
			<div class="j-end">
				<button type="submit" class="btn btn-primary mg-r-5">수정 완료</button>
			</div>
		</form>
	</div>


	<!-- <button type="submit" class="btn btn-primary">수정 완료</button> -->
</body>
</html>