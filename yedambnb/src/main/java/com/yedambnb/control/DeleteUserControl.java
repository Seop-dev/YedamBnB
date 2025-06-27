package com.yedambnb.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;

public class DeleteUserControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 자바스크립트에서 넘어온 userNo 파라미터를 받습니다.
        String userNoStr = req.getParameter("userNo");

        UserService svc = new UserServiceImpl();
        
        Map<String, Object> resultMap = new HashMap<>();

        if (svc.removeUser(Integer.parseInt(userNoStr))) {
            // 회원정보 삭제 성공 시
            
            // 현재 로그인된 세션을 가져와서 무효화(로그아웃) 시킵니다.
            HttpSession session = req.getSession();
            session.invalidate();
            
            resultMap.put("retCode", "Success");
        } else {
            // 회원정보 삭제 실패 시
            resultMap.put("retCode", "Fail");
        }

        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(resultMap);

        // 결과(JSON 문자열)를 응답으로 보냅니다.
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().print(json);
    }
}