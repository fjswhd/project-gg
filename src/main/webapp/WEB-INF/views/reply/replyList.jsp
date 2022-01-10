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
		<div>댓글</div>
		<div>
			<c:if test="${empty rpList }">
				<div>댓글이 없습니다.</div>
			</c:if>
			<c:if test="${not empty rpList }">
				<c:forEach var="reply" items="rpList">
					<div>
						<div>${reply.m_id }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<a href="replyUpdate.do?re_no=${reply.re_no}" class="btn btn-info">수정</a>
						<a href="replyDelete.do?re_no=${reply.re_no}"
							class="btn btn-danger">삭제</a>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<div>
			<!-- b_no는 현재게시글 번호 m_id는 세션아이디값 -->
		<!-- 	<form action="replyInsert.do?b_no=1&m_id=" method="post"
				name="replyfrm">
				<input type="hidden" name="" value="">
				<textarea rows="5" cols="100" placeholder="댓글 달기 ..."></textarea>
				<input type="button" class="btn btn-primary" data-toggle="button"
					aria-pressed="false" name> 비밀댓글
				</button>
				<button type="submit" class="btn btn-info">게시</button>
			</form> -->
			<form action="replyInsert.do?b_no=1&m_id=b" method="post" class="align-center">
					<div class="col-md-2 pd-0 j-center">
					<input type="hidden" name="re_no" value="${reply.re_no }">
					<%-- <input type="hidden" name="b_no" value="${board.b_no }">
					<input type="hidden" name="m_id" value="${m_id }"> --%>
					<input type="hidden" name="b_no" value="1">
					<input type="hidden" name="m_id" value="b">
						<h4>닉네임</h4>
					</div>
					<div class="col-md-10 list">
						
						<textarea name="content" class="form-control mg-b-5" rows="3" cols="40"></textarea>
						<div class="align-center j-end">
							<div class="btn-group mg-r-5" data-toggle="buttons"> 
								<label id="secret" class="btn btn-default btn-sm">
									<span id="secretMsg">
										<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.																
									</span>
									<input type="checkbox" name="secret">
								</label>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">쓰기</button>													
						</div>
					</div>
				</form>
		</div>
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
	};		
</script>
</body>
</html>