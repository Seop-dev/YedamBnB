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
        String userId = "user1"; 
        BookingService service = new BookingServiceImpl();
        List<BookingVO> list = service.getBookingsByUserId(userId);
        req.setAttribute("bookingList", list);
      
        req.getRequestDispatcher("bookingList.tiles").forward(req, resp);
    }
}
