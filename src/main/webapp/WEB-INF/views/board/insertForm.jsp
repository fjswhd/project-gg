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
			<form action="${_board}/insert.do" method="post" name="frm" class="flex-column f-1">
				<!-- 조회수, 작성자(세션의 유저)  -->
				<input type="hidden" name="readcount" value="0">
				<input type="hidden" name="m_id" value="${sessionScope.member.m_id}">
				
				<!-- 활동 일시 -->
				<div class="align-center f-s mg-b-5">
					<span class="col-md-2 j-center">
						<label>활동 일시</label>					
					</span>
					<span class="col-md-2 pd-0">
						<input type="date" name="s_date" class="form-control input-sm" title="활동 시작일" required="required" min="${today}" max="${lastday}">
					</span>
					<span class="col-md-1 j-center pd-0">
						~
					</span>
					<span class="col-md-2 pd-0">
						<input type="date" name="e_date" class="form-control input-sm" title="활동 종료일" required="required" min="${today}" max="${lastday}">
					</span>
				</div>
				
				<!-- 모집 인원 -->
				<div class="align-center f-s mg-b-5">
					<span class="col-md-2 j-center">
						<label>모집 인원</label>					
					</span>
					<span class="col-md-2 pd-0">
						<input type="number" id="m_count" name="m_count" class="form-control input-sm" placeholder="글쓴이 포함 총원" title="모집인원은 글쓴이를 포함한 인원을 적어주세요." required="required" min="2" max="20">
					</span>
				</div>
				
				<!-- 모집 장소 -->
				<div class="align-center f-s mg-b-5">
					<span class="col-md-2 j-center">
						<label>모집 장소</label>					
					</span>
					<span class="col-md-10 pd-0">
						<span class="input-group input-group-sm">
							<input type="hidden" name="address">
							<span id="searchResult" class="mg-r-5">장소를 검색해주세요. </span>
							<button id="placeSearch" type="button" class="btn btn-primary btn-sm">위치 검색	</button>							
						</span>
					</span>
				</div>
				
				<!-- 카테고리, 제목 -->
				<div class="align-center f-s mg-b-5">
					<span class="col-md-2">
						<select name="c_no" class="form-control input-sm" required="required">
							<option value="">카테고리</option>
							<c:forEach var="category" items="${categoryList}">
								<option value="${category.c_no}">${category.c_name}</option>
							</c:forEach>
						</select>					
					</span>
					<span class="col-md-10 pd-0">
						<input type="text" name="subject" class="form-control input-sm" placeholder="제목" required="required">					
					</span>
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
		
		document.querySelector('#placeSearch').onclick = function() {
			window.open('/project/board/placeSearch', '장소검색', 'width=1300, height=700, scrollbars=no, resizable=no, left=100, top=50');
		}
		//submit할 때 에디터의 값을 content로 보내기
		document.querySelector('#submit').onclick = function() {
			var html = editor.getHTML();
			document.querySelector('input[name="content"]').value = html;
		}
		//end_date 제한
		document.querySelector('input[name="s_date"]').onchange = function() {
			var val = document.querySelector('input[name="s_date"]').value;
			document.querySelector('input[name="e_date"]').setAttribute('min', val);
			document.querySelector('input[name="e_date"]').value = '';
		}
		
		frm.onsubmit = function(event) {
			var m_count = parseInt(frm.m_count.value);
			
			if(m_count < 2) {
				event.preventDefault();
				
				$('[name="m_count"]').popover({
					html: true,
					content: '모집인원은 <b>2명 이상</b>이어야합니다.',
					template: '<div class="popover" role="tooltip"><div class="arrow"></div><div class="popover-content"></div></div>'
				});
				$('[name="m_count"]').popover('show');
				$('[name="m_count"]').focus();
				$('[name="m_count"]').on('blur', function() {
					$('[name="m_count"]').popover('destroy');
				})
				return;	
			}
			
			var address = $('[name="address"]');
			
			if(!address.val()) {
				event.preventDefault();
				
				$('#placeSearch').popover({
					html: true,
					content: '모집 기준이 될 장소를 정해주세요.',
					template: '<div class="popover" role="tooltip"><div class="arrow"></div><div class="popover-content"></div></div>'
				});
				
				$('#placeSearch').popover('show');
				setTimeout(() => {
					$('#placeSearch').popover('destroy');
				}, 2000);
			}
		}
	</script>
</body>
</html>