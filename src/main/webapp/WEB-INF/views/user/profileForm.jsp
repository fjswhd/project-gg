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
	<div class="container flex-column">
		<!-- header -->
		<div class="align-center head">
			<div class="col-md-9">
				<img id="logo" alt="" src="${logo}" height="100">
			</div>
			<div class="align-center">
				<span style="color: gray;"> 이미 가입하셨나요? </span>			
				<a href="${_}/loginForm" class="btn btn-lg btn-link">로그인하기</a>
			</div>
		</div>
		
		<!-- body -->
		<div class="col-md-4 mg-auto box">
			<form action="${_}/join" method="post" name="frm">
				<div class="j-center mg-b-10" style="color: #808080; position: relative;">
					<label class="btn btn-sm img-btn" for="picture">
						<i class="far fa-images mg-r-5"></i><strong>등록</strong>
					</label>
					<input type="file" id="picture" name="picture" class="hide">
					<div id="image"><i class="fas fa-user-circle fa-10x"></i></div>
				</div>
				<div class="form-group mg-t-5">
					<label for="birthday">레벨 측정을 위해 생일을 입력해주세요.</label>
					<input type="date" id="birthday" name="birthday" class="form-control">
				</div>
				<div class="form-group">
					<label for="place">주요 출몰지(활동 지역)를 알려주세요.</label>
					<input type="text" id="place" name="place" class="form-control" placeholder="주요 출몰지">
					<div class="msg err"></div>
				</div>				
				<div class="form-group">
					<label for="tag">당신의 관심사를 알려주세요.</label>
					<input type="text" id="tag" name="tag" class="form-control" placeholder="#관심사" required="required">
				</div>
				<div class="j-end">
					<button type="submit" class="btn btn-primary mg-r-5">작성 완료</button>						
					<button type="button" class="btn btn-default">건너뛰기</button>						
				</div>
				
			</form>
		</div>
	
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript">
		document.querySelector("#picture").onchange = function (event) {
			var image = event.target.files[0],
			reader = new FileReader();
				
			reader.onload = function(event){
				var img = document.createElement("img");
				img.setAttribute("src", event.target.result);
				img.setAttribute("class", "img-circle");
				img.setAttribute("height", "140");
				img.setAttribute("width", "140");
				document.querySelector("div#image").innerHTML = '';
				document.querySelector("div#image").appendChild(img);
			};
				
			console.log(image);
			reader.readAsDataURL(image);
			
		}
	</script>
</body>
</html>