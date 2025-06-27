package com.yedambnb.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.yedambnb.common.Control;
import com.yedambnb.service.MPReviewService;
import com.yedambnb.service.MPReviewServiceImpl;
import com.yedambnb.service.UserService;
import com.yedambnb.service.UserServiceImpl;
import com.yedambnb.vo.MPReviewVO;
import com.yedambnb.vo.UserVO;

public class AddReviewControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
        // [수정] bookingId 대신 lodgingId와 userId를 받습니다.
        String lodgingId = req.getParameter("lodgingId");
        String userId = req.getParameter("userId");
        String score = req.getParameter("score");
        String content = req.getParameter("content");

        // 리뷰를 작성하는 사용자의 user_name을 알아내기 위해, DB에서 사용자 정보를 가져옵니다.
        UserService userSvc = new UserServiceImpl();
        UserVO user = userSvc.getUser(userId);

        // [수정] 새로운 MPReviewVO의 필드에 맞춰 값을 설정합니다.
        MPReviewVO reviewVO = new MPReviewVO();
        reviewVO.setLodgingNo(Integer.parseInt(lodgingId)); // tbl_review는 lodging_no를 사용
        reviewVO.setUserId(userId);

        if (user != null) {
            reviewVO.setUserName(user.getUserName());
        }
        
        reviewVO.setScore(Integer.parseInt(score));
        reviewVO.setCommentText(content);

        MPReviewService reviewSvc = new MPReviewServiceImpl();
        
        Map<String, Object> resultMap = new HashMap<>();

        if (reviewSvc.addReview(reviewVO)) {
            resultMap.put("retCode", "Success");
        } else {
            resultMap.put("retCode", "Fail");
        }
        
        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(resultMap);

        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().print(json);
    }
}