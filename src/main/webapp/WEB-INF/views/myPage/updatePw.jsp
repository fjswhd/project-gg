<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<style type="text/css">
	td, th {
    	padding: 14px 0px;	
    }
		
	#keyShow {
	  position: absolute;
	  display: none;
	  margin-right: 10px;
	  margin-top: 4px;
	  font-size: 15px;
	  cursor: pointer;
	  color: grey;
	}
	
	#idBtn {
		margin-top: 30px;
	}
</style>	
<script type="text/javascript">

// 현재 비밀번호가 맞는지  확인하는 ajax
	$(function() {
		$("#correct").hide();
		$("#fail").hide();
		$("#now_pw").keyup(function() {
			var MB_pw_db = "${member.MB_pw}";
			var MB_pw_now = $("#now_pw").val();
			if (MB_pw_now != "") {
				if (MB_pw_db == MB_pw_now) {
					$("#correct").show();
					$("#fail").hide();
					/* $("#submit").attr('disabled', false) */
				} else {
					$("#correct").hide();
					$("#fail").show();
					/* $("#submit").attr('disabled', true) */
				}
			}
		});
	});

// 비밀번호 유효성 검사
 	$(function () {
	// 1. 비밀번호와 비밀번호  일치 확인 ajax
		$("#alert-success").hide();
		$("#alert-danger").hide();
		$("#pw_confirm").keyup(function() {
			var MB_pw = $("#pw").val();
			var MB_pw_confirm = $("#pw_confirm").val();
			if (MB_pw != "" || MB_pw_confirm != "") {
				if (MB_pw == MB_pw_confirm) {
					$("#alert-success").show();
					$("#alert-danger").hide();
					$("#submit").attr('disabled', false);
				} else {
					$("#alert-success").hide();
					$("#alert-danger").show();
					/* $("#submit").attr('disabled', true); */
				}
		    }
       });
	
 //2. 비밀번호 형태 유효성 검사
		    $("#alert1").hide();  
			$("#alert2").hide();
			$("#alert3").hide();
			$("#alert4").hide();

		$("#pw").keyup(function() {  
		 	var pw = $("#pw").val(); 
	     	var num = pw.search(/[0-9]/g);      //숫자 기입
		 	var eng = pw.search(/[a-zA-Z]/ig);  //영문자 기입
		 	var tab = pw.search(/[/\s/]/ig);    //공백
	
		 	if (tab != -1) {
		    	 $("#alert1").hide();
				 $("#alert2").toggle();
				 $("#alert3").hide();
				 $("#alert4").hide();
				/*  $("#submit").attr('disabled', true); */
			 } else {
			 	 if (pw.length < 4 ) {  
					$("#alert1").toggle();
					$("#alert2").hide();
					$("#alert3").hide();
				    $("#alert4").hide();
				    /* $("#submit").attr('disabled', true); */
	   			 } else if (num >= 0 && eng >= 0){
	    			$(".alert").hide(); 
	    			/* $("#submit").attr('disabled', false); */
	 	  		 } else if (num < 0 && eng >= 0   ) {
				    $("#alert1").hide();
			        $("#alert2").hide();
			  	    $("#alert3").toggle();    
			   	    $("#alert4").hide();
			   	    /* $("#submit").attr('disabled', true); */
		   		 } else if ( num >= 0 && eng < 0  ){  
				    $("#alert1").hide();
					$("#alert2").hide();
					$("#alert3").hide();
					$("#alert4").toggle();
					/* $("#submit").attr('disabled', true); */
			 	 }	
	        } 
		  });	
	
// 비밀번호 보이거나 감추는 선택 기능
	
			$("#pw").on("keyup", function(event) {
				if (event.keyCode === 13) {
				    event.preventDefault();
				    $("#submit").triggerHandler("click");
				} else {
					if (this.value) {
						$("#keyShow").css("display", "inline-block");
					} else {
						$("#keyShow").hide();
				}
			  }
		    }).focus();
	 	
		    $("#keyShow").on("click", function() {
		  		if ($("#pw").attr("type") == "password") {
					$("#pw").attr("type", "text");
					$($(this)).text("HIDE");
				} else {
					$("#pw").attr("type", "password");
					$($(this)).text("SHOW");
				}
		 	});	
	});	
</script>

</head>
<body>
<div class=" narrowWidth1"  align="center">
	<h2 class="title">비밀번호 변경</h2>
	<form action="updatePwResult.do"  method="post" name="frm" onsubmit="return chk()">
	<input type="hidden" name="MB_id" value="${member.MB_id }">
	<table>  
			<tr>
				<td class="inputUnderLine">
					<input type="password" name="MB_now_pw" id="now_pw" required="required" 
							placeholder="현재 비밀번호" class="inputLine">
					<br>
					<div class="alert alert-success" id="correct">현재 비밀번호와 일치합니다.</div>
					<div class="alert alert-danger" id="fail">현재 비밀번호와 일치하지 않습니다.</div>
				</td>
			</tr>
			<tr>
				<td class="inputUnderLine">
						<input type="password" name="MB_pw" id="pw" maxlength="12" autocomplete="false"
								class="inputLine"  placeholder="변경 비밀번호(영문자, 숫자, 4자 이상)" 
								required="required">
							<div id="keyShow">SHOW</div>
						<div class="alert alert-danger" id="alert1" >
						     "숫자와 영문자를 포함해서 4자리 이상 "</div>
						<div class="alert alert-danger" id="alert2">"공백 없이 입력"</div>
						<div class="alert alert-danger" id="alert3">"숫자 필수 포함"</div>
						<div class="alert alert-danger" id="alert4">"영문자 필수 포함"</div>
				   </td> 
			</tr>  
			<tr>
				<td class="inputUnderLine">
					<input type="password" name="MB_pw_confirm" id="pw_confirm" 
							placeholder="변경 비밀번호 확인" required="required" class="inputLine">
					<br>
					<div class="alert alert-success" id="alert-success">변경 비밀번호가 일치합니다.</div>
					<div class="alert alert-danger" id="alert-danger">변경 비밀번호가 일치하지 않습니다.</div>
				</td>
			</tr>
			<tr>  
				<td class="text-center">
					<input type="submit"  value="비밀번호 변경"   
							class="btn_large" id="submit"  disabled="disabled">
				</td>
			</tr>    
	</table>
	</form>
</div>
</body>
</html>