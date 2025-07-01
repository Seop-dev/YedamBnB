// 파일 경로: src/main/java/com/yedam/control/GetLodgingListControl.java

package com.yedambnb.control;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;

public class GetLodgingListControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. main.jsp의 form에서 넘어온 검색어 파라미터 값을 받습니다.
        String keyword = req.getParameter("keyword");

        // 2. (향후 개발) LodgingService, LodgingDAO를 통해 DB에서 숙소 목록을 조회합니다.
        // List<LodgingVO> list = lodgingService.searchByKeyword(keyword);

        // 3. (임시 테스트용) DB 연동 전, JSP가 잘 나오는지 확인하기 위한 더미 데이터
        List<Map<String, String>> dummyList = new ArrayList<>();
        for (int i = 1; i <= 8; i++) {
            Map<String, String> lodging = new HashMap<>();
            lodging.put("id", String.valueOf(i));
            lodging.put("name", "멋진 숙소 " + i + " (" + keyword + " 검색결과)");
            lodging.put("price", String.valueOf(150000 + (i * 10000)));
            // 이미지 경로는 c:url 로 처리되므로 context path를 제외하고 넣습니다.
            lodging.put("imageUrl", "resources/shop/images/product_0" + i + ".jpg");
            dummyList.add(lodging);
        }

        // 4. 조회된 결과(lodgingList)를 request 객체에 담습니다.
        // 이렇게 담아야 JSP에서 <c:forEach items="${lodgingList}"> 로 사용할 수 있습니다.
        req.setAttribute("lodgingList", dummyList); // 나중에 dummyList를 실제 DB조회 결과인 list로 변경

        // 5. tiles.xml에 정의된 <definition name="getLodgingList">를 찾아 페이지를 구성합니다.
        req.getRequestDispatcher("bnb/lodgingDetail.tiles").forward(req, resp);

    }

}