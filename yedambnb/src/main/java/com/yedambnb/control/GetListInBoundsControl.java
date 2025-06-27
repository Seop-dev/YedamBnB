package com.yedambnb.control;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.yedambnb.common.Control;
import com.yedambnb.service.BnbService;
import com.yedambnb.service.BnbServiceImpl;
import com.yedambnb.vo.BnbVO;

public class GetListInBoundsControl implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // try-catch 구문으로 감싸서 안정성 강화
        try {
            double swLat = Double.parseDouble(req.getParameter("swLat"));
            double swLng = Double.parseDouble(req.getParameter("swLng"));
            double neLat = Double.parseDouble(req.getParameter("neLat"));
            double neLng = Double.parseDouble(req.getParameter("neLng"));

            Map<String, Double> bounds = new HashMap<>();
            bounds.put("swLat", swLat);
            bounds.put("swLng", swLng);
            bounds.put("neLat", neLat);
            bounds.put("neLng", neLng);
            
            BnbService service = new BnbServiceImpl();
            List<BnbVO> list = service.getListInBounds(bounds);
            
            Gson gson = new Gson();
            String json = gson.toJson(list);
            
            resp.setContentType("application/json; charset=utf-8");
            resp.getWriter().print(json);

        } catch (NumberFormatException e) {
            // 숫자로 변환할 수 없는 파라미터(예: "NaN")가 들어올 경우
            System.err.println("잘못된 좌표 파라미터가 들어왔습니다: " + req.getQueryString());
            // 400 Bad Request 에러(클라이언트의 잘못된 요청)를 응답으로 보냄
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid coordinate parameters.");
        } catch (Exception e) {
            // 그 외 다른 모든 예외 처리
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}