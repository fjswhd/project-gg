	

	//버튼위에 마우스 올리면 돌아감
	searchAgain.addEventListener('mouseover', function(event) {
		document.querySelector('.fa-redo').classList.add('fa-spin');
	})
	searchAgain.addEventListener('mouseout', function(event) {
		document.querySelector('.fa-redo').classList.remove('fa-spin');
	})