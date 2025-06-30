package com.yedambnb.control;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.yedambnb.common.Control;
import com.yedambnb.service.UserService;        // [추가] UserService를 사용하기 위해 import
import com.yedambnb.service.UserServiceImpl;    // [추가]
import com.yedambnb.service.WishlistService;
import com.yedambnb.service.WishlistServiceImpl;
import com.yedambnb.vo.UserVO;                    // [추가] UserVO를 사용하기 위해 import
import com.yedambnb.vo.WishlistVO;

public class WishlistControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        String userId = (String) session.getAttribute("logId");
        if (userId == null) {
            userId = "user1"; // 임시 테스트용 ID
        }
        
        // [수정] String userId를 int userNo로 변환하는 과정을 추가합니다.
        // 1. UserService를 통해 사용자 정보를 가져옵니다.
        UserService userSvc = new UserServiceImpl();
        UserVO user = userSvc.getUser(userId);
        
        // 2. 가져온 사용자 정보에서 userNo를 추출합니다.
        int userNo = user.getUserNo();

        // 3. WishlistService에는 이제 String이 아닌 int 타입의 userNo를 전달합니다.
        WishlistService wishSvc = new WishlistServiceImpl();
        List<WishlistVO> list = wishSvc.getWishlist(userNo);

        // 조회된 결과를 JSP에서 사용할 수 있도록 request 객체에 저장합니다.
        req.setAttribute("wishlist", list);

        // 위시리스트를 보여줄 JSP 페이지로 이동하도록 Tiles에 요청합니다.
        req.getRequestDispatcher("user/wishlist.tiles").forward(req, resp);
    }
}