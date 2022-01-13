<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/url.jsp" %>
<div class="align-end head">
	<div class="col-md-7">
		<img id="logo" alt="" src="${logo}" height="100">
	</div>

	<div class="j-end align-end f-1" style="margin-bottom: 15px;">
		<div class="align-center pd-3">
			<a href="${_}/loginForm.do" class="btn btn-link"style="margin-right: 15px;"><b>공지사항</b></a>				
			<a href="${_}/loginForm.do" class="cursor-no-line" style="position: relative; color: #000; margin-right: 25px;">
				<i class="fas fa-bell fa-3x"></i>
				<span class="label label-danger" style="position: absolute; right: -10%; top: 60%;">4</span>
			</a>				
			<a href="${_member}/joinForm.do" class="text-muted">
				<i class="fas fa-user-circle fa-3x"></i>
			</a>
		</div>
	</div>
</div>