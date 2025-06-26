package com.yedambnb.control;

import java.io.IOException;
import java.util.List; // [수정] 누락된 import 구문 추가

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.BookingService;       // [수정] 누락된 import 구문 추가
import com.yedambnb.service.BookingServiceImpl; // [수정] 누락된 import 구문 추가
import com.yedambnb.vo.BookingVO;                 // [수정] 누락된 import 구문 추가

public class BookingListControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = "user1"; 
        BookingService service = new BookingServiceImpl();
        List<BookingVO> list = service.getBookingsByUserId(userId);
        req.setAttribute("bookingList", list);
      
        req.getRequestDispatcher("user/booking.tiles").forward(req, resp);
    }
}