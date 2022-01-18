<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:if test="${result == 1 }">
	<script type="text/javascript">
		alert("비밀번호 변경 성공");
		location.href="myMain.do";
	</script>
</c:if>
<c:if test="${result != 1 }">
	<script type="text/javascript">
		alert("비밀번호 변경 실패");
		history.go(-1);
	</script>
</c:if>
</body>
</html>