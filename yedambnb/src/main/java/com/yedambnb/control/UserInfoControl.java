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

		if (req.getMethod().equals("GET")) {
			HttpSession session = req.getSession();
			String userId = (String) session.getAttribute("logId");

			if (userId == null) {
				userId = "user1"; // 임시 테스트용 ID
			}

			UserVO user = svc.getUser(userId);
			req.setAttribute("userInfo", user);

			// [수정] 이 forward 코드가 누락되었습니다. 새로운 tiles 규칙에 맞게 추가합니다.
			req.getRequestDispatcher("user/userInfo.tiles").forward(req, resp);
			
		} else { // POST 방식일 때
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