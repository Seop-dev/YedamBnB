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
import com.yedambnb.service.WishlistService;
import com.yedambnb.service.WishlistServiceImpl;

public class RemoveWishlistControl implements Control {

    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 자바스크립트에서 넘어온 wishlistId 파라미터를 받습니다.
        String wishlistIdStr = req.getParameter("wishlistId");

        WishlistService svc = new WishlistServiceImpl();
        
        Map<String, Object> resultMap = new HashMap<>();

        if (svc.removeWishlist(Integer.parseInt(wishlistIdStr))) {
            resultMap.put("retCode", "Success");
        } else {
            resultMap.put("retCode", "Fail");
        }

        Gson gson = new GsonBuilder().create();
        String json = gson.toJson(resultMap);

        // 결과(JSON 문자열)를 응답으로 보냅니다.
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().print(json);
    }
}