<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<style>
    .content-section { padding-top: 120px; }
    .split-container { display: flex; flex-wrap: wrap; }
    .list-panel { width: 58.33%; padding: 15px; height: calc(100vh - 120px); overflow-y: auto; }
    .map-panel { width: 41.67%; height: calc(100vh - 120px); position: sticky; top: 120px; }
    #map { width: 100%; height: 100%; border-radius: 12px; }
    .custom-overlay { background-color: white; border: 1px solid #333; border-radius: 15px; padding: 5px 10px; font-weight: bold; box-shadow: 0px 1px 2px 1px rgba(0, 0, 0, 0.1); }
    @media (max-width: 991.98px) {
        .list-panel { width: 100%; height: auto; overflow-y: visible; }
        .map-panel { width: 100%; height: 60vh; margin-top: 30px; position: relative; top: 0; }
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
                        <div class="col-md-6">
                            <div class="property-item mb-30">
                                <a href="getBnb.do?lodging_no=${lodging.lodgingNo}" class="img"><img src="images/img_1.jpg" alt="Image" class="img-fluid" /></a>
                                <div class="property-content">
                                    <div class="price mb-2"><span><fmt:formatNumber value="${lodging.pricePerNight}" pattern="#,###" />원/박</span></div>
                                    <div>
                                        <span class="d-block mb-2 text-black-50">${lodging.name}</span>
                                        <span class="city d-block mb-3">${lodging.address}</span>
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

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ca34376a28f1be6d003abb742bed410&libraries=services&autoload=false"></script>
<script>
kakao.maps.load(function() {
    setTimeout(function() {
        const initialFullData = ${fullListJson};
        const initialPageDTO = ${pageDTOJson};
        let currentKeyword = '${keyword}';
        const mapContainer = document.getElementById('map');
        const mapOption = { center: new kakao.maps.LatLng(36.5, 127.5), level: 12 };
        const map = new kakao.maps.Map(mapContainer, mapOption);
        let currentOverlays = [];

        function drawOverlays(list, fitBounds) {
            currentOverlays.forEach(o => o.setMap(null));
            currentOverlays = [];
            if (!list || list.length === 0) return;
            
            const newBounds = new kakao.maps.LatLngBounds();
            list.forEach(lodging => {
                if (lodging.lat && lodging.lng) {
                    const position = new kakao.maps.LatLng(lodging.lat, lodging.lng);
                    const content = '<div class="custom-overlay">₩' + lodging.pricePerNight.toLocaleString() + '</div>';
                    
                    // ★★★ 여기에 map: map 속성을 다시 추가했습니다. ★★★
                    const overlay = new kakao.maps.CustomOverlay({
                        map: map,
                        position: position,
                        content: content,
                        yAnchor: 1
                    });
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
            list.forEach(lodging => {
                const listItemHtml = '<div class="col-md-6"><div class="property-item mb-30"><a href="getBnb.do?lodging_no=' + lodging.lodgingNo + '" class="img"><img src="images/img_1.jpg" alt="Image" class="img-fluid" /></a><div class="property-content"><div class="price mb-2"><span>' + lodging.pricePerNight.toLocaleString() + '원/박</span></div><div><span class="d-block mb-2 text-black-50">' + lodging.name + '</span><span class="city d-block mb-3">' + lodging.address + '</span><a href="getBnb.do?lodging_no=' + lodging.lodgingNo + '" class="btn btn-primary py-2 px-3">상세보기</a></div></div></div></div>';
                listArea.innerHTML += listItemHtml;
            });
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
            if (pageDTO.prev) { paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageDTO.startPage - 1) + '" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li>'; }
            for (let i = pageDTO.startPage; i <= pageDTO.endPage; i++) { paginationHtml += '<li class="page-item ' + (pageDTO.cri.pageNum == i ? 'active' : '') + '"><a class="page-link" href="#" data-page="' + i + '">' + i + '</a></li>'; }
            if (pageDTO.next) { paginationHtml += '<li class="page-item"><a class="page-link" href="#" data-page="' + (pageDTO.endPage + 1) + '" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li>'; }
            paginationUl.innerHTML = paginationHtml;
            paginationUl.querySelectorAll('a.page-link').forEach(link => {
                link.addEventListener('click', function(e) {
                    e.preventDefault();
                    const pageNum = this.dataset.page;
                    if (fromMap) { fetchDataInBounds(pageNum); } 
                    else { location.href = 'bnbList.do?pageNum=' + pageNum + '&keyword=' + currentKeyword; }
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

        kakao.maps.event.addListener(map, 'idle', fetchDataInBounds);
        updatePagination(initialPageDTO, false);
        drawOverlays(initialFullData, true);
    }, 0);
});
</script>