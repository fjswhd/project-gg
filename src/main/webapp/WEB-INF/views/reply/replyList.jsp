<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	
</script>
</head>
<body>
	<div>
		<div>댓글</div>
		<div>
			<c:if test="${empty rpList }">
				<div>댓글이 없습니다.</div>
			</c:if>
			<c:if test="${not empty rpList }">
				<c:forEach var="reply" items="${rpList}">
					<c:if test="${reply.secret == 'y' }"> 
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
					</c:if>
					<c:if test="${reply.secret == 'y' }"> <%--조건 추가 && 세션아이디 ==reply.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<button class="btn btn-warning" id="update">수정</button>
						<a href="replyDelete.do?re_no=${reply.re_no}"
							class="btn btn-danger">삭제</a>
						<button class="btn btn-info">답글</button>
					</c:if>
						<c:if test="${reply.secret == 'y' }"> <%--조건 추가 && 세션아이디 == board.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<button class="btn btn-info">답글</button>
					</c:if>
					<c:if test="${reply.secret == 'n' }"> 
					<div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<button class="btn btn-info">답글</button>
					</div>
					</c:if>
					<c:if test="${reply.secret == 'n' }"> <%--조건 추가  || 세션아이디 ==reply.m_id  --%>
					<div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<button class="btn btn-warning" class="update">수정</button>
						<a href="replyDelete.do?re_no=${reply.re_no}"
							class="btn btn-danger">삭제</a>
						<button class="btn btn-info">답글</button>
					</div>
					</c:if>
					
				</c:forEach>
			</c:if>
		</div>
		<div>
			<!-- b_no는 현재게시글 번호 m_id는 세션아이디값 -->
			<form action="replyInsert.do?b_no=1&m_id=b" class="align-center">
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
	}	
	</script>
	

	<div align="center">
	<ul class="pagination ">
	<!-- 시작 페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
		<c:if test="${pb.startPage > pb.pagePerBlock }">
		<!-- b_no은 board.b_no, m_id는  -->
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=1">
				<span class="glyphicon glyphicon-step-backward"></span></a></li>
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.startPage-1}" aria-label="Previous">
				<span class="glyphicon glyphicon-triangle-left"></span></a></li>
		</c:if>
		
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage==i }">
				<li class="active"><a href="replyList.do?b_no=1&m_id=b&pageNum=${i}">${i}</a></li>
			</c:if>
			<c:if test="${pb.currentPage!=i }">
				<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${i}">${i}</a></li>
			</c:if>
		</c:forEach>
		
		<!-- 보여줄 것이 남아있는 경우에는 endPage보다 totalPage가 큰경우 -->
		<c:if test="${pb.endPage < pb.totalPage }">
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.endPage+1}">
				<span class="glyphicon glyphicon-triangle-right"></span></a></li>
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.totalPage}">
				<span class="glyphicon glyphicon-step-forward"></span></a></li>
		</c:if>
	</ul>
</div>
</body>
</html>