<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="modal-dialog j-center" style="font-family: 'Noto Sans KR'">
	<div class="modal-content col-md-10 pd-0">
		<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
			<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			<h4 class="modal-title">다른 참여자의 매너점수를 알려주세요!</h4>
		</div>
		<div class="modal-body pd-b-5">
			<form action="" name="evalForm">
				<div class="form-group flex-column align-center">
					<ul class="list-group mg-t-15 mg-b-10" style="width: 90%; box-shadow: 0 0 2px #808080; border-radius: 4px;">
						<li class="list-group-item align-center">
							<div class="col-md-4 pd-0 ellipsis">
								<c:if test="${sessionScope.member.m_id == board.m_id}">
									<span class="label label-primary mg-r-5">작성자</span>
									<a href="#myModal" class="text-muted" data-toggle="modal" title="프로필 확인" onclick="getProfile('${board.m_id}')">${board.member.nickname}</a>								
								</c:if>
								<c:if test="${sessionScope.member.m_id != board.m_id}">
									<span class="label label-primary mg-r-5">작성자</span>
									<a href="#myModal" class="text-muted" data-toggle="modal" title="프로필 확인" onclick="getProfile('${board.m_id}')">${board.member.nickname}</a>
									<input type="hidden" name="m_id" value="${board.m_id}">
									<input type="hidden" name="b_no" value="${board.b_no}">
									<input type="hidden" name="m_id_eval" value="${sessionScope.member.m_id}">
								</c:if>
							</div>
							<div class="col-md-7">
								<c:if test="${sessionScope.member.m_id == board.m_id}">
									It's You!					
								</c:if>
								<c:if test="${sessionScope.member.m_id != board.m_id && board.r_score == null}">
									<input id="r_score" type="range" name="r_score" oninput="evaluation()" min="0" max="5" step="0.5"> 
								</c:if>
								<c:if test="${sessionScope.member.m_id != board.m_id && board.r_score != null}">
									<input id="r_score" type="range" name="r_score" oninput="evaluation()" min="0" max="5" step="0.5" value="${board.r_score}"> 
								</c:if>
							</div>
							<div class="col-md-1 pd-0">
								<c:if test="${sessionScope.member.m_id != board.m_id && board.r_score == null}">
									2.5점
								</c:if>
								<c:if test="${sessionScope.member.m_id != board.m_id && board.r_score != null}">
									${board.r_score}점
								</c:if>
							</div>
						</li>
						<c:forEach var="parti" items="${partiList}">
							<li class="list-group-item align-center">
								<div class="col-md-4 pd-0 ellipsis">
									<c:if test="${sessionScope.member.m_id == parti.m_id}">
										<span class="label label-default mg-r-5">참여자</span>
										<a href="#myModal" class="text-muted" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>								
									</c:if>
									<c:if test="${sessionScope.member.m_id != parti.m_id}">
										<span class="label label-default mg-r-5">참여자</span>
										<a href="#myModal" class="text-muted" data-toggle="modal" title="프로필 확인" onclick="getProfile('${parti.m_id}')">${parti.nickname}</a>
										<input type="hidden" name="m_id" value="${parti.m_id}">
										<input type="hidden" name="b_no" value="${board.b_no}">
										<input type="hidden" name="m_id_eval" value="${sessionScope.member.m_id}">
									</c:if>
								</div>
								<div class="col-md-7">
									<c:if test="${sessionScope.member.m_id == parti.m_id}">
										It's You!							
									</c:if>
									<c:if test="${sessionScope.member.m_id != parti.m_id && parti.r_score == null}">
										<input type="range" name="r_score" oninput="evaluation()" min="0" max="5" step="0.5">
									</c:if>
									<c:if test="${sessionScope.member.m_id != parti.m_id && parti.r_score != null}">
									<input id="r_score" type="range" name="r_score" oninput="evaluation()" min="0" max="5" step="0.5" value="${parti.r_score}"> 
								</c:if>
								</div>
								<div class="col-md-1 pd-0">
									<c:if test="${sessionScope.member.m_id != parti.m_id && parti.r_score == null}">
										2.5점
									</c:if>
									<c:if test="${sessionScope.member.m_id != parti.m_id && parti.r_score != null}">
										${parti.r_score}점
									</c:if>
								</div>							
							</li>				
						</c:forEach>
					</ul>
					<div class="alert alert-warning mg-t-10 mg-b-5" role="alert">
						<i class="fas fa-exclamation mg-r-5"></i> 상호평가는 <strong>활동 종료 이후 일주일간</strong> 가능합니다.<br>
						<i class="fas fa-exclamation mg-r-5"></i> 상호평가 점수는 활동 종료 이후 <strong>일주일간 변경이 가능</strong>합니다.<br>
						<i class="fas fa-exclamation mg-r-5"></i> <strong>기간이 지나면 점수가 확정되고 변경할 수 없습니다.</strong>
					</div>
				</div>
			</form>
		</div>
		<div class="modal-footer">
			<button type="button" class="btn btn-primary" onclick="evalFormSubmit()">확인</button>
			<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
		</div>
	</div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->

<div class="modal fade" id="myModal">
	<div class="modal-dialog" style="font-family: 'Noto Sans KR'">
		<div class="modal-content">
			<div class="modal-header bg-info" style="border-top-left-radius: 5px; border-top-right-radius: 5px;">
				<h4 id="profileTitle" class="modal-title"></h4>
			</div>
			<div class="modal-body flex-column align-center">
				<img id="profileImg" class="img-circle mg-b-10" alt="" src="" width="200" height="200" style="box-shadow: 0 0 3px #808080;">
				<ul id="profileContent" class="list-group" style="width: 90%; box-shadow: 0 0 2px #808080; border-radius: 4px;">
					<li class="list-group-item flex"></li>				
					<li class="list-group-item flex"></li>				
					<li class="list-group-item flex"></li>				
					<li class="list-group-item flex"></li>				
					<li class="list-group-item flex"></li>				
				</ul>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<script type="text/javascript">
	//form안에서 키다운 이벤트가 발생했을 때 그 키의 key code가 13(enter)이면 이벤트 진행(submit)막기, 현재 커서부분 블러 처리 >> onchange 이벤트 발생
	evalForm.addEventListener("keydown", function(event) {
	    if ((event.keyCode || event.which) === 13) {
	    	event.target.blur();
	    	event.preventDefault();
	    }
	})
	
	function evaluation() {
		var score = event.target.value,
			parent = event.target.parentNode;
			scoreBoard = parent.nextElementSibling;
			
		//score = Math.round(score/100*5*100)/100;
		score = score.toString().length < 2 ? score.toString()+'.0점' : score.toString()+'점';
			
		scoreBoard.textContent = score;
	}
	
	function evalFormSubmit() {
		var sendData = $('form[name=evalForm]').serializeArray(),
			ratings = [], rating = {};
	
		sendData.forEach(function(el, idx) {
			rating[el.name] = el.value;
			if (idx%4 == 3) {
				ratings.push(rating);
				rating = {};
			}
		})
		
		$.ajax({
			url: '${_myPage}/eval.do',
			method: 'POST',
			data: JSON.stringify(ratings),
			dataType: 'html',
			contentType: 'application/json;charset=utf-8'
		}).done(function(data) {
			if(data == ratings.length) {
				alert('상호평가가 반영되었습니다.');
				$('#eval').modal('hide');
				location.href = '${_myPage}/main.do';
			} else {
				alert('요청을 수행하지 못했습니다.\r\n다시 시도해주세요.');
				$('#eval').modal('hide');
				location.href = '${_myPage}/main.do';
			}
		})
	}
	
	function getProfile(m_id) {
		var sendData = '{"m_id":"'+m_id+'"}';
		
		var title = document.querySelector('#profileTitle'),
			img = document.querySelector('#profileImg'),
			li = document.querySelectorAll('#profileContent > li');
		
		/* $.post('${_member}/getProfile.do', sendData, function() {
			title.textContent = data.nickname + '님의 프로필';
			img.src = '${_profile}/' + data.picture;
			
			li[0].innerHTML = '<span class="col-md-3 bold">레벨</span>' + data.level;				
			li[1].innerHTML = '<span class="col-md-3 bold">가입일</span>' + data.reg_date;				
			li[2].innerHTML = '<span class="col-md-3 bold">출몰지</span>' + data.place;				
			li[3].innerHTML = '<span class="col-md-3 bold">관심사</span>' + data.tag;				
			li[4].innerHTML = '<span class="col-md-3 bold">평점</span>' + data.rating;				
			
		}) */
		
		fetch('${_member}/getProfile.do', {
			method: 'POST',
			body: sendData,
			headers: {
				'Content-Type':'application/json;charset=utf-8'
			}
		}).then(function(response) {
			return response.json();
		}).then(function(data) {
			//닉네임 픽쳐 플레이스 레이팅 가입일 태그
			title.textContent = data.nickname + '님의 프로필';
			img.src = '${_profile}/' + data.picture;
			
			li[0].innerHTML = '<span class="col-md-3 bold">레벨</span><div class="col-md-9 pd-0 wordWrap">' + data.level + '</div>';
			li[1].innerHTML = '<span class="col-md-3 bold">가입일</span><div class="col-md-9 pd-0 wordWrap">' + data.reg_date + '</div>';			
			li[2].innerHTML = '<span class="col-md-3 bold">출몰지</span><div class="col-md-9 pd-0 wordWrap">' + data.place + '</div>';				
			li[3].innerHTML = '<span class="col-md-3 bold">관심사</span><div class="col-md-9 pd-0 wordWrap">' + data.tag + '</div>';				
			
			var rating = '';
			if (data.rating.toString().length == 1) {
				rating = data.rating.toString()+'.00 점'
			} else if (data.rating.toString().length == 3) {
				rating = data.rating.toString()+'0 점'
			} else {
				rating = data.rating.toString()+' 점'
			}
			
			li[4].innerHTML = '<span class="col-md-3 bold">평점</span><div class="col-md-9 pd-0 wordWrap">' + rating + '</div>';
			
		})
		
	}
</script>