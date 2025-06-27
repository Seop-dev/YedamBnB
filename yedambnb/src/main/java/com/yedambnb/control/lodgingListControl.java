package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.LodgingListService;
import com.yedambnb.service.LodgingListServiceImpl;
import com.yedambnb.vo.LodgingVO;

public class lodgingListControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String lodgingNo = req.getParameter("lodging_no");
		
		req.setAttribute("lodging_no", lodgingNo);
				
		req.getRequestDispatcher("bnb/lodgingList.tiles").forward(req, resp);

	}

}
