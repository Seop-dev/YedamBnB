package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.vo.UserVO;

public class LoginControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("user_id");
        String pw = req.getParameter("user_pw");
        String remember = req.getParameter("remember");

        UserService service = new UserServiceImpl();
        UserVO vo = service.login(id, pw);

        if (vo != null) {
            // 로그인 성공
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", vo);

            // 로그인 상태 유지
        
            resp.sendRedirect("main.do"); // 로그인 성공 후 이동
        } else {
            // 로그인 실패
            req.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            req.getRequestDispatcher("/user/loginForm.jsp").forward(req, resp);
        }
    }
}
