<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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