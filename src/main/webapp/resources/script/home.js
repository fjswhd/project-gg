//아래 화살표 누르면 아래 창을 위로 올리고 fadeIn 함수 실행
function scrollDown() {
	$('#body').animate({top: '-60%'}, 800, fadeIn);
}

//아래창 위로 올라오면 form-group
function fadeIn() {
	$('.form-group').each(function(index) {
		var item = $(this);		
		setTimeout(function() {
			item.animate({paddingTop: '0',opacity: '1'}, 800);
		}, index*400)
	});
}