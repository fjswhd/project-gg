<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>같이 가치</title>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<div class="container flex-column">
		<!-- head -->
		<c:if test="${ empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_home.jsp" />		
		</c:if>
		<c:if test="${ not empty sessionScope.member }">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div id="body" style="height: 160%; position:absolute; width: 100%; top: 20%;">
			<!-- 상단 -->
			<div class="flex-column" style="height: 50%; padding-bottom: 50px;">
				<!-- 캐러셀 -->
				<div class="flex-column f-1">
					<div class="col-md-8 mg-auto f-1 box"> 
						<div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
						<!-- Indicators -->
							<ol class="carousel-indicators">
								<li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
								<li data-target="#carousel-example-generic" data-slide-to="1"></li>
								<li data-target="#carousel-example-generic" data-slide-to="2"></li>
							</ol>
						
							<!-- Wrapper for slides -->
							<div class="carousel-inner" role="listbox" style="height: 500px;">
								<div class="item active">
									<img src="${logo}" alt="..." height="500">
									<div class="carousel-caption">
										...
									</div>
								</div>
								<div class="item">
									<img src="${community}" alt="..." height="500">
									<div class="carousel-caption">
										...
									</div>
								</div>
							
							</div>
						
						<!-- Controls -->
							<a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
								<span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
								<span class="sr-only">Previous</span>
							</a>
							<a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
								<span class="sr-only">Next</span>
							</a>
						</div>
					</div>
				</div>
				
				<!-- 스크롤 다운 버튼 -->
				<div class="j-center align-center bounce">
					<a class="btn btn-link" onclick="scrollDown()" style="width: 20%; font-size: 40px;">
						<span class="glyphicon glyphicon-chevron-down"></span>
					</a>
				</div>
			</div>
			
			<!-- 하단 -->
			<div class="flex-column" style="height: 50%;">
				<!-- 검색 -->
				<form action="${_board}/searchList.do" method="post" class="col-md-10 mg-auto" name="frm">
					<input type="hidden" name="pageNum" value="1">
					<div class="form-group align-center fade-out">
						<label class="col-md-2">언제 떠나시나요?</label>
						<span class="col-md-3">
							<input type="date" name="s_date" class="form-control" min="${today}" max="${lastday}">
						</span>
						~
						<span class="col-md-3">
							<input type="date" name="e_date" class="form-control"  min="${today}" max="${lastday}">
						</span>
					</div>
					<div class="form-group align-center fade-out">
						<label class="col-md-2">어디로 떠나시나요?</label>
						<span class="col-md-6">
							<input type="text" name="address" class="form-control" placeholder="장소를 검색해주세요.">	
						</span>
					</div>
					<div class="form-group align-center fade-out">
						<label class="col-md-2">무엇을 하실건가요?</label>
						<span class="col-md-2">
							<select name="c_no" class="form-control" required="required">
								<option value="">카테고리 선택</option>
								<c:forEach var="category" items="${categoryList}">
									<option value="${category.c_no}">${category.c_name}</option>
								</c:forEach>
							</select>				
						</span>
						<span class="col-md-4">
							<input type="text" name="keyword" class="form-control">
						</span>					
						<button class="btn btn-primary">검색하기</button>
					</div>
				</form>
				
				<!-- 새글 쓰기, 로그인해야 글 쓰기 가능 -->
				
					<div class="col-md-10 mg-auto">
						<div class="form-group align-center fade-out">
							<label class="col-md-4">아니면 새로운 만남을 만들어 볼까요?</label>
							<c:if test="${empty sessionScope.member}">
								<a href="${_member}/loginForm.do" class="btn btn-default">로그인</a>
							</c:if>
							<c:if test="${not empty sessionScope.member}">
								<a href="${_board}/insertForm.do" class="btn btn-primary">새 글 쓰기</a>
							</c:if>
						</div>
					</div>
				
				
			</div>
		</div>
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript" src="${_script}/list.js"></script>
	<script type="text/javascript">
		function scrollDown() {
			$('#body').animate({top: '-60%'}, 800, fadeIn);
		}
		
		function fadeIn() {
			$('.form-group').each(function(index) {
				var item = $(this);		
				setTimeout(function() {
					item.animate({paddingTop: '0',opacity: '1'}, 800);
				}, index*400)
			});
		}
		
		//end_date 제한
		document.querySelector('input[name="s_date"]').onchange = function() {
			var val = document.querySelector('input[name="s_date"]').value;
			document.querySelector('input[name="e_date"]').setAttribute('min', val);
			document.querySelector('input[name="e_date"]').value = '';
		}
		
		//엔터키 submit막기
		frm.addEventListener('keydown', function(e) {
			if((e.keyCode || e.which) === 13) {
				e.preventDefault();
			}
		})
		//블러되면 값을 초기화?
		frm.address.onblur = function() {
			frm.address.value = '';
		}
		
		frm.address.addEventListener('keyup', function() {
			$('[name="address"]').autocomplete({  //오토 컴플릿트 시작
	            source : //list
	            function(request, response) {
	                var results = $.ui.autocomplete.filter(list, request.term);
	                response(results.slice(0, 30));
	            },    // source 는 자동 완성 대상
	            select : function(event, ui) {    //아이템 선택시
					frm.address.blur();
	           		frm.address.value = ui.item.value;
	            },
	            open : function(event, ui) {
	            	$(this).autocomplete('widget')
	            		.css('box-shadow', '0 0 4px #808080')
	            		.css('border-radius', '5px')
	            },
	            focus : function(event, ui) {    //포커스 가면
	            	return false;
	            },
	            classes : {
	            	"ui-autocomplete": "scroll"
	            },
	            minLength: 1,// 최소 글자수
	            autoFocus: false, //첫번째 항목 자동 포커스 기본값 false
	            delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
	            position: { my : "right top", at: "right bottom" }    
	        });
		})
	</script>
</body>
</html>