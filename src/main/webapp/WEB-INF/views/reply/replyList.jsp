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
	function reDelete(re_no){
		$.post('replyDelete.do',
			{re_no : re_no},
			function(data){
				$('#replyList').html(data);
			});
	};
	function reUpdate(re_no){
		var txt = $('#ct_'+re_no).text();
		$('#ct_'+re_no).html("<textarea rows=rows='3'cols='40' id='ru_"+re_no+"'>"+txt+"</textarea>");
		$('#btn_'+re_no).html("<input type='button' onclick='up("+re_no+")'"+
				"class='btn btn-warning' value='수정'>"+
				"<input type='button' onclick='list()'"+
				"class='btn btn-danger' value='취소'>");
	}
	function list(){
		$('#replyList').history.back();
	}
	function up(re_no){
		var sendData = $('#ru_'+re_no).val();
		$.post('replyUpdate.do',
				{context: sendData, re_no : re_no},
				function(data){
				$('#replyList').html(data);
		});
	};


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
					<c:if test="${reply.secret == 'y' }"> 
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
					</c:if>
					<c:if test="${reply.secret == 'y' }"> <%--조건 추가 && 세션아이디 ==reply.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div id="ct_${reply.re_no }">${reply.content }</div>
						<div>${reply.reg_date }</div>
						<div id="btn_${reply.re_no }">
							<input type="button" class="btn btn-warning" value="수정" onclick="reUpdate(${reply.re_no})">
							<input type="button" class="btn btn-danger" value="삭제" onclick="reDelete(${reply.re_no})">
							<input type="button" class="btn btn-info" value="답글" onclick="reInsert(${reply.re_no})">
						</div>
					</c:if>
					<c:if test="${reply.secret == 'y' }"> <%--조건 추가 && 세션아이디 == board.m_id )--%>
						<div><i class="fas fa-lock mg-r-5"></i>비밀 댓글입니다.</div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<input type="button" class="btn btn-info" value="답글" onclick="reInsert(${reply.re_no})">
					</c:if>
					<c:if test="${reply.secret == 'n' }"> 
					<div>
						<div>${reply.nickname }</div>
						<div>${reply.content }</div>
						<div>${reply.reg_date }</div>
						<input type="button" class="btn btn-info" value="답글" onclick="reInsert(${reply.re_no})">
					</div>
					</c:if>
					<c:if test="${reply.secret == 'n' }"> <%--조건 추가  || 세션아이디 ==reply.m_id  --%>
					<div>
						<div>${reply.nickname }</div>
						<div id="ct_${reply.re_no }">${reply.content }</div>
						<div>${reply.reg_date }</div>
						<div id="btn_${reply.re_no }">
						<input type="button" class="btn btn-warning" value="수정" onclick="reUpdate(${reply.re_no})">
						<input type="button" class="btn btn-danger" value="삭제" onclick="reDelete(${reply.re_no})">
						<input type="button" class="btn btn-info" value="답글" onclick="reInsert(${reply.re_no})">
						</div>
					</div>
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