<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
	<script src="https://uicdn.toast.com/editor/latest/toastui-editor-all.min.js"></script>
	<link rel="stylesheet" href="https://uicdn.toast.com/editor/latest/toastui-editor-viewer.min.css" />
</head>
<body>
	<div class="container flex-column" style="overflow: hidden">
		
		<!-- header -->
		<c:if test="${ empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_home.jsp" />		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div class="mg-auto box flex-column" style="position: relative; width:90%; height: 75%; top: 20%;">
			<!-- 제목, 닉네임, 등록일, 조회수-->
			<div class="align-center j-between shadow-bottom mg-b-15" style="height: 10%; padding: 10px;">
				<span class="h3">
					${notice.subject} 
					<small>${notice.member.nickname} | ${notice.reg_date}</small>
				</span>
				<span>
					<c:if test="${sessionScope.member.admin == 'y'}">
						<a href="${_notice}/updateForm.do?no_no=${notice.no_no}" class="btn btn-warning btn-sm">수정<i class="fas fa-undo-alt mg-l-5"></i></a>
						<a href="${_notice}/delete.do?no_no=${notice.no_no}" class="btn btn-danger btn-sm" onclick="deleteConfirm()">삭제<i class="fas fa-trash-alt mg-l-5"></i></a>
					</c:if>
						<a href="${_notice}/list.do" class="btn btn-default btn-sm">목록<i class="fas fa-list mg-l-5"></i></a>
				</span>
			</div>
			
			<div class="flex f-g mg-t-5" style="overflow: hidden;">
				<!-- 내용, 참여자 -->
				<div class="f-g scroll" style="overflow: auto; position: relative;">
					<div class="flex-column pd-b-5 pd-r-5" style="position: absolute; width: 100%;">
						<!-- 내용 -->
						<div id="viewer" class="shadow-bottom mg-b-5 pd-10"></div>
					</div>
				</div>
			</div>
		</div>	
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		var viewer = toastui.Editor.factory({
			el: document.querySelector('#viewer'),
			viewer: true,
			initialValue: '${notice.content}'
		});
		
		function deleteConfirm() {
			if(!confirm('공지를 삭제하시겠습니까?')) {
				event.preventDefault();
			}
		}
	</script>
</body>
</html>