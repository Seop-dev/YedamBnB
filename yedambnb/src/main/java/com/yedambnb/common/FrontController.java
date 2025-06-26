package com.yedambnb.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.control.BnbListControl;
import com.yedambnb.control.GetLodgingListControl;
import com.yedambnb.control.MainControl;


/*
 * M-V-Control역할.
 * url패턴 - 실행서블릿 관리.
 */
public class FrontController extends HttpServlet {
	Map<String, Control> map;

	public FrontController() {
		map = new HashMap<String, Control>();
	}
	@Override
	public void init(ServletConfig config) throws ServletException {
		// boardList.do - 글목록 출력 기능.
		// 처리순서가 중요.
		
		// ================== 숙소 관련 (신규 추가) ==================
	    map.put("/main.do", new MainControl());             // 메인 페이지
	    map.put("/bnbList.do", new BnbListControl());             // 메인 페이지
	    map.put("/getLodgingList.do", new GetLodgingListControl()); // 숙소 검색 목록
	    // ========================================================
	}
	
	
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url이 호출(http://localhost:8080/BoardWeb/boardList.do) -> 페이지 호출 -> Control.
		String uri = req.getRequestURI(); // /BoardWeb/boardList.do
		String context = req.getContextPath(); // /BoardWeb or /HelloWorld
		String page = uri.substring(context.length()); // /boardList.do
		Control sub = map.get(page);
		sub.exec(req, resp);

	}
}