package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;

public class LoginFormControl implements Control {

	@Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/WEB-INF/jsp/loginForm.jsp").forward(req, resp);
    }

}
