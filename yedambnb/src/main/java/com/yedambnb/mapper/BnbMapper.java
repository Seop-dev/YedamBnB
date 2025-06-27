package com.yedambnb.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param; // ★★★ 1. import 해주세요 ★★★

import com.yedambnb.common.Criteria;
import com.yedambnb.vo.BnbVO;

public interface BnbMapper {
	
	// ★★★ 2. 파라미터 앞에 @Param("별명")을 꼭 붙여주세요 ★★★
	List<BnbVO> searchBnbListPaging(@Param("cri") Criteria cri, @Param("keyword") String keyword);

	// getTotalCount 에도 일관성을 위해 추가해주는 것이 좋습니다.
	int getTotalCount(@Param("keyword") String keyword);
	
	List<BnbVO> selectListInBounds(Map<String, Double> bounds);
	
}