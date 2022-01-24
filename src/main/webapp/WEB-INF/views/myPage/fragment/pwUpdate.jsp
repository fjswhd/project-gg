<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
</head>
<body>
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("비밀번호가 변경되었습니다.")
			location.href = "${_member}/loginForm.do"; /*  b_no에 board.b_no  */
		</script>
	</c:if>
	<c:if test="${result == 0 }">
		<script type="text/javascript">
			alert("변경 실패")
			location.href = "${_member}/loginForm.do"; 
		</script>
	</c:if>
</body>
</html>