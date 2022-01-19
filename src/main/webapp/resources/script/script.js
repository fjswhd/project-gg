var randNum = Math.floor(Math.random() * 60) + 20;
$('#background').css('background-position', randNum+'% bottom');

//로고 누르면 홈 화면으로
document.querySelector('#logo').onclick = function() {
	location.href = '/project/home.do';
}
