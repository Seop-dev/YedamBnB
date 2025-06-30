package com.yedambnb.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yedambnb.common.Control;

public class GetBnbControl implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. 목록 페이지에서 넘겨준 lodging_no 파라미터를 받습니다.
        String lodgingNo = req.getParameter("lodging_no");
        
        // 2. 잘 받았는지 콘솔에 출력해서 확인합니다.
        System.out.println("요청된 숙소 번호: " + lodgingNo);

        // 3. 나중에 상세 페이지 팀원이 이 데이터를 사용할 수 있도록 request에 담아줍니다.
        req.setAttribute("lodgingNo", lodgingNo);
        
        // 4. 상세 페이지(lodgingList.jsp)로 이동시킵니다.
        req.getRequestDispatcher("bnb/lodgingList.tiles").forward(req, resp);
    }
}