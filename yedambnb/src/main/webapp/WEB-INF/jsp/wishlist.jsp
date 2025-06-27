<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<main class="main-content">
    <h1>위시리스트</h1>

    <%-- 위시리스트가 비어있을 경우 --%>
    <c:if test="${empty wishlist}">
        <p>위시리스트에 담은 숙소가 없습니다.</p>
    </c:if>

    <div class="wishlist-grid">
        <%-- Controller가 넘겨준 wishlist를 반복하여 아이템을 생성 --%>
        <c:forEach var="w" items="${wishlist}">
            <div class="wishlist-item">
                <div class="img-container">
                    <img src="${pageContext.request.contextPath}/image/${w.photoPath}" alt="숙소 이미지">
                    
                    <%-- 찜 해제 버튼 (기능은 나중에 추가 가능) --%>
                    <button class="btn-wishlist" data-wishlist-id="${w.wishlistId}">
                        <svg viewBox="0 0 32 32" xmlns="http://www.w3.org/2000/svg" style="display:block;fill:rgba(0, 0, 0, 0.5);height:24px;width:24px;stroke:#fff;stroke-width:2;overflow:visible">
                            <path d="m16 28c7-4.733 14-10 14-17a6.979 6.979 0 0 0 -1.222-4.267 7.006 7.006 0 0 0 -5.778-2.733c-2.404 0-4.606 1.156-6 2.94-1.393-1.783-3.596-2.94-6-2.94a7.006 7.006 0 0 0 -5.778 2.733 6.979 6.979 0 0 0 -1.222 4.267c0 7 7 12.267 14 17z"></path>
                        </svg>
                    </button>
                </div>
                <div class="content">
                    <p class="title">${w.name}</p>
                    <p class="price">
                        ₩<fmt:formatNumber value="${w.pricePerNight}" pattern="#,###" /> / 1박
                    </p>
                </div>
            </div>
        </c:forEach>
    </div>
</main>
<%-- ... (<div class="wishlist-grid"> ... </div>) ... --%>
</main>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // 1. 모든 '찜 해제' 버튼(하트)을 찾습니다.
    const wishlistButtons = document.querySelectorAll('.btn-wishlist');

    // 2. 각각의 버튼에 클릭 이벤트를 추가합니다.
    wishlistButtons.forEach(button => {
        button.addEventListener('click', function(event) {
            event.preventDefault();

            // 3. 정말 삭제할 것인지 사용자에게 확인받습니다.
            if (!confirm('이 숙소를 위시리스트에서 삭제하시겠어요?')) {
                return; // '취소'를 누르면 아무것도 하지 않음
            }

            // 4. 버튼에 저장해 둔 'wishlist-id' 값을 가져옵니다.
            const wishlistId = this.dataset.wishlistId;
            const card = this.closest('.wishlist-item'); // 삭제할 카드 요소를 미리 찾아둠

            // 5. fetch를 이용해 서버에 삭제 요청을 보냅니다.
            const formData = new URLSearchParams();
            formData.append('wishlistId', wishlistId);

            fetch('/yedambnb/removeWishlist.do', {
                method: 'POST',
                body: formData
            })
            .then(response => response.json())
            .then(data => {
                // 6. 서버로부터 받은 결과에 따라 처리합니다.
                if (data.retCode === 'Success') {
                    alert('위시리스트에서 삭제되었습니다.');
                    // 7. 성공 시, 화면에서 해당 카드를 부드럽게 사라지게 합니다.
                    card.style.transition = 'opacity 0.5s';
                    card.style.opacity = '0';
                    setTimeout(() => {
                        card.remove();
                    }, 500); // 0.5초 후에 완전히 제거
                } else {
                    alert('삭제에 실패했습니다.');
                }
            })
            .catch(err => {
                console.error('Error:', err);
                alert('오류가 발생했습니다.');
            });
        });
    });
});
</script>