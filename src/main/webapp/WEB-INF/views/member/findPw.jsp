<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<div align="center">
	<h2 class="title">비밀번호 찾기</h2>
	<c:if test="${result == 1 }">
		<table>
			<tr>
				<th class="text-center">${member.m_id }로 임시 비밀번호를 전송하였습니다. 로그인 후 비밀번호를 변경해주세요.</th>
			</tr>
		</table>
		<br>
		<button onclick="location.href='loginForm.do'" class="btn_large">로그인</button>
	</c:if>
	<c:if test="${result == 0 }">
		<table>
			<tr>
				<th>${msg }</th>
			</tr>
		</table>
	</c:if>
	<c:if test="${result == -1 }"> 
		<script type="text/javascript">
			alert("찾을 수 없는 계정입니다");
			history.go(-1);
		</script>
	</c:if>
</div>
</body>
</html>