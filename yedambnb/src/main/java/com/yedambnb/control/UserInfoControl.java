package com.yedambnb.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.vo.UserVO;

public class UserInfoControl implements Control {
	@Override
	public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		UserService svc = new UserServiceImpl();

		// GET 요청: 사용자 정보 조회 페이지
		if (req.getMethod().equals("GET")) {
			HttpSession session = req.getSession();
			// 세션에서 로그인 시 저장된 "logId" 값을 가져옵니다.
			String userId = (String) session.getAttribute("logId");

			// [수정] 비로그인 사용자에 대한 처리
			if (userId == null) {
				// userId가 null이면 로그인되지 않은 상태이므로, 로그인 페이지로 보냅니다.
				resp.sendRedirect("loginForm.do");
				return; // 더 이상 아래 코드를 실행하지 않고 종료합니다.
			}

			// 로그인된 사용자의 정보 조회
			UserVO user = svc.getUser(userId);
			req.setAttribute("userInfo", user);

			req.getRequestDispatcher("user/userInfo.tiles").forward(req, resp);
			
		} else { // POST 요청: 사용자 정보 수정 처리
			req.setCharacterEncoding("UTF-8");
			
			String userNoStr = req.getParameter("userNo");
			String userName = req.getParameter("userName");
			String telephone = req.getParameter("phone");
			String birthDateStr = req.getParameter("birthDate");
			
			UserVO user = new UserVO();
			
			user.setUserNo(Integer.parseInt(userNoStr));
			user.setUserName(userName);
			user.setTelephone(telephone);
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			try {
				if(birthDateStr != null && !birthDateStr.equals("")) {
					user.setBirthDate(sdf.parse(birthDateStr));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			if(svc.modifyUser(user)) {
                resp.sendRedirect("userInfo.do?result=success");
            } else {
                resp.sendRedirect("userInfo.do?result=fail");
            }
		}
	}
}
