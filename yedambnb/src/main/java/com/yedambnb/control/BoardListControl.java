package com.yedambnb.control;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;

public class BoardListControl implements Control {
    @Override
    // 1. 반환 타입을 String에서 void로 변경합니다.
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // TODO: 실제 게시판 목록을 가져오는 Service 로직을 여기에 추가해야 합니다.
        
        // 2. return 대신 forward를 사용하고, boardList에 맞는 tiles 정의 이름을 호출합니다.
        req.getRequestDispatcher("boardList.tiles").forward(req, resp);
    }
}