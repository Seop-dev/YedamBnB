package com.yedambnb.control;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.vo.UserVO;

public class CheckIdControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String userId = req.getParameter("user_id");

        System.out.println("userid받은값 :" + userId);
        UserService svc = new UserServiceImpl();
        UserVO vo = svc.isUserIdAvailable(userId);
        System.out.println("vo의 userid받은값 :" + vo);
        if (vo != null) {
            resp.getWriter().print("{\"retCode\":\"Exist\"}");
        } else {
            resp.getWriter().print("{\"retCode\":\"NotExist\"}");
        }
    }
}



		// isExist ? 
    
    
//  
//  if(isExist.equals(userId)) {
//    
//  }
//  // JSON 형식으로 응답
//  resp.setContentType("application/json;charset=utf-8");
//  String result = isExist ? "{\"retCode\": \"NG\"}" : "{\"retCode\": \"OK\"}";
//  resp.getWriter().print(result);
//}