<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>
    .content-section { padding-top: 120px; }
    .map-container { position: sticky; top: 120px; height: calc(100vh - 120px); }
    .list-container { height: calc(100vh - 120px); overflow-y: auto; }
    .custom-overlay { background-color: white; border: 1px solid #333; border-radius: 15px; padding: 5px 10px; font-weight: bold; box-shadow: 0px 1px 2px 1px rgba(0, 0, 0, 0.1); }
</style>

<div class="content-section">
    <div class="container-fluid">
        <div class="row">
            <div class="col-lg-7 list-container py-5">
                <div class="container">
                    <div class="row mb-5 align-items-center">
                        <div class="col-lg-12">
                            <h2 id="list-title" class="font-weight-bold text-primary heading">'${keyword eq "" ? "전체" : keyword}' 검색 결과 (${pageDTO.total}건)</h2>
                        </div>
                    </div>
                    <div class="row" id="bnb-list-area">
                        <c:forEach var="bnb" items="${bnbList}"><div class="col-md-6"><div class="property-item mb-30"><a href="#" class="img"><img src="images/img_1.jpg" alt="Image" class="img-fluid" /></a><div class="property-content"><div class="price mb-2"><span>${bnb.price}원 / 박</span></div><div><span class="d-block mb-2 text-black-50">${bnb.lodgingName}</span><span class="city d-block mb-3">${bnb.lodgingAddress}</span><a href="#" class="btn btn-primary py-2 px-3">상세보기</a></div></div></div></div></c:forEach>
                    </div>
                    <div class="row align-items-center py-5">
                        <div class="col-lg-12">
                            <nav id="pagination-nav" aria-label="Page navigation"><ul class="pagination justify-content-center">
                                <c:if test="${pageDTO.prev}"><li class="page-item"><a class="page-link" href="bnbList.do?pageNum=${pageDTO.startPage - 1}&keyword=${keyword}" aria-label="Previous"><span aria-hidden="true">&lt;</span></a></li></c:if>
                                <c:forEach var="num" begin="${pageDTO.startPage}" end="${pageDTO.endPage}"><li class="page-item ${pageDTO.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="bnbList.do?pageNum=${num}&keyword=${keyword}">${num}</a></li></c:forEach>
                                <c:if test="${pageDTO.next}"><li class="page-item"><a class="page-link" href="bnbList.do?pageNum=${pageDTO.endPage + 1}&keyword=${keyword}" aria-label="Next"><span aria-hidden="true">&gt;</span></a></li></c:if>
                            </ul></nav>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-5"><div id="map" class="map-container"></div></div>
        </div>
    </div>
</div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8ca34376a28f1be6d003abb742bed410&libraries=services"></script>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const initialBnbData = JSON.parse('${bnbListJson}');
        const mapContainer = document.getElementById('map');
        const mapOption = { center: new kakao.maps.LatLng(36.5, 127.5), level: 12 };
        const map = new kakao.maps.Map(mapContainer, mapOption);
        let currentOverlays = [];
        let isInitialLoad = true;

        function drawOverlays(list, fitBounds) {
            currentOverlays.forEach(o => o.setMap(null));
            currentOverlays = [];
            if (!list || list.length === 0) return;

            const newBounds = new kakao.maps.LatLngBounds(); // 'newBounds'로 선언
            
            list.forEach(bnb => {
                if (bnb.latitude && bnb.longitude) {
                    const position = new kakao.maps.LatLng(bnb.latitude, bnb.longitude);
                    const content = `<div class="custom-overlay">₩\${bnb.price.toLocaleString()}</div>`;
                    const overlay = new kakao.maps.CustomOverlay({ map: map, position: position, content: content, yAnchor: 1 });
                    currentOverlays.push(overlay);
                    
                    // ★★★ 수정된 부분: bounds -> newBounds ★★★
                    // 이전에 bounds.extend()로 잘못되어 있었던 오타를 수정합니다.
                    newBounds.extend(position);
                }
            });

            if (fitBounds && currentOverlays.length > 0) {
                map.setBounds(newBounds);
            }
        }

        function updateAccomodationList(list) {
            const listArea = document.getElementById('bnb-list-area');
            const listTitle = document.getElementById('list-title');
            const paginationNav = document.getElementById('pagination-nav');
            listArea.innerHTML = '';
            
            if (paginationNav) { paginationNav.style.display = 'none'; }

            if (!list || list.length === 0) {
                listTitle.innerText = '현재 지도에 표시할 숙소가 없습니다.';
                listArea.innerHTML = '<div class="col-12"><div class="alert alert-warning">지도를 움직여 다른 지역을 탐색해보세요.</div></div>';
                return;
            }
            
            listTitle.innerText = `현재 지도에 표시된 숙소 (\${list.length})건`;

            list.forEach(bnb => {
                const listItemHtml = `<div class="col-md-6"><div class="property-item mb-30"><a href="#" class="img"><img src="images/img_1.jpg" alt="Image" class="img-fluid" /></a><div class="property-content"><div class="price mb-2"><span>\${bnb.price.toLocaleString()}원 / 박</span></div><div><span class="d-block mb-2 text-black-50">\${bnb.lodgingName}</span><span class="city d-block mb-3">\${bnb.lodgingAddress}</span><a href="#" class="btn btn-primary py-2 px-3">상세보기</a></div></div></div></div>`;
                listArea.innerHTML += listItemHtml;
            });
        }

        kakao.maps.event.addListener(map, 'idle', function () {
            if (isInitialLoad) {
                isInitialLoad = false;
                return;
            }
            const bounds = map.getBounds();
            const swLatLng = bounds.getSouthWest();
            const neLatLng = bounds.getNorthEast();
            if (isNaN(swLatLng.getLat())) return;
            
            const params = new URLSearchParams({ swLat: swLatLng.getLat(), swLng: swLatLng.getLng(), neLat: neLatLng.getLat(), neLng: neLatLng.getLng() }).toString();
            fetch('getListInBounds.do?' + params)
                .then(response => response.json())
                .then(data => {
                    updateAccomodationList(data);
                    drawOverlays(data, false);
                })
                .catch(error => console.error('Error fetching data:', error));
        });

        // 최초 로드 시, 전체 마커를 그리고 지도 범위를 맞춤
        drawOverlays(initialBnbData, true);
    });
</script>