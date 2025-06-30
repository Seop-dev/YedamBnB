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
        String userId = (String) session.getAttribute("logId");
        if (userId == null) {
            userId = "user1"; // 임시 테스트용 ID
        }
        
        BookingService svc = new BookingServiceImpl();
        List<BookingVO> list = svc.getBookingsByUserId(userId);
        
        req.setAttribute("bookingList", list);
        req.setAttribute("logId", userId);  // 추가: JSP에서 ${logId} 사용 가능하도록
        req.getRequestDispatcher("user/booking.tiles").forward(req, resp);
    }
}