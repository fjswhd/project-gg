<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
</head>
<body>
<div class="narrowWidth1"  align="center">
	<h2 class="title">비밀번호 찾기</h2>
	<form action="findPw.do" method="post">
		<table>  
			<c:if test="${m_id != null }">
			<tr>		
				<td class="inputUnderLine">
					<input type="email" name="m_id" id="email" required="required" 
							value="${m_id }" class="inputLine">
				</td>
			</tr>
			</c:if>
			<c:if test="${m_id == null }">
			<tr>
				<td class="inputUnderLine">
					<input type="email" name="m_id" id="email" required="required" 
						placeholder="가입 이메일" class="inputLine">
				</td>
			</tr>  
			</c:if>
			<tr>
				<td class="text-center">
					<input type="submit" value="비밀번호 찾기" class="btn_large" id="idBtn">
				</td>
			</tr>
		</table>
		<a href="joinForm.do" class="inputLineA">회원가입</a>
		<a href="loginForm.do" class="inputLineA">로그인</a>
	</form>
</div>
</body>
</html>