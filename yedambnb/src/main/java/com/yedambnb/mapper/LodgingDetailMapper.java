package com.yedambnb.mapper;

import java.util.List;

import com.yedambnb.vo.LodgingVO;

public interface LodgingDetailMapper {

	public List<LodgingVO> selectLodging(int lodgingNo);
	
}
