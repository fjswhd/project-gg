<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div>
	<c:if test="${empty partiList}">
		<li class="list-group-item align-center"><i
			class="fas fa-times-circle mg-r-5"></i>참여자가 없습니다.</li>
	</c:if>
	<c:if test="${not empty partiList}">
		<c:forEach var="parti" items="${partiList}">
			<form>
				<input type="hidden" name="m_id" value="${parti.m_id}"> <input
					type="hidden" name="b_no" value="${parti.b_no}"> <span>
					${parti.nickname} </span> <span class="range-slider"> <input
					class="range-slider__range" type="range" name="r_score" value="5"
					min="0" max="5" step="1"> <span class="range-slider__value">0</span>
				</span>

			</form>
		</c:forEach>
		<div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
			<button type="button" class="btn btn-primary" onclick="saveRscore()" data-dismiss="modal">완료</button>
		</div>
	</c:if>
</div>

<script type="text/javascript">
	var rangeSlider = function() {
		var slider = $('.range-slider'), range = $('.range-slider__range'), value = $('.range-slider__value');

		slider.each(function() {

			value.each(function() {
				var value = $(this).prev().attr('value');
				$(this).html(value);
			});

			range.on('input', function() {
				$(this).next(value).html(this.value);
			});
		});
	};
	rangeSlider();

	function saveRscore() {
		var forms = document.forms;
		var partiList = [];
		var data = {};
		
		for (var i = 0; i < forms.length; i++) {
			data['b_no'] = forms[i].b_no.value;
			data['m_id'] = forms[i].m_id.value;
			data['r_score'] = forms[i].r_score.value;
			partiList.push(data);
			data = {};
		}
		fetch('/project/myPage/insertRscore.do', {
			method: 'POST',
			body: JSON.stringify(partiList),
			headers: {
				'Content-Type':'application/json;charset=utf-8'
			}
		}).then(function(response) {
			return response.text();
			
		}).then(function(data) {
			if(data == forms.length){
				alert("성공");
			}
		});
	}
</script>