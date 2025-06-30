package com.yedambnb.control;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.yedambnb.common.Control;
import com.yedambnb.common.Criteria;
import com.yedambnb.common.PageDTO;
import com.yedambnb.service.BnbService;
import com.yedambnb.service.BnbServiceImpl;
import com.yedambnb.vo.LodgingVO;

public class BnbListControl implements Control {
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String pageNum = req.getParameter("pageNum");
		String keyword = req.getParameter("keyword");
		
		pageNum = (pageNum == null) ? "1" : pageNum;
		keyword = (keyword == null) ? "" : keyword;

		Criteria cri = new Criteria(Integer.parseInt(pageNum), 9);
		
		BnbService service = new BnbServiceImpl();
		
		List<LodgingVO> paginatedList = service.searchBnbListPaging(cri, keyword);
		List<LodgingVO> fullList = service.searchBnbListAll(keyword);
		int total = service.getTotalCount(keyword);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		Gson gson = new Gson();

		String fullListJson = gson.toJson(fullList);
		String pageDTOJson = gson.toJson(pageDTO);

		// ★★★ 이전에 추가했던 .replace() 코드를 모두 제거합니다. ★★★

		// JavaScript용 데이터
		req.setAttribute("fullListJson", fullListJson);
		req.setAttribute("pageDTOJson", pageDTOJson);
		
		// JSTL용 데이터
		req.setAttribute("bnbList", paginatedList); 
		req.setAttribute("pageDTO", pageDTO);
		req.setAttribute("keyword", keyword);

		req.getRequestDispatcher("bnb/bnbList.tiles").forward(req, resp);
	}
}