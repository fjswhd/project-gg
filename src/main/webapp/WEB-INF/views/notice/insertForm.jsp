<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<script src="https://uicdn.toast.com/editor/latest/i18n/ko-kr.js"></script>
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor.min.css" />
</head>
<body>
	<div class="container flex-column" style="overflow: hidden">
		<!-- header -->
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div class="col-md-9 mg-auto box flex" style="height: 75%; top: 20%;">
			<form action="${_notice}/insert.do" method="post" name="frm" class="flex-column f-1">
				<!-- 조회수, 작성자(세션의 유저)  -->
				<input type="hidden" name="readcount" value="0">
				<input type="hidden" name="m_id" value="${sessionScope.member.m_id}">
				
				<!-- 카테고리, 제목 -->
				<div class="align-center f-s mg-b-5">
					<input type="text" name="subject" class="form-control input-sm" placeholder="제목" required="required">					
				</div>
				
				<!-- 웹 에디터 -->
				<div class="j-center f-g mg-b-5">
					<div id="text-editor" class="editor"></div>
					<input type="hidden" name="content">
				</div>
				<div class="align-center f-s j-end">
					<button id="submit" type="submit" class="btn btn-primary mg-r-5">작성하기</button>
					<a href="${_}/home" class="btn btn-danger">취소</a>
				</div>
			</form>
		</div>
		
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		const editor = new toastui.Editor({
			el: document.querySelector('#text-editor'),
			height: '100%',
			language: 'ko-KR',
			toolbarItems: [
				['heading', 'bold', 'italic', 'strike'],
			    ['hr', 'quote'],
			    ['ul', 'ol', 'task', 'indent', 'outdent'],
			    ['table', 'link']
			  ],
			placeholder: '내용을 입력하세요.',
			hideModeSwitch: true,
			initialEditType: 'wysiwyg'
		});
		//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
		document.querySelectorAll('input').forEach(function(element) {
			element.addEventListener("keydown", function(event) {
			    if ((event.keyCode || event.which) === 13) {
			    	event.target.blur();
			    	event.preventDefault();
			    }
			})
		})
		
		
		//submit할 때 에디터의 값을 content로 보내기
		document.querySelector('#submit').onclick = function() {
			var html = editor.getHTML();
			document.querySelector('input[name="content"]').value = html;
		}
		
	</script>
</body>
</html>