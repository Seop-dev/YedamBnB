package com.yedambnb.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.control.AddReviewControl;
import com.yedambnb.control.BnbListControl;
import com.yedambnb.control.BoardListControl;
import com.yedambnb.control.BookingListControl;
import com.yedambnb.control.CheckIdControl;
import com.yedambnb.control.GetLodgingListControl;
import com.yedambnb.control.LoginControl;
import com.yedambnb.control.LoginFormControl;
import com.yedambnb.control.LogoutControl;
import com.yedambnb.control.MainControl;
import com.yedambnb.control.RegisterControl;
import com.yedambnb.control.RegisterFormControl;
import com.yedambnb.control.UserInfoControl;

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
		map.put("/main.do", new MainControl()); // 메인 페이지
		map.put("/bnbList.do", new BnbListControl()); // 메인 페이지
		map.put("/getLodgingList.do", new GetLodgingListControl()); // 숙소 검색 목록
		// ========================================================
		map.put("/boardList.do", new BoardListControl());
		map.put("/userInfo.do", new UserInfoControl());
		map.put("/bookingList.do", new BookingListControl());
		// =================== 로그인 및 회원등록(동원) ==========================
		map.put("/registerForm.do", new RegisterFormControl()); // 회원가입 화면
		map.put("/register.do", new RegisterControl()); // 회원가입 화면에서 데이터 전달 컨트롤
		map.put("/loginForm.do", new LoginFormControl()); // 로그인 화면
		map.put("/checkId.do", new CheckIdControl()); // id중복체크
		map.put("/login.do", new LoginControl()); // 로그인페이지
		map.put("/addReview.do", new AddReviewControl());
		
		
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