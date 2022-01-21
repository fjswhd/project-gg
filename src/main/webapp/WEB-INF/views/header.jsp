<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1">

<c:url value="/resources/bootstrap"					var="bootstrap" />
<c:url value="/resources/images"					var="images" />
<c:url value="/resources/images/logo.jpg" 			var="logo" />
<c:url value="/resources/images/community.jpg" 		var="community" />
<c:url value="/resources/profile"					var="_profile" />

<c:url value="/resources/script" 			var="_script"/>
<c:url value="/resources/script/script.js" 	var="script" />

<c:url value="/board" 				var="_board" />
<c:url value="/member" 				var="_member" />
<c:url value="/myPage" 				var="_myPage" />
<c:url value="/notice" 				var="_notice" />
<c:url value="/parti" 				var="_parti" />
<c:url value="/reply" 				var="_reply" />
<c:url value="/request" 			var="_request" />

<c:set var="_" value="<%= pageContext.getServletContext().getContextPath() %>" />

<link rel="stylesheet" type="text/css" href="${bootstrap}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${bootstrap}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${bootstrap}/css/common.css">
<script type="text/javascript" src="${bootstrap}/js/jquery.js"></script>
<script type="text/javascript" src="${bootstrap}/js/bootstrap.min.js"></script>

<!-- font awsome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<!-- google icon -->
<link href="https://fonts.googleapis.com/icon?family=Material+Icons|Material+Icons+Sharp|Material+Icons+Two+Tone|Material+Icons+Outlined|Material+Icons+Round" rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR&display=swap" rel="stylesheet">