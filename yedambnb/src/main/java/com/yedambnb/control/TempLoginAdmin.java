// 관리자 테스트용
package com.yedambnb.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.yedambnb.common.Control;

// DB 체크 없이 세션만 만들어주는 테스트용 컨트롤러
public class TempLoginAdmin implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        // "admin" 계정으로 로그인한 것처럼 세션 정보를 강제로 생성
        session.setAttribute("logid", "admin");
        session.setAttribute("logName", "관리자 (테스트)");
        session.setAttribute("logRole", "A"); // 관리자
        
        resp.sendRedirect("main.do");
    }
}