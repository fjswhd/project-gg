<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="panel panel-default mg-b-0">
	<div class="panel-heading j-center">
		<a href="#collapseReply" class="h3 panel-title align-center" data-toggle="collapse">
			댓글
			<c:if test="${empty replyList}">
				<span class="badge mg-l-5">0</span>
			</c:if>
			<c:if test="${not empty replyList}">
				<span class="badge mg-l-5">${replyList.size()}</span>
			</c:if>
		</a>
	</div>
	<div class="panel-collapse collapse in" id="collapseReply">
		<ul class="list-group">
		<c:if test="${empty replyList}">
			<li class="list-group-item">
				<h5>댓글이 존재하지 않습니다.<small class="mg-l-5">첫번째 댓글을 남겨주세요.</small></h5>					
			</li>		
		</c:if>
		<c:if test="${not empty replyList}">
			<c:forEach var="reply" items="${replyList}">
				<!-- 삭제된 댓글인 경우 -->
				<c:if test="${reply.del == 'y'}">
					<li class="list-group-item flex">
						<c:if test="${reply.re_step > 0}">
							<div class="col-md-1 j-center align-center">
								<i class="fas fa-reply fa-lg fa-rotate-180 mg-r-5"></i>
							</div>
						</c:if>		
						<h5><i class="fas fa-times-circle mg-r-5"></i>삭제된 댓글입니다.</h5>					
					</li>	
				</c:if>
				
				<!-- 비밀댓글 yes && !(세션아이디 == 글아이디 || 세션아이디 == 댓글아이디 || 세션아이디 == 댓글 원주인 아이디) -->
				<c:if test="${reply.del == 'n' && reply.secret == 'y' && !(sessionScope.member.m_id == reply.board.m_id || sessionScope.member.m_id == reply.m_id || sessionScope.member.m_id == reply.re_master)}">
					<li class="list-group-item flex">
						<c:if test="${reply.re_step > 0}">
							<div class="col-md-1 j-center align-center">
								<i class="fas fa-reply fa-lg fa-rotate-180 mg-r-5"></i>
							</div>
						</c:if>	
						<h5><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</h5>					
					</li>	
				</c:if>
				
				
				<!-- 비밀댓글 no || (세션아이디 == 글아이디 || 세션아이디 == 댓글아이디) -->
				<c:if test="${reply.del == 'n' && (reply.secret == 'n' || (sessionScope.member.m_id == reply.board.m_id || sessionScope.member.m_id == reply.m_id || sessionScope.member.m_id == reply.re_master))}">
					<li class="list-group-item pd-t-5 flex re_${reply.re_ref}" style="word-break: break-all;">
						<c:if test="${reply.re_step > 0}">
							<div class="col-md-1 j-center align-center">
								<i class="fas fa-reply fa-lg fa-rotate-180 mg-r-5"></i>
							</div>
						</c:if>						
						<div> 
							<div class="align-center">
								<div class="h4 align-center">
									<a href="#myModal" class="mg-r-5" style="color: #000;" data-toggle="modal" title="프로필 확인" onclick="getProfile('${reply.m_id}')">
										${reply.member.nickname}
									</a>
									<c:if test="${reply.m_id == reply.board.m_id }">
										<div class="label label-primary mg-r-5" style="font-size: 10px;">작성자</div>
									</c:if>
									<small class="mg-r-5">
										${reply.reg_date}
									</small>
								</div>
								<c:if test="${reply.secret == 'y' }">
									<i class="fas fa-lock mg-r-5"></i>
								</c:if>
								<c:if test="${not empty sessionScope.member && reply.re_step == 0}">
									<a class="cursor-no-line mg-r-5" title="답글" onclick="replyToReply('${reply.re_ref}')">
										<i class="fas fa-reply"></i>																		
									</a>							
								</c:if>
								<c:if test="${sessionScope.member.m_id == reply.m_id }">
									<c:url var="replyDelete" value="/reply/delete.do">
										<c:param name="re_no" value="${reply.re_no}" />
										<c:param name="b_no" value="${reply.b_no}" />
									</c:url>
									<a href="${replyDelete}" class="text-danger cursor-no-line" title="삭제" onclick="deleteReplyConfirm()">
										<i class="fas fa-times-circle"></i>																		
									</a>							
								</c:if>
							</div>
							<pre style="padding: 0; background: #fff; font-family: sans-serif; border: none; border-radius: 0;">${reply.content}</pre>
						</div>
					</li>
				</c:if>
			
			</c:forEach>
		</c:if>
		
		<!-- 로그인 한 경우에만 댓글 허용 -->
		<c:if test="${not empty sessionScope.member}">
			<li id="writeReply" class="list-group-item">
				<form action="${_reply}/insert.do" method="post" name="frm" class="align-center">
					<input type="hidden" name="b_no" value="${b_no}">
					<input type="hidden" name="m_id" value="${sessionScope.member.m_id}">
					<input type="hidden" name="re_ref" value="0">
					<input type="hidden" name="re_step" value="0">
					<div class="col-md-2 pd-0 j-center">
						<h4><i id="nick" class="fas fa-reply fa-rotate-180 mg-r-5 hide"></i>${sessionScope.member.nickname}</h4>
					</div>
					<div class="col-md-10 list">
						<textarea name="content" class="form-control mg-b-5" rows="3" cols="40"></textarea>
						<div id="buttons" class="align-center j-end">
							<div class="btn-group mg-r-5" data-toggle="buttons"> 
								<label id="secret" class="btn btn-default btn-sm ">
									<span class="secretMsg">
										<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.																
									</span>
									<input type="checkbox" name="secret">
								</label>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">쓰기</button>
							<button id="cancelReToRe" type="button" class="btn btn-danger btn-sm mg-l-5 hide">대댓글 취소</button>													
						</div>
					</div>
				</form>
			</li>
		</c:if>
		
		</ul>
	</div>
</div>
<script type="text/javascript">
	//input의 value값이 계속 on >> value대신 checked로 클릭여부 판단
	//웃긴건 값은 잘 넘어감..
	//왜 checked로 쓰는걸 알게 됐더라? >> input checkbox를 검색하다가 알게된 듯 하다.
	//bootstrap에서 버튼 토글의 문구 교체를 고민하다가 고안한 방법
	if(document.querySelectorAll('label')) {
		var labels = document.querySelectorAll('label');
		labels.forEach(function(element, index) {
			element.addEventListener('click', function() {
				
				var checked = document.querySelectorAll('input[name="secret"]')[index].checked,
					msg = document.querySelectorAll('.secretMsg')[index];
				
				if (!checked) {
					msg.innerHTML = '<i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.';
				} else {
					msg.innerHTML = '<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.';
				}
			})
		})
	}
	
	var button = document.querySelector('#cancelReToRe');
	var icon = document.querySelector('#nick');
	var writeForm = document.querySelector('#writeReply');
	
	if(button) {
		button.addEventListener('click', function() {
			document.querySelector('ul.list-group').appendChild(writeForm);
			
			button.classList.add('hide');
			icon.classList.add('hide');
			
			frm.re_ref.value = '0';
		});
	}
	
	function replyToReply(re_ref) {
		var targets = document.querySelectorAll('.re_'+re_ref);
		var target = targets[0];
		
		frm.re_ref.value = re_ref;
		
		document.querySelector('ul.list-group').insertBefore(writeForm, target.nextSibling);
		
		button.classList.remove('hide');
		icon.classList.remove('hide');
	}
	
	function deleteReplyConfirm() {
		if(!confirm('댓글을 삭제하시겠습니까?')) {
			event.preventDefault();
		} 
	}
</script>