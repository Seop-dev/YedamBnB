package com.yedambnb.control;

import java.io.IOException;
// import java.io.PrintWriter; // 더 이상 사용하지 않으므로 삭제하거나 그대로 두어도 괜찮습니다.
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

			req.getRequestDispatcher("userInfo.tiles").forward(req, resp);
			
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
                // 성공 시: result=success 파라미터를 붙여 리다이렉트
                resp.sendRedirect("userInfo.do?result=success");
            } else {
                // 실패 시: result=fail 파라미터를 붙여 리다이렉트
                resp.sendRedirect("userInfo.do?result=fail");
            }
		}
	}
}