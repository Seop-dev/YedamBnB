package com.yedambnb.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.BookingService;
import com.yedambnb.service.BookingServiceImpl;
import com.yedambnb.vo.ReservationVO;

public class AddBookingControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		  resp.setContentType("text/json;charset=utf-8");
		
	  String checkInDate = req.getParameter("check_in_date");
	  String checkOutDate = req.getParameter("check_out_date");
	  // String memberCount = req.getParameter("member_count");
	  String lodgingNo = req.getParameter("lodging_no");  // accommodation_id -> lodging_id 변경 필요
	  // String userId = req.getParameter("user_id");
	  String memberCount =req.getParameter("memberCount");
	  String totalPrice =req.getParameter("totalPrice");
//	  HttpSession session = req.getSession();
//  	  String userId = (String) session.getAttribute("userId");

	  String userId = "user01";
	  
	  System.out.println("숙소id " + lodgingNo);
	  System.out.println("체크인 :" + checkOutDate);
	  System.out.println("체크인 :" + checkInDate);
	  
	  ReservationVO bvo = new ReservationVO();

	  
	  PrintWriter out = resp.getWriter();
	  

		bvo.setLodgingNo(Integer.parseInt(lodgingNo));
		bvo.setCheckInDate(checkInDate);
		bvo.setCheckOutDate(checkOutDate);
		bvo.setMemberCount(Integer.parseInt(memberCount));
		bvo.setTotalPrice((Integer.parseInt(memberCount) * 20000) + Integer.parseInt(totalPrice));
		bvo.setUserId(userId);
		
		System.out.println(bvo.getTotalPrice());
		
		BookingService svc = new BookingServiceImpl();
		if(svc.addReservation(bvo)) {
			out.print("{\"retCode\":\"Success\"}");  // 성공할 경우		  
			
		}
	  // bvo.setMemberCount(memberCount);
	  // bvo.setUserId(userId);

	  
	}

}
