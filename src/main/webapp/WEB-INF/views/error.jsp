<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script type="text/javascript">
		var result = '${result}';
		if(result == -1) {
			alert('잘못된 접근입니다.');
			location.href = '/project/home.do';
		} else {
			alert('요청사항을 수행하지 못 했습니다.');
			location.href = '/project/home.do';
		}
	</script>
</body>
</html>