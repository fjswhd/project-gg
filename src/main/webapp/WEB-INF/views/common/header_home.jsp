<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="align-end head" style="position: fixed; width: 86%;">
	<div class="col-md-7">
		<img id="logo" alt="" src="${logo}" height="100">
	</div>

	<div class="j-end align-end f-1" style="margin-bottom: 15px;">
		<div class="align-end pd-3">
			<a href="${_notice}/list.do" class="btn btn-link mg-r-5"><b>공지사항</b></a>				
			<a href="${_member}/loginForm.do" class="btn btn-primary mg-r-5">로그인</a>				
			<a href="${_member}/joinForm.do" class="btn btn-default">회원가입</a>
		</div>
	</div>
</div>