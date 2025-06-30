package com.yedambnb.control;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
// ... imports ...
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;

public class Logout implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.invalidate(); // 세션 삭제
        }
        resp.sendRedirect("main.do");
    }
}