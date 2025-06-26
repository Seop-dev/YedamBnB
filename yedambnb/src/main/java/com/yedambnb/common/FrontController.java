package com.yedambnb.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.control.BoardListControl;
import com.yedambnb.control.BookingListControl;
import com.yedambnb.control.UserInfoControl;

public class FrontController extends HttpServlet {
	Map<String, Control> map;

	public FrontController() {
		map = new HashMap<String, Control>();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
		map.put("/boardList.do", new BoardListControl());
		map.put("/userInfo.do", new UserInfoControl());
		map.put("/bookingList.do", new BookingListControl());
	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url이 호출(http://localhost:8080/yedambnb/boardList.do) -> 페이지 호출 -> Control.
		String uri = req.getRequestURI(); 
		String context = req.getContextPath(); 
		String page = uri.substring(context.length()); 
		
		Control control = map.get(page);
		control.exec(req, resp); // String viewPage = 부분을 삭제하고, exec()만 호출합니다.
	}
}
// ...