package com.yedambnb.control;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.yedambnb.common.Control;
import com.yedambnb.service.BookingService;
import com.yedambnb.service.BookingServiceImpl;
import com.yedambnb.vo.BookingVO;

public class BookingListControl implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // [수정] 세션에서 "logId" 값을 가져옵니다.
        String userId = (String) session.getAttribute("logId");
        
        // [수정] 비로그인 사용자에 대한 처리
        if (userId == null) {
            // userId가 null이면 로그인되지 않은 상태이므로, 로그인 페이지로 보냅니다.
            resp.sendRedirect("loginForm.do");
            return; // 더 이상 아래 코드를 실행하지 않고 종료합니다.
        }
        
        // 로그인된 사용자의 ID로 예약 목록을 조회합니다.
        BookingService svc = new BookingServiceImpl();
        List<BookingVO> list = svc.getBookingsByUserId(userId);
        
        req.setAttribute("bookingList", list);
        
        // JSP에서 사용할 수 있도록 로그인 ID를 request에 담아줍니다.
        req.setAttribute("logId", userId); 
        
        req.getRequestDispatcher("user/booking.tiles").forward(req, resp);
    }
}
