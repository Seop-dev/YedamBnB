package com.yedambnb.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.vo.BookingVO;

public class AddBookingControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	  String checkInDate = req.getParameter("check_in_date");
	  String checkOutDate = req.getParameter("check_out_date");
	  //String memberCount = req.getParameter("member_count");
	  String accommodationId = req.getParameter("accommodation_id");  // accommodation_id -> lodging_id 변경 필요
	  //String userId = req.getParameter("user_id");

	  System.out.println("숙소id" + accommodationId);
	  BookingVO bvo = new BookingVO();

	  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	  
	  bvo.setAccommodationId(Integer.parseInt(accommodationId));
	  
	  try {
		bvo.setCheckInDate(sdf.parse(checkInDate));
		bvo.setCheckOutDate(sdf.parse(checkOutDate));
	} catch (ParseException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	  
	  // bvo.setMemberCount(memberCount);
	  //bvo.setUserId(userId);
	  
	  if(checkInDate == null || checkOutDate == null || accommodationId == null) {
		  resp.setContentType("application/json;charset=utf-8");
		  PrintWriter out = resp.getWriter();
		  out.print("{\"retCode\":\"Success\"}");		  
	  } 
	}

}
