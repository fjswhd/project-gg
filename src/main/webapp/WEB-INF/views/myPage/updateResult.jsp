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
	<c:if test="${result > 0 }">
		<script type="text/javascript">
			alert("정보가 성공적으로 수정되었습니다");
			location.href="myMain.do";
		</script>
	</c:if>
	<c:if test="${result < 0 }">
		<script type="text/javascript">
			alert("다시 시도해 주세요");
			history.back();
		</script>
	</c:if>
</body>
</html>