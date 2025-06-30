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
import com.yedambnb.common.Criteria;
import com.yedambnb.common.PageDTO;
import com.yedambnb.service.BnbService;
import com.yedambnb.service.BnbServiceImpl;
import com.yedambnb.vo.LodgingVO;

public class GetListInBoundsControl implements Control {
    @Override
    public void exec(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            double swLat = Double.parseDouble(req.getParameter("swLat"));
            double swLng = Double.parseDouble(req.getParameter("swLng"));
            double neLat = Double.parseDouble(req.getParameter("neLat"));
            double neLng = Double.parseDouble(req.getParameter("neLng"));
            String pageNum = req.getParameter("pageNum");
            String sort = req.getParameter("sort");

            pageNum = (pageNum == null) ? "1" : pageNum;
            sort = (sort == null) ? "recent" : sort;
            
            Map<String, Double> bounds = new HashMap<>();
            bounds.put("swLat", swLat);
            bounds.put("swLng", swLng);
            bounds.put("neLat", neLat);
            bounds.put("neLng", neLng);
            
            Criteria cri = new Criteria(Integer.parseInt(pageNum), 9);
            cri.setSort(sort);
            
            BnbService service = new BnbServiceImpl();

            List<LodgingVO> fullListForMap = service.getListInBounds(bounds);
            List<LodgingVO> paginatedList = service.getListInBoundsPaging(cri, bounds);
            int total = service.getCountInBounds(bounds);
            
            PageDTO pageDTO = new PageDTO(cri, total);
            
            Map<String, Object> resultMap = new HashMap<>();
            resultMap.put("paginatedList", paginatedList);
            resultMap.put("fullListForMap", fullListForMap);
            resultMap.put("pageDTO", pageDTO);
            
            Gson gson = new Gson();
            String json = gson.toJson(resultMap);
            
            resp.setContentType("application/json; charset=utf-8");
            resp.getWriter().print(json);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}