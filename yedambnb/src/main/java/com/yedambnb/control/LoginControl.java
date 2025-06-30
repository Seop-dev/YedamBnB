package com.yedambnb.control;

import java.io.IOException;
import javax.servlet.ServletException;
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

        // vo에 id/pw 세팅!
        UserVO param = new UserVO();
        param.setUserId(id);
        param.setUserPw(pw);

        UserService service = new UserServiceImpl();
        UserVO vo = service.login(param);

        // (디버깅) 실제 DB에서 받아온 값 콘솔 확인
        System.out.println("DB 조회 결과: " + vo);

        if (vo != null && id.equals(vo.getUserId()) && pw.equals(vo.getUserPw())) {
            HttpSession session = req.getSession();
            session.setAttribute("loginUser", vo);  // VO 전체 저장
            session.setAttribute("logId", id);      // (마이페이지 컨트롤러용)
            resp.sendRedirect("main.do");
        } else {
            req.setAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
            req.getRequestDispatcher("/WEB-INF/jsp/loginForm.jsp").forward(req, resp);
        }
    }
}
