package com.yedambnb.control;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.vo.UserVO;

public class RegisterControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("utf-8");

        String userId = req.getParameter("user_id");
        String userPw = req.getParameter("user_pw");
        String userName = req.getParameter("user_name");
        String birthDate = req.getParameter("birth_date");
        String telephone = req.getParameter("telephone");
        
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Date birthDateObj = null;
        try {
            birthDateObj = sdf.parse(birthDate); // String → Date
        } catch (ParseException e) {
            e.printStackTrace();
        }

        UserVO vo = new UserVO();
        vo.setUserId(userId);
        vo.setUserPw(userPw);
        vo.setUserName(userName);
        vo.setTelephone(telephone);
        vo.setBirthDate(birthDateObj); 
        vo.setUserAuthority("user"); // 기본 권한

        // 3. 생년월일 처리
        try {
            if (birthDate != null && !birthDate.isEmpty()) {
                //vo.set(new SimpleDateFormat("yyyy-MM-dd").parse(birthDate));
            	//vo.setBirthDate(birthDateStr);

            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // 4. 회원가입 처리
        UserService service = new UserServiceImpl();
        boolean result = service.registerUser(vo);

        // 5. 결과 처리
        if (result) {
            req.setAttribute("msg", "회원가입 성공!");
            req.getRequestDispatcher("/WEB-INF/jsp/registerSuccess.jsp").forward(req, resp);
        } else {
            req.setAttribute("msg", "회원가입 실패..");
            req.getRequestDispatcher("/WEB-INF/jsp/registerForm.jsp").forward(req, resp);
        }
    }
}
