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

	<div class="container flex-column" style="">
		<!-- head -->
		<div class="align-end head">
			<div class="col-md-7">
				<img id="logo" alt="" src="${logo}" height="100">
			</div>
		
			<div class="j-end align-end f-1" style="margin-bottom: 15px;">
				<div class="pd-3">
					<a href="${_}/loginForm.do" class="btn btn-link"><b>공지사항</b></a>				
					<a href="${_}/loginForm.do" class="btn btn-primary">로그인</a>				
					<a href="${_}/joinForm.do" class="btn btn-default">회원가입</a>
				</div>
			</div>
		
		</div>
		
		<!-- body -->
		<div id="body" style="height: 160%; position:absolute; width: 100%; top: 20%;">
			<!-- 상단 -->
			<div class="flex-column" style="height: 50%; padding-bottom: 50px;">
				<!-- 캐러셀 -->
				<div class="flex-column f-1">
					<div class="col-md-8 mg-auto f-1 box"> 
						캐러셀 들어갈 자리입니다.
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
				<form action="" class="col-md-10 mg-auto">
					<div class="form-group align-center fade-out">
						<label class="col-md-2">언제 떠나시나요?</label>
						<span class="col-md-3">
							<input type="date" name="s_date" class="form-control">
						</span>
						<span class="col-md-3">
							<input type="date" name="e_date" class="form-control" placeholder="언제까지">
						</span>
					</div>
					<div class="form-group align-center fade-out">
						<label class="col-md-2">어디로 떠나시나요?</label>
						<span class="col-md-6">
							<input type="text" class="form-control">										
						</span>
					</div>
					<div class="form-group align-center fade-out">
						<label class="col-md-2">무엇을 하실건가요?</label>
						<span class="col-md-2">
							<select name="category" class="form-control">
								<option value="10">여행</option>
								<option value="20">맛집</option>
								<option value="30">스터디</option>
							</select>				
						</span>
						<span class="col-md-4">
							<input type="text" class="form-control">
						</span>					
						<button class="btn btn-primary">검색하기</button>
					</div>
				</form>
				
				<!-- 새글 쓰기 -->
				<div class="col-md-10 mg-auto">
					<div class="form-group align-center fade-out">
						<label class="col-md-4">아니면 새로운 만남을 만들어 볼까요?</label>
						<a href="${_board}/insertForm" class="btn btn-primary">새 글 쓰기</a>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
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
	</script>
</body>
</html>