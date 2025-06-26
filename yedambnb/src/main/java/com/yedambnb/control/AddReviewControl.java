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
        
        String accommodationId = req.getParameter("accommodationId");
        String userId = req.getParameter("userId");
        String score = req.getParameter("score");
        String content = req.getParameter("content");

        // --- [수정] 이 부분이 추가/변경됩니다 ---
        // 1. 리뷰를 작성하는 사용자의 user_no와 user_name을 알아내기 위해, 먼저 DB에서 사용자 정보를 가져옵니다.
        UserService userSvc = new UserServiceImpl();
        UserVO userVO = userSvc.getUser(userId);

        // 2. 이제 MPReviewVO에 정확한 값들을 설정합니다.
        MPReviewVO reviewVO = new MPReviewVO();
        reviewVO.setAccommodationId(Integer.parseInt(accommodationId));
        reviewVO.setScore(Integer.parseInt(score));
        reviewVO.setCommentText(content);
        reviewVO.setUserNo(userVO.getUserNo());     // 가져온 사용자 정보에서 userNo를 설정
        reviewVO.setUserName(userVO.getUserName()); // 가져온 사용자 정보에서 userName을 설정
        // ------------------------------------

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