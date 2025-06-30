package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;

public class LogoutControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false); // 기존 세션 가져오기
        if (session != null) {
            session.invalidate(); // 세션 종료  ///h
        }

        // 로그인 상태 유지 쿠키 제거
        //Cookie cookie = new Cookie("rememberId", null);
        //cookie.setMaxAge(0); // 즉시 삭제
        //resp.addCookie(cookie);

        // 메인페이지로 리다이렉트 (필요시 수정 가능)
        resp.sendRedirect("main.do");
    }
}
