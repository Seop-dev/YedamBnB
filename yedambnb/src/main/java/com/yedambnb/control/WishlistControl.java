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
        // 1. 현재 로그인한 사용자의 userNo를 가져옵니다. (지금은 임시 방식)
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("logId");
        if (userId == null) {
            userId = "user1"; // 임시 테스트용 ID
        }
        
        UserService userSvc = new UserServiceImpl();
        UserVO user = userSvc.getUser(userId);
        int userNo = user.getUserNo();

        // 2. WishlistService를 통해 해당 사용자의 위시리스트 목록을 조회합니다.
        WishlistService wishSvc = new WishlistServiceImpl();
        List<WishlistVO> list = wishSvc.getWishlist(userNo);

        // 3. 조회된 결과를 JSP에서 사용할 수 있도록 request 객체에 저장합니다.
        req.setAttribute("wishlist", list);

        // 4. 위시리스트를 보여줄 JSP 페이지로 이동하도록 Tiles에 요청합니다.
        req.getRequestDispatcher("user/wishlist.tiles").forward(req, resp);
    }
}