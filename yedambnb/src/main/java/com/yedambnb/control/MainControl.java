package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;

public class MainControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // tiles.xml에 정의된 <definition name="main">을 찾아 페이지를 구성합니다.
        // 특별한 DB 조회가 필요 없으므로 바로 .tiles를 호출합니다.
        req.getRequestDispatcher("bnb/main.tiles").forward(req, resp);
    }

}