<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<c:set var="path" value="${pageContext.request.contextPath }"></c:set>
<link rel="stylesheet" type="text/css" href="/tiger/resources/bootstrap/css/profileView.css">
</head>
<body>
<!-- 탈퇴한 회원 프로필 창닫기 -->
<c:if test="${result == 0 }">
	<script type="text/javascript">
	alert("탈퇴한 회원입니다.")
	self.close();
</script>
</c:if>

<c:if test="${result == 1 }">
	<div align="center">
		<div id="img_box">
			<!-- 프로필 이미지 -->
			<img alt="" src="${path }/resources/memberImg/${member.picture }" class="profileImg">
		</div>
		<div id="inform_box">
			<table class="table member_table">
			<caption>회원정보</caption>
				<tr>
					<td class="col-sm-2 col-xs-3 text-left">이메일</td>
					<td class="col-sm-10 col-sx-9">${member.MB_id }&nbsp;</td>
				</tr>
			<c:if test="${member.MB_gender == '1' || member.MB_gender == '3'}">
				<tr>
					<td class="col-sm-2 col-xs-3 text-left">성별</td>
					<td class="col-sm-10 col-xs-9">남자</td>
				</tr>
			</c:if>
			<c:if test="${member.MB_gender == '2' || member.MB_gender == '4'}">
				<tr>
					<td class="col-sm-2 col-xs-3 text-left">성별</td>
					<td class="col-sm-10 col-xs-9">여자</td>
				</tr>
			</c:if>
				<tr>
					<td class="col-sm-2 col-xs-3 text-left">가입일</td>
					<td class="col-sm-10 col-xs-9">${member.MB_regDate }</td>
				</tr>
			</table>
		</div>
				
		<div class="reviewDiv">
			<c:if test="${result2 == -1 }">
				<img alt="" src="${path }/resources/starImg/star.png" width="90px" height="18px">&nbsp;
				<h4>0.0</h4>
			</c:if>
			<c:if test="${result2 != -1 }">
				<h4>
					<img alt="" src="${path }/resources/starImg/star.png" width="90px" height="18px">&nbsp;
					${reviewAvg }
				</h4>
			</c:if>
			<table class="table review_table">
			<caption>리뷰</caption>
					<tr>
						<td colspan="2" class="text-center">최근 5개의 리뷰만 표시됩니다.</td>
					</tr>
					<c:if test="${empty rvList }">
						<tr>
							<th colspan="2" class="text-center">등록된 리뷰가 없습니다.</th>
						</tr>
					</c:if>
					<c:if test="${not empty rvList }">
						<c:forEach var="review" items="${rvList }">
							<tr>
								<td class="col-xs-3 text-left">${review.MB_nickName }</td>
								<c:if test="${review.RV_star == 5 }">
									<td class="col-sm-9 text-left">★★★★★</td>
								</c:if>
								<c:if test="${review.RV_star == 4 }">
									<td class="col-sm-9 text-left">★★★★☆</td>
								</c:if>
								<c:if test="${review.RV_star == 3 }">
									<td class="col-sm-9 text-left">★★★☆☆</td>
								</c:if>
								<c:if test="${review.RV_star == 2 }">
									<td class="col-sm-9 text-left">★★☆☆☆</td>
								</c:if>
								<c:if test="${review.RV_star == 1 }">
									<td class="col-sm-9 text-left">★☆☆☆☆</td>
								</c:if>
								<c:if test="${review.RV_star == 0 }">
									<td class="col-sm-9 text-left">☆☆☆☆☆</td>
								</c:if>																																										
							</tr>
							<tr>
								<td colspan="2">
									<pre style="border: none">${review.RV_content }</pre>
								</td>
							</tr>
							<br>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
	</c:if>
</body>
</html>