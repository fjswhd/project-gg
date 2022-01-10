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
						<a href = "replyUpdate.do?re_no=${reply.re_no}" class="btn btn-info">수정</a>
						<a href = "replyDelete.do?re_no=${reply.re_no}" class="btn btn-danger">삭제</a>
					</div>
				</c:forEach>
			</c:if>
		</div>
		<div>
			<!-- b_no는 현재게시글 번호 m_id는 세션아이디값 -->
			<form action ="replyInsert.do?b_no=1&m_id=" method="post">
			<textarea rows="5" cols="100" placeholder="댓글 달기 ..."></textarea>
			<button type="button" class="btn btn-primary" data-toggle="button" aria-pressed="false" name>
  				비밀댓글
			</button>
			<button type="submit" class="btn btn-info">게시</button>
			</form>
		</div>
		<div>
			<a href = "replySecret.do?re_no=${reply.re_no}" class="btn btn-info">비밀댓글</a>
			<a href = "replySecretCancel.do?re_no=${reply.re_no}" class="btn btn-info">공개댓글</a>
			<a href= class="btn btn-info">게시</a>
		</div>
	</div>
</body>
</html>