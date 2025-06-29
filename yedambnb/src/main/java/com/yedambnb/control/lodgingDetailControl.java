package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.LodgingDetailService;
import com.yedambnb.service.LodgingDetailServiceImpl;
import com.yedambnb.service.MPReviewService;
import com.yedambnb.service.MPReviewServiceImpl;
import com.yedambnb.vo.LodgingVO;
import com.yedambnb.vo.MPReviewVO;


public class lodgingDetailControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 숙소별 조회
		String lodgingNo = req.getParameter("lodging_no");
		LodgingDetailService lsvc = new LodgingDetailServiceImpl();
		LodgingVO lodging =  lsvc.lodgingDetail(Integer.parseInt(lodgingNo));
		
		// 리뷰 조회
		// MPReview lodgingId로 변경 필요
		MPReviewService mprsvc = new MPReviewServiceImpl();
		List<MPReviewVO> reviewList = mprsvc.selectReview(Integer.parseInt(lodgingNo));
		
		// 위시리스트추가 버튼에서 parameter넘길 값
		

		// GET방식으로 보내기
		if(req.getMethod().equals("GET")) {
			req.setAttribute("lodging", lodging);
			req.setAttribute("reviewList", reviewList);
			req.getRequestDispatcher("bnb/lodgingList.tiles").forward(req, resp);
		}

	
	}

}
