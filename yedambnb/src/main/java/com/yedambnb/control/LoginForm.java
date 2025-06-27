package com.yedambnb.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.yedambnb.common.Control;

public class LoginForm implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // "user/loginForm.tiles" (X) -> admin 스타일의 'user' 레이아웃을 사용함
        // "bnb/loginForm.tiles" (O) -> YedamBNB 테마의 'bnb' 레이아웃을 사용함
        
        req.getRequestDispatcher("bnb/loginForm.tiles").forward(req, resp);
    }
}