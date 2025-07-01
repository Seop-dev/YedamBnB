package com.yedambnb.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.control.AddBookingControl;
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
import com.yedambnb.control.CancelBookingControl;
import com.yedambnb.control.DeleteUserControl;
import com.yedambnb.control.GetBnbControl;
import com.yedambnb.control.GetListInBoundsControl;
import com.yedambnb.control.LoginForm;
import com.yedambnb.control.Logout;
import com.yedambnb.control.RemoveWishlistControl;
import com.yedambnb.control.TempLoginAdmin;
import com.yedambnb.control.TempLoginUser;
import com.yedambnb.control.UserInfoControl;
import com.yedambnb.control.WishlistControl;
import com.yedambnb.control.lodgingDetailControl;

public class FrontController extends HttpServlet {
	Map<String, Control> map;

	public FrontController() {
		map = new HashMap<String, Control>();
	}

	@Override
	public void init(ServletConfig config) throws ServletException {
	    

	    // 로그인/로그아웃 관련 매핑
	    map.put("/loginForm.do", new LoginForm());
	    map.put("/TempLoginUser.do", new TempLoginUser());
	    map.put("/TempLoginAdmin.do", new TempLoginAdmin());
	    map.put("/logout.do", new Logout());
	    
	    // 지도관련 매핑
	    map.put("/getListInBounds.do", new GetListInBoundsControl());

		// ================== 숙소 관련 (신규 추가) ==================
		map.put("/main.do", new MainControl()); // 메인 페이지
		map.put("/bnbList.do", new BnbListControl()); // 메인 페이지
		map.put("/getLodgingList.do", new GetLodgingListControl()); // 숙소 검색 목록
		// ========================================================
		map.put("/userInfo.do", new UserInfoControl());
		map.put("/bookingList.do", new BookingListControl());
		// =================== 로그인 및 회원등록(동원) ==========================
		map.put("/signupForm.do", new RegisterFormControl()); // 회원가입 화면
		map.put("/register.do", new RegisterControl()); // 회원가입 화면에서 데이터 전달 컨트롤
		map.put("/loginForm.do", new LoginFormControl()); // 로그인 화면
		map.put("/checkId.do", new CheckIdControl()); // id중복체크
		map.put("/login.do", new LoginControl()); // 로그인페이지
		map.put("/addReview.do", new AddReviewControl());
		
		
		// ============ 숙소단건조회 ===================
		map.put("/lodgingDetail.do", new lodgingDetailControl());
		map.put("/addBooking.do", new AddBookingControl());

		map.put("/wishlist.do", new WishlistControl());
		map.put("/removeWishlist.do", new RemoveWishlistControl());
		map.put("/cancelBooking.do",new CancelBookingControl() );
		map.put("/deleteUser.do", new DeleteUserControl());

		// 상세보기
		map.put("/getBnb.do", new GetBnbControl());

	}

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// url이 호출(http://localhost:8080/yedambnb/boardList.do) -> 페이지 호출 -> Control.
		req.setCharacterEncoding("utf-8"); // 한글 처리를 위해 추가

		String uri = req.getRequestURI();
		String context = req.getContextPath();
		String page = uri.substring(context.length());

		// ================= ★★★ 디버깅 코드 추가 ★★★ =================
		System.out.println("-----------------------------------------");
		System.out.println("요청 URI: " + uri);
		System.out.println("Context Path: " + context);
		System.out.println("계산된 page Key: [" + page + "]"); // 대괄호로 감싸서 공백 확인
		System.out.println("map에 등록된 컨트롤러 개수: " + map.size());
		System.out.println("map에 등록된 키 목록: " + map.keySet()); // ★★★★★ 가장 중요한 정보
		System.out.println("-----------------------------------------");
		// =========================================================

		Control control = map.get(page);

		// ================= ★★★ 디버깅 코드 추가 2 ★★★ =================
		if (control == null) {
			System.out.println("!!! CRITICAL ERROR !!!");
			System.out.println("!!! " + page + "에 해당하는 컨트롤러가 map에 등록되지 않았습니다 !!!");
			System.out.println("!!! init() 메소드의 map.put() 부분을 다시 확인해주세요 !!!");
			// 여기서 NullPointerException이 발생합니다.
		}
		// =========================================================

		control.exec(req, resp);
	}
}

// ...