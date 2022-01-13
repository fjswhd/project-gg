<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<div>댓글수정</div>

		<div>
			<!-- b_no는 현재게시글 번호 m_id는 세션아이디값 -->
			<form action="replyUpdate.do" class="align-center">
				<div class="col-md-2 pd-0 j-center">
					<input type="hidden" name="re_no" value="${reply.re_no }"> 
					<input type="hidden" name="b_no" value="${reply.b_no }"> 
					<input type="hidden" name="m_id" value="${reply.m_id }">
					<h4> ${reply.nickname }</h4>
				</div>
				<div class="col-md-10 list">
					<textarea name="content" class="form-control mg-b-5" rows="3"
						cols="40">${reply.content }</textarea>
					<div class="align-center j-end">
						<div class="btn-group mg-r-5" data-toggle="buttons">
						<span>${reply.secret}</span>
								<label id="secret" class="btn btn-default btn-sm" for="s1"> 								
								<span id="secretMsg"> 
									<i class="fas fa-lock-open mg-r-5"></i>공개댓글입니다.								
								</span>
									<input type="checkbox" name="secret" id="s1">
								</label>
								
							<c:if test="${reply.secret=='y' }">
							</c:if>
							<%-- <c:if test="${reply.secret=='n' }">
							<span id="secretMsg">
								<label id="secret" class="btn btn-default btn-sm" for="s2"> 
									<i class="fas fa-lock-open mg-r-5"></i>공개댓글입니다.
									<input type="checkbox" name="secret" value="n" id="s2">
								</label>
							</span>
									<script type="text/javascript">
									document.querySelector('#secret').onclick = function() {
										var checked = document.querySelector('input[name="secret"]').checked, 
											msg = document.querySelector('#secretMsg');
												if (checked) {
													msg.innerHTML = '<span id="secretMsg"><label id="secret" class="btn btn-default btn-sm" for="s2">'+ 
													'<i class="fas fa-lock-open mg-r-5"></i>공개댓글입니다.'+
											        '<input type="checkbox" name="secret" value="n" id="s2"></label></span>'
												} else {
													msg.innerHTML = '<span id="secretMsg"><label id="secret" class="btn btn-default btn-sm" for="s1">'+ 
													'<i class="fas fa-lock-open mg-r-5"></i>비밀댓글입니다.'+
											        '<input type="checkbox" name="secret" value="y" id="s1"></label></span>'
												}
											};
								</script>   
							</c:if> --%>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">수정</button>
					</div>
				</div>
			</form>
		</div>
	</div>

	<script type="text/javascript">
		var secret = '${reply.secret}',
		checked = document.querySelector('input[name="secret"]').checked, 
		msg = document.querySelector('#secretMsg');
		if(secret == 'y') {
			msg.innerHTML =  '<i class="fas fa-lock mg-r-5"></i>비밀댓글입니다.'
			checked = true;
		}
		
		document.querySelector('#secret').onclick = function() {
			checked = document.querySelector('input[name="secret"]').checked;
			if (checked) {
				msg.innerHTML = '<i class="fas fa-lock-open mg-r-5"></i>공개댓글입니다.';
			} else {
				msg.innerHTML = '<i class="fas fa-lock mg-r-5"></i>비밀댓글입니다.';
			}
		};
	</script>
</body>
</html>