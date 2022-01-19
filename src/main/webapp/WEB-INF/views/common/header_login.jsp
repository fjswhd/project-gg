<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="align-end head" style="position: fixed; width: 86%;">
	<div class="col-md-9">
		<img id="logo" alt="" src="${logo}" height="100">
	</div>
	<div class="align-center" style="margin-bottom: 15px;">
		<span style="color: gray;"> 이미 가입하셨나요? </span>			
		<a href="${_member}/loginForm.do" class="btn btn-lg btn-link">로그인하기</a>
	</div>
</div>