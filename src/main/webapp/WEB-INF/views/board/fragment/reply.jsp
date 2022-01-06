<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="panel panel-default mg-b-0">
	<div class="panel-heading j-center">
		<a href="#collapseReply" class="h3 panel-title align-center" data-toggle="collapse">
			댓글<span class="badge mg-l-5">4</span>
		</a>
	</div>
	<div class="panel-collapse collapse in" id="collapseReply">
		<ul class="list-group">
			<li class="list-group-item pd-t-5">
				<div class="align-center">
					<a href="#" class="h4 mg-r-5">닉네임</a>
					<a href="#" class="text-danger cursor-no-line" title="삭제">
						<i class="fas fa-times-circle"></i>																		
					</a>
				</div>
				안녕하세요.
			</li>
			<li class="list-group-item pd-t-5">
				<div class="align-center">
					<a href="#" class="h4 mg-r-5">닉네임</a>
					<a href="#" class="text-danger cursor-no-line" title="삭제">
						<i class="fas fa-times-circle"></i>																		
					</a>
				</div>
				안녕하세요.2
			</li>
			<li class="list-group-item pd-t-5">
				<div class="align-center">
					<a href="#" class="h4 mg-r-5">닉네임</a>
					<a href="#" class="text-danger cursor-no-line" title="삭제">
						<i class="fas fa-times-circle"></i>																		
					</a>
				</div>
				안녕하세요.
			</li>
			<li class="list-group-item pd-t-5">
				<div class="align-center">
					<a href="#" class="h4 mg-r-5">닉네임</a>
					<a href="#" class="text-danger cursor-no-line" title="삭제">
						<i class="fas fa-times-circle"></i>																		
					</a>
				</div>
				안녕하세요.
			</li>
			<li class="list-group-item">
				<form action="" class="align-center">
					<div class="col-md-2 pd-0 j-center">
						<h4>닉네임</h4>
					</div>
					<div class="col-md-10 list">
						<textarea name="content" class="form-control mg-b-5" rows="3" cols="40"></textarea>
						<div class="align-center j-end">
							<div class="btn-group mg-r-5" data-toggle="buttons"> 
								<label id="secret" class="btn btn-default btn-sm">
									<span id="secretMsg">
										<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.																
									</span>
									<input type="checkbox" name="secret">
								</label>
							</div>
							<button type="submit" class="btn btn-primary btn-sm">쓰기</button>													
						</div>
					</div>
				</form>
			</li>
		</ul>
	</div>
</div>
<script type="text/javascript">
	document.querySelector('#secret').onclick = function() {
		var checked = document.querySelector('input[name="secret"]').checked,
		msg = document.querySelector('#secretMsg');
		
		if (!checked) {
			msg.innerHTML = '<i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.';
		} else {
			msg.innerHTML = '<i class="fas fa-lock-open mg-r-5"></i>공개 댓글입니다.';
		}
	};		
</script>