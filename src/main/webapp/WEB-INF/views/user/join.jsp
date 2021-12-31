<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>같이 가치</title>
</head>
<body>
	<script type="text/javascript">
		var result = '${result}';
		if (result < 0) {
			alert('잘못된 접근입니다.');
		} else {
			location.href = '${_}/profileForm'
		}
	</script>
</body>
</html>