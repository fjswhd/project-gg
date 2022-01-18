<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<%@ include file="replyInsertForm.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	/* 답글 */
	function rereInsert(re_no){
		var html ="";
/* 		html+= "<input type='hidden' name='b_no' value='1'>"; 
		html+= "<input type='hidden' name='m_id' value='b'>";
 */		html+= "<textarea rows=rows='3'cols='40' id='rere_"+re_no+"'> </textarea>" ;
		html+= "<div> <div class='btn-group mg-r-5' data-toggle='buttons'>";
		html+= "<label id='secret1' class='btn btn-default btn-sm'> ";
		html+= "<span id='secretMsg1'> <i class='fas fa-lock-open mg-r-5'></i>";
		html+= "공개 답글입니다.</span> <input type='checkbox' name='secret1'></label>";
		html+= "<input type='button' onclick='reup("+re_no+")'class='btn btn-sm btn-info' value='쓰기'></div>";
		html+= "<script type=\"text/javascript\">";
		html+= "document.querySelector('#secret1').onclick = function() {";
		html+= "var checked = document.querySelector('input[name=\"secret1\"]').checked,";
		html+= "msg = document.querySelector('#secretMsg1');";
		html+= "if (!checked) {";	
		html+= "msg.innerHTML = '<i class=\"fas fa-lock mg-r-5\"></i>비밀 댓글입니다.';";	
		html+= "} else { msg.innerHTML = '<i class=\"fas fa-lock-open mg-r-5\"></i>공개 댓글입니다.';";
		html+= "} } <\/script>";
		
		$("#btn_"+re_no).html(html);
		
	}
	function reup(re_no){
		$.post('rereInsert.do',
				{ content : $('#rere_'+re_no).val(), re_no : re_no, secret : $('input[name="secret1"]').val()},
				function(data){
					$('#replyList').html(data);		
				});
	}
	secret : $('#secret').val()
	
	/* 삭제 */
	function reDelete(re_no){
		$.post('replyDelete.do',
			{re_no : re_no},
			function(data){
				$('#replyList').html(data);
			});
	}
	/* 수정 */
	function reUpdate(re_no){
		var txt = $('#ct_'+re_no).text();
		$('#ct_'+re_no).html("<textarea rows=rows='3'cols='40' id='ru_"+re_no+"'>"+txt+"</textarea>");
		$('#btn_'+re_no).html("<input type='button' onclick='up("+re_no+")'"+
				"class='btn btn-warning' value='확인'>");
	}
	function up(re_no){
		$.post('replyUpdate.do',
				{content: $('#ru_'+re_no).val(), re_no : re_no},
				function(data){
				$('#replyList').html(data);
		});
	}


</script>
</head>
<body>
	<div>
		<div>댓글</div>
		<div id = "replyList">
			<c:if test="${empty rpList }">
				<div>댓글이 없습니다.</div>
			</c:if>
			<c:if test="${not empty rpList }">
				<c:forEach var="reply" items="${rpList}">
					<c:if test="${reply.secret == 'y' && reply.m_id !='b'}"> 
					<div id="btn_${reply.re_no }">
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
					</div>
					</c:if>
					<c:if test="${reply.secret == 'y' && reply.m_id == 'b'}"> <%--조건 추가 && 세션아이디 ==reply.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div id="ct_${reply.re_no }">${reply.content }</div>
						<div>${reply.reg_date }</div>
						<div id="btn_${reply.re_no }">
							<input type="button" class="btn btn-warning" value="수정" onclick="reUpdate(${reply.re_no})">
							<input type="button" class="btn btn-danger" value="삭제" onclick="reDelete(${reply.re_no})">
							<input type="button" class="btn btn-info" value="답글" onclick="rereInsert(${reply.re_no})">
						</div>
					</c:if>
					<c:if test="${reply.secret == 'y' && 'b'=='a'}"> <%--조건 추가 && 세션아이디 == board.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
					<div id="btn_${reply.re_no }">
						<input type="button" class="btn btn-info" value="답글" onclick="rereInsert(${reply.re_no})">
					</div>
					</c:if>
					<c:if test="${reply.secret == 'n' && reply.m_id !='b'}"> 
					<div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
					</div>
					<div id="btn_${reply.re_no }">
						<input type="button" class="btn btn-info" value="답글" onclick="rereInsert(${reply.re_no})">
					</div>
					</c:if>
					<c:if test="${reply.secret == 'n' && reply.m_id == 'b'}"> <%--조건 추가  || 세션아이디 ==reply.m_id  --%>
					<div>
						<div>${reply.nickname }</div>
						<div id="ct_${reply.re_no }">${reply.content }</div>
						<div>${reply.reg_date }</div>
					<div id="btn_${reply.re_no }">
						<input type="button" class="btn btn-warning" value="수정" onclick="reUpdate(${reply.re_no})">
						<input type="button" class="btn btn-danger" value="삭제" onclick="reDelete(${reply.re_no})">
						<input type="button" class="btn btn-info" value="답글" onclick="rereInsert(${reply.re_no})">
					</div>
					</div>
					<div id="replyForm"></div>
					</c:if>
					
				</c:forEach>
			</c:if>
		</div>
	</div>
		
	
<!-- 페이징 -->
	<div align="center">
	<ul class="pagination ">
	<!-- 시작 페이지가 pagePerBlock보다 크면 앞에 보여줄 것이 있다 -->
		<c:if test="${pb.startPage > pb.pagePerBlock }">
		<!-- b_no은 board.b_no, m_id는  -->
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=1">
				<span class="glyphicon glyphicon-step-backward"></span></a></li>
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.startPage-1}" aria-label="Previous">
				<span class="glyphicon glyphicon-triangle-left"></span></a></li>
		</c:if>
		
		<c:forEach var="i" begin="${pb.startPage }" end="${pb.endPage }">
			<c:if test="${pb.currentPage==i }">
				<li class="active"><a href="replyList.do?b_no=1&m_id=b&pageNum=${i}">${i}</a></li>
			</c:if>
			<c:if test="${pb.currentPage!=i }">
				<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${i}">${i}</a></li>
			</c:if>
		</c:forEach>
		
		<!-- 보여줄 것이 남아있는 경우에는 endPage보다 totalPage가 큰경우 -->
		<c:if test="${pb.endPage < pb.totalPage }">
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.endPage+1}">
				<span class="glyphicon glyphicon-triangle-right"></span></a></li>
			<li><a href="replyList.do?b_no=1&m_id=b&pageNum=${pb.totalPage}">
				<span class="glyphicon glyphicon-step-forward"></span></a></li>
		</c:if>
	</ul>
</div>


</body>
</html>