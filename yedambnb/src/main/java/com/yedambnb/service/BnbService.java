package com.yedambnb.service;

import java.util.List;
import java.util.Map;

import com.yedambnb.common.Criteria;
import com.yedambnb.vo.BnbVO;

// ... imports ...
public interface BnbService {
	List<BnbVO> searchBnbListPaging(Criteria cri, String keyword);
	int getTotalCount(String keyword);
	 List<BnbVO> getListInBounds(Map<String, Double> bounds);
}