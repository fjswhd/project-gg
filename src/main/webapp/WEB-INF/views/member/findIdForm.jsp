<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style type="text/css">
td, th {
	padding: 14px 0px;	
}

#idBtn {
	margin-top: 30px;
}
</style>
<body>
<div align="center" class="narrowWidth1">
	<h2 class="title ">아이디 찾기</h2>
	<form action="findIdResult.do" method="post">
		<table>
			<tr>
				<td class="inputUnderLine">
					<input type="text" name="MB_name" required="required" autofocus="autofocus" 
					       placeholder="이름" class="inputLine">
				</td>
			</tr>
			<tr>
				<td class="inputUnderLine">
					<input type="tel" name="MB_tel" id="tel" required="required"
						   title="형식 010-0000-0000" 	pattern="\d{3}-\d{4}-\d{4}" 
						   placeholder="가입휴대폰번호" class="inputLine">
				 </td>
			</tr>
			<tr>
				<td class="text-center">
					<input type="submit" value="아이디 찾기" class="btn_large" id="idBtn">
				</td>
			</tr>
		</table>
		<a href="findPwForm.do" class="inputLineA">비밀번호 찾기</a>&nbsp;|&nbsp;
		<a href="joinForm.do" class="inputLineA">회원가입</a>&nbsp;|&nbsp;
		<a href="loginForm.do" class="inputLineA">로그인</a>
	</form>
</div>
</body>
</html>