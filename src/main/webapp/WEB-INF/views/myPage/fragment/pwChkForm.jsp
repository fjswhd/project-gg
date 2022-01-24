<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="modal-dialog j-center" style="font-family: 'Noto Sans KR'">
	<div class="modal-content col-md-9 pd-0">
		<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">본인 확인을 위해 비밀번호를 입력해주세요.</h4>
		</div>
		<div class="modal-body">
			<form action="" name="pwChkForm">
				<div class="form-group col-md-12">
					<label for="id">비밀번호을 입력하세요</label>
					<div class="input-group">
						<input type="password" name="password" class="form-control" required="required" placeholder="비밀번호">
						<span class="input-group-btn">
							<button id="pwChkBtn" class="btn btn-primary" type="button">확인</button>
						</span>
					</div>
					<div id="pwChkMsg" class="msg err collapse"></div>
				</div>
			</form>
		</div>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
<script type="text/javascript">
	var pwChkBtn = document.querySelector('#pwChkBtn');
	
	pwChkBtn.addEventListener('click', function() {
		var sendData = $('form[name=pwChkForm]').serialize();
		var next = '${next}';
		
		$.post('${_myPage}/pwChk.do', sendData, function(data) {
			var result = parseInt(data),
				msg = document.querySelector('#pwChkMsg')
			
			if(result < 0) {
				location.href = '${_}/error.do';
			} else if (result == 0) {
				msg.classList.add('in')
				msg.innerHTML = '잘못된 비밀번호입니다.';
			} else {
				location.href = next;
			}
			
		})
		
	})
	
	//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
	pwChkForm.addEventListener("keydown", function(event) {
	    if ((event.keyCode || event.which) === 13) {
	    	event.target.blur();
	    	event.preventDefault();
	    }
	})
</script>