<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>같이 가치</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<spring:eval expression="@api['map.api']"/>&libraries=services"></script>
	<style type="text/css">
		#placesList .item {position:relative;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item .markerbg {float:left; position:absolute; width:36px; height:37px; background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
	</style>
</head>
<body>
	<div class="flex f-1" style="height: 100%;">
		<div id="map" style="width: 70%; position: relative;">
			<button id="searchAgain" class="btn btn-primary btn-lg collapse">
				<span class="align-center">
					<i class="fas fa-redo"></i>&nbsp;현 지도에서 재검색
				</span>
			</button>
		</div>
		<div style="width: 30%; overflow: visible; position: relative;">
			<!-- 검색창 -->
			<div class="mapSearch">
				<div class="input-group">
					<input type="text" id="keyword" name="keyword" class="form-control" placeholder="키워드로 장소검색" required="required">
					<span class="input-group-btn">
						<button id="searchBtn" class="btn btn-primary" style="height: 34px;">
							<i class="glyphicon glyphicon-search"></i>
						</button>
					</span>
				</div>
				
				<!-- 검색 결과 -->
				<div id="searchResult" class="flex-column f-g scroll" style="margin: 15px 0; height: 92%; overflow: auto;">
					<table id="placesList" class="table table-hover" style="width: 100%; table-layout: fixed;">
						<tbody></tbody>
					</table>
	        		<div id="pagination"></div>
				</div>
			
			</div>
		</div>
	</div>
	<script type="text/javascript" src="${_script}/search.js"></script>
	<script type="text/javascript">
		document.querySelector('input').addEventListener("keyup", function(event) {
		    if ((event.keyCode || event.which) === 13) {
		    	event.target.blur();
		    	document.querySelector('#searchBtn').click();
		    }
		})
		
		var map = new kakao.maps.Map(document.querySelector('#map'), {
		    level: 5,
		    center: new kakao.maps.LatLng(37.5, 127),
		});	
				
		navigator.geolocation.getCurrentPosition(function(pos) {
			var currCenter = new kakao.maps.LatLng(pos.coords.latitude, pos.coords.longitude);
			
		    map.setCenter(currCenter);
		    
		    var marker = new kakao.maps.Marker({
		        map: map,
		    	position: currCenter
		    });
		});
		
		//마커를 담을 array
		var markers = [];
		
		//검색 객체?
		var ps = new kakao.maps.services.Places();
		
		// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({zIndex:1});
		
		//검색버튼을 누르면 장소 검색
		document.querySelector('#searchBtn').addEventListener('click', searchPlaces);
		
		
		//keyword로 장소 검색
		function searchPlaces() {
		    var keyword = document.getElementById('keyword').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		    
			ps.keywordSearch(keyword, placesSearchCB); 

			// 현 지도에서 재검색 버튼 활성화
		    searchAgain.classList.remove('collapse');    
		}
		
		// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
		function placesSearchCB(data, status, pagination) {
		    if (status === kakao.maps.services.Status.OK) {
				
		    	if(event.target.responseURL.includes('rect')) {
		    		displayPlacesWithBounds(data, map.getBounds());
		    	}
		    	else {
			        // 정상적으로 검색이 완료됐으면
			        // 검색 목록과 마커를 표출합니다
			        displayPlaces(data);
		    	}
		        
		        // 페이지 번호를 표출합니다
		        displayPagination(pagination);

		    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
		        alert('검색 결과가 존재하지 않습니다.');
		        return;

		    } else if (status === kakao.maps.services.Status.ERROR) {
		        alert('검색 결과 중 오류가 발생했습니다.');
		        return;
		    }
		}

		function displayPlaces(places) {
		    var listEl = document.querySelector('#placesList > tbody'),
		    fragment = document.createDocumentFragment(),
		    bounds = new kakao.maps.LatLngBounds();
		    
		    infowindow.close();
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		    	
		    	// 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
		        
		            
		        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
		        // LatLngBounds 객체에 좌표를 추가합니다
		        bounds.extend(placePosition);

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });

		            itemEl.onclick =  function () {
		            	resetMarkerZIndex();
		            	marker.setZIndex(10);
		            	//map.setLevel(4);
		            	panToMarker(marker);
		                displayInfowindow(marker, title);
		            };

		            itemEl.onblur =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
				
		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		   listEl.appendChild(fragment);
		    
		    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		    map.setBounds(bounds);
		}
		
//==========현 지도에서 재검색=====================================================
		//현 지도에서 재검색 버튼
		var searchAgain = document.querySelector('#searchAgain');
		searchAgain.addEventListener('click', searchPlacesAgain);
		
		//버튼위에 마우스 올리면 돌아감
		searchAgain.addEventListener('mouseover', function(event) {
			document.querySelector('.fa-redo').classList.add('fa-spin');
		})
		searchAgain.addEventListener('mouseout', function(event) {
			document.querySelector('.fa-redo').classList.remove('fa-spin');
		})
		searchAgain.addEventListener('click', () => {
			searchAgain.blur();
		})
		
		//현재 지도의 bounds를 가지고 재검색		
		function searchPlacesAgain() {
			event.target.blur();
			var keyword = document.getElementById('keyword').value;

		    if (!keyword.replace(/^\s+|\s+$/g, '')) {
		        alert('키워드를 입력해주세요!');
		        return false;
		    }
		    
		    //현재 지도에서 검색할 영역의 좌표 boundary가져옴
		    var bounds = map.getBounds();
		    
		    //현재 지도의 영역에서 재검색
		    ps.keywordSearch(keyword, placesSearchCB, {
		    	bounds: bounds
		    }); 
		}
		
		function displayPlacesWithBounds(places, bounds) {
		    var listEl = document.querySelector('#placesList > tbody'),
		    fragment = document.createDocumentFragment();
		    
		    console.dir(places);
		    infowindow.close();
		    
		    // 검색 결과 목록에 추가된 항목들을 제거합니다
			removeAllChildNods(listEl);

		    // 지도에 표시되고 있는 마커를 제거합니다
		    removeMarker();
		    
		    for ( var i=0; i<places.length; i++ ) {
		    	
		    	// 마커를 생성하고 지도에 표시합니다
		        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
		            marker = addMarker(placePosition, i), 
		            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

		        // 마커와 검색결과 항목에 mouseover 했을때
		        // 해당 장소에 인포윈도우에 장소명을 표시합니다
		        // mouseout 했을 때는 인포윈도우를 닫습니다
		        (function(marker, title) {
		            kakao.maps.event.addListener(marker, 'mouseover', function() {
		                displayInfowindow(marker, title);
		            });

		            kakao.maps.event.addListener(marker, 'mouseout', function() {
		                infowindow.close();
		            });
					
		            itemEl.onclick =  function () {
		            	resetMarkerZIndex();
		            	marker.setZIndex(10);
		            	//map.setLevel(4);
		            	panToMarker(marker);
		                displayInfowindow(marker, title);
		            };

		            itemEl.onblur =  function () {
		                infowindow.close();
		            };
		        })(marker, places[i].place_name);
				
		        fragment.appendChild(itemEl);
		    }

		    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
		   listEl.appendChild(fragment);
		}
		
		// 검색결과 항목을 Element로 반환하는 함수입니다
		function getListItem(index, places) {
			var tr = document.createElement('tr'),
			title = places.place_name,
			address = places.address_name,
			category = places.category_name.substring(places.category_name.lastIndexOf('>') + 1),
			url = places.place_url,
		    itemStr = '<td>' +
						'<div class="info">' +
						'<span class="align-end">'+
						'	<span class="markerbg marker_' + (index+1) + ' mg-t-5"></span>'+
						'	<span id="title" class="h4 text-primary" style="margin-left: 36px; white-space:nowrap;  text-overflow:ellipsis; overflow:hidden;">' + title + '<small>'+category+'</small></span>'+
						'</span>';
		    if (places.road_address_name) {
		        itemStr += '<h5 id="address">'+address+' <br /><small>'+ places.road_address_name +'</small></h5>';
		    } else {
		        itemStr += '<h5>'+address+'</h5>'; 
		    }
		                 
			itemStr += '<span class="tel">'+ places.phone +'</span><br />'+
						'<a href="'+url+'" class="h6 text-muted" onclick="detail()"> 상세보기 </a> / '+
						'<span class="h6 text-muted cursor" onclick="goTo()"> 이 위치로 선택</span>'+
						'</div></td>';           

			tr.innerHTML = itemStr;
		    tr.className = 'item';

		    return tr;
		}
		
		function detail() {
			event.preventDefault();
			window.open(event.target.href, 'detail');
		}
		
		function goTo() {
			event.preventDefault();
			var parent = event.target.parentNode;
			
			var title = parent.childNodes[0].innerText;
			title = title.substring(0, title.lastIndexOf(' '));
			
			var address = parent.childNodes[1].innerText;
			if (address.lastIndexOf('\n') != -1) {
				address = address.substring(0, address.lastIndexOf('\n'));				
			}
			
			var data = title + '('+address+')';
			opener.document.querySelector('#searchResult').classList.add('mg-r-5');
			opener.document.querySelector('#searchResult').innerText = data;
			opener.frm.address.value = data;
			
			window.close();
			
		}
		
		// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
		function addMarker(position, idx, title) {
		    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
		        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
		        imgOptions =  {
		            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
		            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
		        },
		        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		            marker = new kakao.maps.Marker({
		            position: position, // 마커의 위치
		            image: markerImage 
		        });

		    marker.setMap(map); // 지도 위에 마커를 표출합니다
		    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

		    return marker;
		}
		
		//지도 중심을 마커 위치로 옮기는 함수
		function panToMarker(marker) {
			var moveLatLng = marker.getPosition();
			map.panTo(moveLatLng);
		}
		
		// 지도 위에 표시되고 있는 마커를 모두 제거합니다
		function removeMarker() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setMap(null);
		    }   
		    markers = [];
		}
		
		//마커 높이 초기화
		function resetMarkerZIndex() {
		    for ( var i = 0; i < markers.length; i++ ) {
		        markers[i].setZIndex(0);
		    }   
		}

		// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
		function displayPagination(pagination) {
		    var paginationEl = document.getElementById('pagination'),
		        fragment = document.createDocumentFragment(),
		        i; 

		    // 기존에 추가된 페이지번호를 삭제합니다
		    while (paginationEl.hasChildNodes()) {
		        paginationEl.removeChild (paginationEl.lastChild);
		    }

		    for (i=1; i<=pagination.last; i++) {
		        var el = document.createElement('a');
		        el.href = "#placesList";
		        el.innerHTML = i;

		        if (i===pagination.current) {
		            el.className = 'on';
		        } else {
		            el.onclick = (function(i) {
		                return function() {
		                    pagination.gotoPage(i);
		                }
		            })(i);
		        }

		        fragment.appendChild(el);
		    }
		    paginationEl.appendChild(fragment);
		}

		// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
		// 인포윈도우에 장소명을 표시합니다
		function displayInfowindow(marker, title) {
		    var content = '<div style="padding:5px;z-index:10; width: 100px; height: 100px;">' + title + '</div>';

		    infowindow.setContent(content);
		    infowindow.open(map, marker);
		}

		 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
		function removeAllChildNods(el) {   
		    while (el.hasChildNodes()) {
		        el.removeChild (el.lastChild);
		    }
		}
	</script>
</body>
</html>