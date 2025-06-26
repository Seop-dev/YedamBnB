package com.yedambnb.common;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.control.CheckIdControl;
import com.yedambnb.control.LoginControl;
import com.yedambnb.control.LoginFormControl;
import com.yedambnb.control.LogoutControl;
import com.yedambnb.control.MainControl;
import com.yedambnb.control.RegisterControl;
import com.yedambnb.control.RegisterFormControl;

public class FrontController extends HttpServlet {
    Map<String, Control> map;

    @Override
    public void init(ServletConfig config) throws ServletException {
        map = new HashMap<>();

        // 매핑
        map.put("/registerForm.do", new RegisterFormControl()); // 폼 화면
        map.put("/register.do", new RegisterControl());         // 가입 처리
        map.put("/loginForm.do", new LoginFormControl());  // 로그인 화면
        map.put("/logout.do", new LogoutControl());  // 로그아웃
        map.put("/checkId.do", new CheckIdControl());   // id중복체크
        map.put("/login.do", new LoginControl());  // 로그인페이지
        



    }

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String uri = req.getRequestURI();
        String context = req.getContextPath();
        String path = uri.substring(context.length());

        Control control = map.get(path);
        if (control != null) {
            control.exec(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "요청한 페이지를 찾을 수 없습니다.");
        }
    }
}
