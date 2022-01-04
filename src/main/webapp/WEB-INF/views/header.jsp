<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initialscale=1">

<c:url value="/resources/bootstrap"				var="bootstrap" />
<c:url value="/resources/images"				var="images" />
<c:url value="/resources/images/community.jpg" 	var="community" />
<c:url value="/resources/images/logo.jpg" 		var="logo" />

<c:url value="/resources/script/script.js" 	var="script" />

<c:url value="/board" 				var="_board" />

<c:set var="_" value="<%= pageContext.getServletContext().getContextPath() %>" />

<link rel="stylesheet" type="text/css" href="${bootstrap}/css/reset.css">
<link rel="stylesheet" type="text/css" href="${bootstrap}/css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${bootstrap}/css/common.css">

<!-- font awsome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />

<script type="text/javascript" src="${bootstrap}/js/jquery.js"></script>
<script type="text/javascript" src="${bootstrap}/js/bootstrap.min.js"></script>


<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@api['map.api']" />&libraries=services"></script>


