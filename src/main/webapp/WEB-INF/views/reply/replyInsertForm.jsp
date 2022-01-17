<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function reInsert(){
		$.ajax({
			type:'GET',
			url : 'replyInsert.do',
			data :$("#replyForm").serialize(),
			
		});
	}
</script>
</head>
<body>
<div>
			<!-- b_no는 현재게시글 번호 m_id는 세션아이디값 -->
			<form id="replyForm" class="align-center">
				<div class="col-md-2 pd-0 j-center">
					<%-- <input type="hidden" name="b_no" value="${board.b_no }">
					<input type="hidden" name="m_id" value="${m_id }"> --%>
					<input type="hidden" name="b_no" value="1"> 
					<input type="hidden" name="m_id" value="b">
					<h4>닉네임</h4>
				</div>
				<div class="col-md-10 list">

					<textarea name="content" class="form-control mg-b-5" rows="3"
						cols="40"></textarea>
					<div class="align-center j-end">
						<div class="btn-group mg-r-5" data-toggle="buttons">
							<label id="secret" class="btn btn-default btn-sm"> 
							<span id="secretMsg"> <i class="fas fa-lock-open mg-r-5"></i>
								공개 댓글입니다.
							</span> <input type="checkbox" name="secret">
							</label>
						</div>
						<button type="submit" class="btn btn-primary btn-sm" onclick="reInsert()">쓰기</button>
					</div>
				</div>
			</form>
		</div>
	
	<script type="text/javascript">
	document.querySelector('#secret').onclick = function() {
		var checked = document.querySelector('input[name="secret"]').checked,
		msg = document.querySelector('#secretMsg');
		
		if (!checked) {
			msg.innerHTML = '<i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.';
		} else {
			msg.innerHTML = '<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.';
		}
	}	
	
	</script>
	
</body>
</html>