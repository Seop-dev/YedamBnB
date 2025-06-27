package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.LodgingDetailService;
import com.yedambnb.service.LodgingDetailServiceImpl;
import com.yedambnb.vo.LodgingVO;


public class lodgingDetailControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String lodgingNo = req.getParameter("lodging_no");
		LodgingDetailService lsvc = new LodgingDetailServiceImpl();
		LodgingVO lodging = (LodgingVO) lsvc.lodgingDetail(Integer.parseInt(lodgingNo));

		req.setAttribute("lodging", lodging);

	
		req.getRequestDispatcher("bnb/lodgingList.tiles").forward(req, resp);
	}

}
