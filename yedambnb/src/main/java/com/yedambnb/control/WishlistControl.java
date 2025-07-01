package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.service.WishlistService;
import com.yedambnb.service.WishlistServiceImpl;
import com.yedambnb.vo.UserVO;
import com.yedambnb.vo.WishlistVO;

public class WishlistControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        
        String userId = (String) session.getAttribute("logId");
        
        if (userId == null) {
            resp.sendRedirect("loginForm.do");
            return;
        }
        
        // [수정] userId(String)를 userNo(int)로 변환하는 과정 추가
        // 1. UserService를 통해 사용자 정보를 가져옵니다.
        UserService userSvc = new UserServiceImpl();
        UserVO user = userSvc.getUser(userId); // 이 메소드는 userId(String)로 UserVO를 반환해야 함

        if (user == null) {
            // 혹시 모를 예외 처리: 세션은 있는데 DB에 사용자가 없는 경우
            System.out.println("세션 ID에 해당하는 사용자가 없습니다. " + userId);
            resp.sendRedirect("loginForm.do");
            return;
        }
        
        // 2. 가져온 사용자 정보에서 userNo(int)를 얻습니다.
        int userNo = user.getUserNo();
        
        // 3. 로그인된 사용자의 userNo로 위시리스트를 조회합니다.
        WishlistService wishlistSvc = new WishlistServiceImpl();
        List<WishlistVO> list = wishlistSvc.getWishlist(userNo);
        
        // 4. 조회된 데이터를 JSP로 전달하기 위해 request에 저장합니다.
        req.setAttribute("wishlist", list);
        
        // 5. 위시리스트 페이지로 포워딩합니다.
        req.getRequestDispatcher("user/wishlist.tiles").forward(req, resp);
    }
}
