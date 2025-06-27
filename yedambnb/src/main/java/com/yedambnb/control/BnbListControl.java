package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.yedambnb.common.Control;
import com.yedambnb.common.Criteria; // Criteria import 추가
import com.yedambnb.common.PageDTO;
import com.yedambnb.service.BnbService;
import com.yedambnb.service.BnbServiceImpl;
import com.yedambnb.vo.BnbVO;

public class BnbListControl implements Control {
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// ★★★ 시작: 누락되었던 파라미터 처리 및 Criteria 객체 생성 로직 ★★★
		String pageNum = req.getParameter("pageNum");
		String keyword = req.getParameter("keyword");
		
		// pageNum 파라미터가 없으면 1페이지로, 있으면 해당 페이지로 설정
		pageNum = (pageNum == null) ? "1" : pageNum;
		// keyword 파라미터가 없으면 빈 문자열로 설정 (전체 목록 조회)
		keyword = (keyword == null) ? "" : keyword;

		// Criteria 객체 생성 (한 페이지에 9개씩)
		Criteria cri = new Criteria(Integer.parseInt(pageNum), 9);
		// ★★★ 종료: 누락되었던 로직 종료 ★★★

		BnbService service = new BnbServiceImpl();
		List<BnbVO> list = service.searchBnbListPaging(cri, keyword);
		int total = service.getTotalCount(keyword);
		
		PageDTO pageDTO = new PageDTO(cri, total);

		// 리스트를 JSON 문자열로 변환하여 request에 추가
		Gson gson = new Gson();
		String bnbListJson = gson.toJson(list);
		req.setAttribute("bnbListJson", bnbListJson);
		
		req.setAttribute("bnbList", list); // 기존 목록 (왼쪽 UI 표시에 사용)
		req.setAttribute("keyword", keyword);
		req.setAttribute("pageDTO", pageDTO); // 페이지 정보

		String path = "bnb/bnbList.tiles";
		req.getRequestDispatcher(path).forward(req, resp);
	}
}