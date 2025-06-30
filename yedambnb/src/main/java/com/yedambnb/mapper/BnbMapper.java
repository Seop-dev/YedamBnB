package com.yedambnb.mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.Param;
import com.yedambnb.common.Criteria;
import com.yedambnb.vo.LodgingVO;

public interface BnbMapper {
	List<LodgingVO> searchBnbListPaging(@Param("cri") Criteria cri, @Param("keyword") String keyword);
	int getTotalCount(@Param("keyword") String keyword);
	List<LodgingVO> searchBnbListAll(String keyword);
	List<LodgingVO> getListInBounds(Map<String, Double> bounds);
	List<LodgingVO> getListInBoundsPaging(@Param("cri") Criteria cri, @Param("bounds") Map<String, Double> bounds);
	int getCountInBounds(@Param("bounds") Map<String, Double> bounds);
}