<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    /* 상단 헤더와의 간격을 120px로 재설정 */
    .content-section {
        padding-top: 120px;
    }
    /* Flexbox를 이용한 안정적인 좌우 분할 레이아웃 */
    .split-container {
        display: flex;
        flex-wrap: wrap;
    }
    .list-panel {
        width: 58.33%; /* 7/12 너비 */
        height: calc(100vh - 120px); /* 헤더 높이를 뺀 나머지 전체 높이 */
        overflow-y: auto; /* 내용이 길어지면 스크롤 */
        padding: 1.5rem;
    }
    .map-panel {
        width: 41.67%; /* 5/12 너비 */
        height: calc(100vh - 120px);
        position: sticky; /* 스크롤 시에도 위치 고정 */
        top: 120px;
    }
    #map {
        width: 100%;
        height: 100%;
        border-radius: 12px;
    }
    /* 이미지 깨짐 방지를 위한 CSS */
    .property-item {
        display: flex;
        flex-direction: column;
        height: 100%;
    }
    .property-item .img {
        display: block;
        aspect-ratio: 4 / 3;
        overflow: hidden;
        border-radius: 8px;
    }
    .property-item .img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.3s ease;
    }
    .property-item:hover .img img {
        transform: scale(1.05);
    }
    .property-content {
        padding-top: 1rem;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    .custom-overlay { 
        background-color: white; border: 1px solid #333; border-radius: 15px; 
        padding: 5px 10px; font-weight: bold; box-shadow: 0px 1px 2px 1px rgba(0, 0, 0, 0.1); 
    }
    /* 반응형 레이아웃 */
    @media (max-width: 991.98px) {
        .list-panel, .map-panel { width: 100%; }
        .list-panel { height: auto; overflow-y: visible; }
        .map-panel {
            height: 50vh;
            position: relative;
            top: 0;
            margin-top: 30px;
        }
    }
</style>

<div class="content-section">
    <div class="container-fluid">
        <div class="split-container">
            <div class="list-panel">
                <div class="row mb-5 align-items-center">
                    <div class="col-lg-12">
                        <h2 id="list-title" class="font-weight-bold text-primary heading">'${keyword eq "" ? "전체" : keyword}' 검색 결과 (${pageDTO.total}건)</h2>
                    </div>
                </div>
                <div class="row" id="bnb-list-area">
                    <c:forEach var="lodging" items="${bnbList}">
                        <div class="col-lg-6 col-md-12 mb-4">
                            <div class="property-item h-100">
                                <a href="getBnb.do?lodging_no=${lodging.lodgingNo}" class="img">
                                    <img src="image/${lodging.thumbnailImg}" alt="${lodging.name}" class="img-fluid" />
                                </a>
                                <div class="property-content">
                                    <div class="price mb-2"><span><fmt:formatNumber value="${lodging.pricePerNight}" pattern="#,###" />원/박</span></div>
                                    <div>
                                        <span class="d-block mb-2 text-black-50">${lodging.name}</span>
                                        <span class="city d-block mb-3">${lodging.address}</span>
                                    </div>
                                    <div class="mt-auto">
                                        <a href="getBnb.do?lodging_no=${lodging.lodgingNo}" class="btn btn-primary py-2 px-3">상세보기</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="row align-items-center py-5">
                    <div class="col-lg-12">
                        <nav id="pagination-nav" aria-label="Page navigation">
                            <ul class="pagination pagination-sm justify-content-center"></ul>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="map-panel">
                <div id="map"></div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ca34376a28f1be6d003abb742bed410&autoload=false"></script>
<script>
    // kakao.maps.load를 사용하여, 카카오 지도 API가 완전히 로드된 후에 모든 코드가 실행되도록 보장합니다.
    kakao.maps.load(function() {
        // 안정적인 실행을 위해 setTimeout으로 감싸기
        setTimeout(function() {
            // 1. 변수 초기 설정
            const initialFullData = ${fullListJson};
            const initialPageDTO = ${pageDTOJson};
            let currentKeyword = '${keyword}';

            const mapContainer = document.getElementById('map');
            const mapOption = { center: new kakao.maps.LatLng(36.5, 127.5), level: 12 };
            const map = new kakao.maps.Map(mapContainer, mapOption);
            let currentOverlays = [];

            // 2. UI 업데이트 함수들
            function drawOverlays(list, fitBounds) {
                currentOverlays.forEach(o => o.setMap(null));
                currentOverlays = [];
                if (!list || list.length === 0) return;
                const newBounds = new kakao.maps.LatLngBounds();
                list.forEach(lodging => {
                    if (lodging.lat && lodging.lng) {
                        const position = new kakao.maps.LatLng(lodging.lat, lodging.lng);
                        const content = '<div class="custom-overlay">₩' + lodging.pricePerNight.toLocaleString() + '</div>';
                        const overlay = new kakao.maps.CustomOverlay({ map: map, position: position, content: content, yAnchor: 1 });
                        currentOverlays.push(overlay);
                        newBounds.extend(position);
                    }
                });
                if (fitBounds && currentOverlays.length > 0) {
                    map.setBounds(newBounds);
                }
            }

            function updateAccomodationList(list, total) {
                const listArea = document.getElementById('bnb-list-area');
                const listTitle = document.getElementById('list-title');
                listArea.innerHTML = '';
                if (!list || list.length === 0) {
                    listTitle.innerText = '현재 지도에 표시할 숙소가 없습니다.';
                    listArea.innerHTML = '<div class="col-12"><div class="alert alert-warning">지도를 움직여 다른 지역을 탐색해보세요.</div></div>';
                    return;
                }
                listTitle.innerText = '현재 지도에 표시된 숙소 (' + total + '건)';
                let listHtml = '';
                list.forEach(lodging => {
                    listHtml +=
                        '<div class="col-lg-6 col-md-12 mb-4">' +
                            '<div class="property-item h-100">' +
                                '<a href="getBnb.do?lodging_no=' + lodging.lodgingNo + '" class="img">' +
                                    '<img src="image/' + lodging.thumbnailImg + '" alt="' + lodging.name + '" class="img-fluid" />' +
                                '</a>' +
                                '<div class="property-content">' +
                                    '<div class="price mb-2"><span>' + lodging.pricePerNight.toLocaleString() + '원/박</span></div>' +
                                    '<div>' +
                                        '<span class="d-block mb-2 text-black-50">' + lodging.name + '</span>' +
                                        '<span class="city d-block mb-3">' + lodging.address + '</span>' +
                                    '</div>' +
                                    '<div class="mt-auto">' +
                                       '<a href="getBnb.do?lodging_no=' + lodging.lodgingNo + '" class="btn btn-primary py-2 px-3">상세보기</a>' +
                                    '</div>' +
                                '</div>' +
                            '</div>' +
                        '</div>';
                });
                listArea.innerHTML = listHtml;
            }

            function updatePagination(pageDTO, fromMap) {
                const paginationUl = document.querySelector('#pagination-nav ul');
                paginationUl.innerHTML = '';
                if (!pageDTO || pageDTO.total <= pageDTO.cri.amount) {
                    paginationUl.parentElement.style.display = 'none';
                    return;
                }
                paginationUl.parentElement.style.display = 'block';
                paginationUl.className = 'pagination pagination-sm justify-content-center';
                let paginationHtml = '';
                if (pageDTO.prev) { paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageDTO.startPage - 1) + '">&lt;</a></li>'; }
                for (let i = pageDTO.startPage; i <= pageDTO.endPage; i++) { paginationHtml += '<li class="page-item ' + (pageDTO.cri.pageNum == i ? 'active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>'; }
                if (pageDTO.next) { paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageDTO.endPage + 1) + '">&gt;</a></li>'; }
                paginationUl.innerHTML = paginationHtml;
                paginationUl.querySelectorAll('a.page-link').forEach(link => {
                    link.addEventListener('click', function(e) {
                        e.preventDefault();
                        const pageNum = this.dataset.page;
                        if (fromMap) {
                            fetchDataInBounds(pageNum);
                        } else {
                            location.href = 'bnbList.do?pageNum=' + pageNum + '&keyword=' + currentKeyword;
                        }
                    });
                });
            }
        
            function fetchDataInBounds(pageNum = 1) {
                 const bounds = map.getBounds();
                 const sw = bounds.getSouthWest();
                 const ne = bounds.getNorthEast();
                 if (isNaN(sw.getLat())) { return; }
                 const params = new URLSearchParams({ swLat: sw.getLat(), swLng: sw.getLng(), neLat: ne.getLat(), neLng: ne.getLng(), pageNum: pageNum }).toString();
                 fetch('getListInBounds.do?' + params)
                    .then(res => res.json())
                    .then(data => {
                        updateAccomodationList(data.paginatedList, data.pageDTO.total);
                        drawOverlays(data.fullListForMap, false);
                        updatePagination(data.pageDTO, true);
                    });
            }

            // 3. 이벤트 리스너 등록
            kakao.maps.event.addListener(map, 'idle', fetchDataInBounds);
            
            // 4. 최초 로드 시 UI 그리기
            updatePagination(initialPageDTO, false);
            drawOverlays(initialFullData, true);
        }, 0);
    });
</script>