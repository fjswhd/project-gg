<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@api['map.api']"/>&libraries=services,clusterer"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/smoothness/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>
	<div class="container flex-column" style="overflow: visible">
		<!-- header -->
		<c:if test="${empty sessionScope.member}">
			<jsp:include page="/WEB-INF/views/common/header_login.jsp" />		
		</c:if>
		<!-- header -->
		<c:if test="${not empty sessionScope.member}">
			<jsp:include page="/WEB-INF/views/common/header_loggedIn.jsp" />		
		</c:if>
		
		<!-- body -->
		<div class="col-md-12 mg-auto box flex" style="height: 75%; top: 20%;">
			<div id="map" class="shadow" style="height: 100%; width: 50%; border-radius: 5px;"></div>
			<div class="flex-column f-g" style="position: relative; overflow: hidden; margin-left: 15px;">
				<!-- 검색 박스 -->
				<div id="searchBox" class="shadow-bottom">
					<form action="${_board}/searchList.do" name="frm">
						<input type="hidden" name="pageNum" value="1">
						<div class="form-group align-center" style="margin-bottom: 10px;">
							<label class="col-md-2">일자</label>
							<span class="col-md-5">
								<input type="date" name="s_date" class="form-control input-sm" min="${today}" max="${lastday}" value="${param.s_date}">
							</span>
							~
							<span class="col-md-5">
								<input type="date" name="e_date" class="form-control input-sm"  min="${today}" max="${lastday}" value="${param.e_date}">
							</span>
						</div>
						<div class="align-center j-end" style="height: 14px; margin-bottom: 10px;">
							<span class="col-md-10">
								<input type="checkbox" id="accute"><label for="accute" class="mg-l-5">정확한 일자로 검색</label>
							</span>
						</div>
						<div class="form-group align-center">
							<label class="col-md-2">지역</label>
							<span class="col-md-10">
								<input type="text" name="address" class="form-control input-sm" placeholder="장소를 검색해주세요." value="${param.address}">	
							</span>
						</div>
						<div class="form-group align-center">
							<label class="col-md-2">카테고리</label>
							<span class="col-md-3">
								<select name="c_no" class="form-control input-sm" required="required">
									<option value="">카테고리</option>
									<c:forEach var="category" items="${categoryList}">
										<c:if test="${param.c_no == category.c_no}">
											<option value="${category.c_no}" selected="selected">${category.c_name}</option>
										</c:if>
										<c:if test="${param.c_no != category.c_no}">
											<option value="${category.c_no}">${category.c_name}</option>
										</c:if>
									</c:forEach>
								</select>				
							</span>
							<span class="col-md-7">
								<span class="input-group input-group-sm">
									<input type="text" name="keyword" class="form-control" value="${param.keyword}">
									<span class="input-group-btn">
										<button class="btn btn-primary"><i class="fas fa-search"></i></button>								
									</span>
								</span>
							</span>					
						</div>
					</form>
				</div>
				
				<!-- 검색 결과 -->
				<div id="searchList" class="scroll" style="position: absolute; overflow: auto; top: 30%; width: 100%; height: 70%;">
					<ul class="list-group mg-b-5 mg-r-5 mg-l-5"></ul>
					<div class="j-center">
						<ul class="pagination mg-t-5 mg-b-5"></ul>
					</div>
				</div>
			</div>
		</div>
		
	</div>
	
	<div id="background"></div>
	<script type="text/javascript" src="${script}"></script>
	<script type="text/javascript" src="${_script}/list.js"></script>
	<script type="text/javascript">
		//엔터키 submit막기
		frm.addEventListener('keydown', function(e) {
			if((e.keyCode || e.which) === 13) {
				e.preventDefault();
			}
		})
		//블러되면 값을 초기화?
		frm.address.onblur = function() {
			frm.address.value = '';
		}
		
		frm.address.addEventListener('keyup', function() {
			$('[name="address"]').autocomplete({  //오토 컴플릿트 시작
	            source : //list
	            function(request, response) {
	                var results = $.ui.autocomplete.filter(list, request.term);
	                response(results.slice(0, 30));
	            },    // source 는 자동 완성 대상
	            select : function(event, ui) {    //아이템 선택시
					frm.address.blur();
	           		frm.address.value = ui.item.value;
	            },
	            open : function(event, ui) {
	            	$(this).autocomplete('widget')
	            		.css('box-shadow', '0 0 4px #808080')
	            		.css('border-radius', '5px')
	            },
	            focus : function(event, ui) {    //포커스 가면
	            	return false;
	            },
	            classes : {
	            	"ui-autocomplete": "scroll"
	            },
	            minLength: 1,// 최소 글자수
	            autoFocus: false, //첫번째 항목 자동 포커스 기본값 false
	            delay: 500,    //검색창에 글자 써지고 나서 autocomplete 창 뜰 때 까지 딜레이 시간(ms)
	            position: { my : "right top", at: "right bottom" }    
	        });
		})
	</script>
	<script type="text/javascript">
		//주소를 맵 좌표로 바꿔줄 geocoder
		var geocoder = new kakao.maps.services.Geocoder();
		
		//마커를 담을 배열
		var markers = [];
		
		//지도
		var map = new kakao.maps.Map(document.querySelector('#map'), {
		    level: 5,
		    center: new kakao.maps.LatLng(37.5, 127),
		});
		
		//마커 관리할 클러스터
		var clusterer = new kakao.maps.MarkerClusterer({
	        map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	        averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	        gridSize: 30,
	        disableClickZoom: true,
	        minLevel: 1 // 클러스터 할 최소 지도 레벨 
	    });
		
		//마커 정보 보여줄 오버레이
		var overlay = new kakao.maps.CustomOverlay({
			clickable: true,
			map: map
		});
		
		//맵을 움직이거나 클릭하면 오버레이 닫히게
		kakao.maps.event.addListener(map, 'center_changed', function() {
			overlay.setMap(null);
		})
		kakao.maps.event.addListener(map, 'click', function() {
			overlay.setMap(null);
		})
		
		geocoder.addressSearch('서울 마포구 신촌로 176', function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
		        var currCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
		        map.setCenter(currCenter);
			}
		})
		
		const query = '${json}';
		const param = JSON.parse(query);
		console.dir(query);
		//검색하기
		search(query, displaySearchResult);
		
		//클러스터 누르면 그 안의 마커들 정보 표출
		kakao.maps.event.addListener(clusterer, 'clusterclick', function(cluster) {
			overlay.setMap(null);
			
			var cMarkers = cluster.getMarkers(),
				div = document.createElement('div');
			
			div.classList.add('wrap');
			div.addEventListener('mouseover', preventZoom);
			div.addEventListener('mouseout', zoomable);
			
			var content = '<ul class="list-group" style="margin: 0;">';
			
			cMarkers.map(function(marker, index) {
				var board = JSON.parse(marker.getTitle());
				
				content += 
				'<li class="list-group-item ellipsis" style="padding: 3px;">'+
				'	<a href="${_board}/detail.do?b_no='+board.b_no+'" class="cursor" style="color: #000;">['+board.category.c_name+'] '+board.subject+'</a>'+
				'</li>';
			})
			
			content += '</ul>';
			
			div.innerHTML = content;
				
			overlay.setPosition(cluster.getCenter());
			overlay.setContent(div);
			overlay.setMap(map);
	    });
		
		//page 버튼을 눌렀을 때 다른 페이지를 로드		
		function loadPage(event) {
			overlay.setMap(null);
			
			event.preventDefault();
			
			if (event.target.innerHTML == '«') {
				param.pageNum = parseInt(param.pageNum) - 5;
			} else if (event.target.innerHTML == '»') {
				param.pageNum = parseInt(param.pageNum) + 5;
			} else {
				param.pageNum = parseInt(event.target.innerHTML);
			}
			param.pageNum = String(parseInt(param.pageNum));
			
			search(JSON.stringify(param), displaySearchResult);
			
		}
		
		//페이지 버튼 만들기
		function displayPageButton(pageNum, firstPage, lastPage) {
			var ul = document.querySelector('ul.pagination'), li, a;
			
			//기존의 ul밑의 요소들 제거
			removeAllChild(ul);
			
			//li요소 만들어서 append
			for(var i = parseInt(firstPage) - 1; i <= parseInt(lastPage) + 1; i++) {
				li = document.createElement('li');
				a = document.createElement('a');
				
				if( i == pageNum ){
					li.classList.add('active');
				} 
			
				if( i < parseInt(firstPage)) {
					a.innerHTML = '&laquo;';					
				} else if (i > parseInt(lastPage)) {
					a.innerHTML = '&raquo;';
				} else {
					a.textContent = i;					
				}
				
				a.setAttribute('href', '#');
				a.addEventListener('click', loadPage);
				
				li.appendChild(a);
				ul.appendChild(li);
			}
			
		}
		
		//마커 만들고 클러스터러에 넣기
		function displayMarkers(itemList) {
			bounds = new kakao.maps.LatLngBounds();
			
			//markers에 있는 마커 지우기	
			removeMarker()
			
			clusterer.clear();
			
			if (itemList.length == 0) {
				return;
			}
			
			itemList.map(function(item, index) {
				var address = item.address;
				address = address.substring(address.lastIndexOf('(') + 1, address.lastIndexOf(')'));
				
				var title = JSON.stringify(item);
				
				geocoder.addressSearch(address, function(result, status) {
				    if (status === kakao.maps.services.Status.OK) {
				        var placePosition = new kakao.maps.LatLng(result[0].y, result[0].x),
					   		marker = makeMarker(title, placePosition);
				        
				        bounds.extend(placePosition);					        	
				        map.setBounds(bounds);
				        
				        clusterer.addMarker(marker);
				        markers.push(marker);
				    }
				});
			})
		}
		
		//검색 결과를 보여줌
		function displaySearchResult(itemList) {
			var target = document.querySelector('ul.list-group'),
				container = document.querySelector('div#searchList');
			
			container.scrollTo(0, 0);
				
			//target에 남아있는 li지우기
			removeAllChild(target);
			
			if (itemList.length == 0) {
				li = document.createElement('li');
				li.classList.add('list-group-item');
				li.innerHTML = '<i class="fas fa-times-circle mg-r-5"></i>검색 결과가 존재하지 않습니다.';
				target.appendChild(li);
				return;
			} 
				
			for(var i = 0; i < itemList.length; i++) {
				var board = itemList[i];
				li = document.createElement('li'),
				a = document.createElement('a');
				
				li.classList.add('list-group-item')
				
				a.setAttribute('href', '${_board}/detail.do?b_no='+board.b_no);
				a.classList.add('cursor');
				a.style.color = '#000';
				a.textContent = '['+board.category.c_name+'] '+ board.subject
				
				li.appendChild(a);
				
				target.appendChild(li);
			}
		}
		
		
		function search(sendData, displaySearchResult) {
			
			fetch('${_board}/search.do', {
				method: 'POST',
				body: sendData,
				headers: {
					'Content-Type': 'application/json;charset=utf-8'
				}
			}).then(function(response) {
				return response.json();
			}).then(function(resultMap) {
				var itemList = resultMap.itemList,
					pageNum = resultMap.pageNum,
					firstPage = resultMap.firstPage,
					lastPage = resultMap.lastPage;
				
				//이 url에서 pageNum이 대책없이 변하지 않게 넘겨준 데이터로 페이지번호 설정
				param.pageNum = pageNum;
				
				//검색 결과 보여줌
				displaySearchResult(itemList);
				
				//맵에 마커 뿌려줌
				displayMarkers(itemList);
				
				//페이지 버튼 보여줌
				displayPageButton(pageNum, firstPage, lastPage);
				
			})
		}
		
		//element 밑의 요소들 제거
		function removeAllChild(element) {
			while( element.hasChildNodes() ) {
				element.removeChild(element.lastChild);
			} 
		}
		
		//
		var markerTitle = '';
		
		//마커 만들기
		function makeMarker(title, position) {
			var marker = new kakao.maps.Marker({
		        map: map,
		        title: title,
		    	position: position
		    });
			
			//마커 누르면 정보 노출 이벤트 리스너 달아주기
	        kakao.maps.event.addListener(marker, 'click', function() {
	        	overlay.setMap(null);
	        	
	        	var	div = document.createElement('div'),
	        		board = JSON.parse(title);
			
				div.classList.add('wrap');
	        	
				var content = 
					'<ul class="list-group" style="margin: 0;">'+
					'	<li class="list-group-item" style="padding: 3px; overflow:hidden; text-overflow:ellipsis; white-space:nowrap;">'+
					'		<a href="${_board}/detail.do?b_no='+board.b_no+'" class="cursor" style="color: #000;">['+board.category.c_name+'] '+board.subject+'</a>'+
					'	</li>'+
					'</ul>';
				
				div.innerHTML = content;
				
				overlay.setPosition(marker.getPosition());
				overlay.setContent(div);
				overlay.setMap(map);
			});
			
	        kakao.maps.event.addListener(marker, 'mouseover', function(event) {
	        	markerTitle = marker.getTitle();
	        	marker.setTitle('');
			});
	        kakao.maps.event.addListener(marker, 'mouseout', function(event) {
	        	marker.setTitle(markerTitle);
	        	markerTitle = '';
			});
			
			return marker;
		}
		
		//지도 위의 마커들 제거
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		// url query문을 json객체로 만들어줌
		function queryToJson(query) {
			var pairs = query.replace('?', '').split('&'),
				result = {};
			
			pairs.forEach(function(pair) {
				var key = pair.split('=')[0],
				value = pair.split('=')[1];
				
				result[key] = decodeURI(value);
			})
			
			return result;
		}
		
		function preventZoom() {
			map.setZoomable(false);
		}
		
		function zoomable() {
			map.setZoomable(true);
		}
	</script>
</body>
</html>