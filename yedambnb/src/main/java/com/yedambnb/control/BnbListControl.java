package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.BnbService;
import com.yedambnb.service.BnbServiceImpl;
import com.yedambnb.vo.BnbVO;

public class BnbListControl implements Control {

	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 1. main.jsp에서 보낸 검색어 파라미터 가져오기
		String keyword = req.getParameter("keyword");

		// 2. 서비스 로직 호출하여 검색 결과 가져오기
		BnbService service = new BnbServiceImpl();
		List<BnbVO> list = service.searchBnbList(keyword); // 이 메소드는 Service/DAO에 구현되어 있어야 합니다.

		// 3. JSP로 결과와 검색어 전달
		req.setAttribute("bnbList", list);
		req.setAttribute("keyword", keyword);

		// 4. 결과 페이지(bnbList.jsp)로 이동
		req.getRequestDispatcher("bnb/bnbList.tiles").forward(req, resp);
	}
}