package com.yedambnb.service;

import java.util.List;
import java.util.Map;
import com.yedambnb.common.Criteria;
import com.yedambnb.vo.LodgingVO;

public interface BnbService {
	List<LodgingVO> searchBnbListPaging(Criteria cri, String keyword);
	int getTotalCount(String keyword);
    List<LodgingVO> searchBnbListAll(String keyword);
	List<LodgingVO> getListInBounds(Map<String, Double> bounds);
	List<LodgingVO> getListInBoundsPaging(Criteria cri, Map<String, Double> bounds);
	int getCountInBounds(Map<String, Double> bounds);
}