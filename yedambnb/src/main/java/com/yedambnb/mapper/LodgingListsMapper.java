package com.yedambnb.mapper;

import java.util.List;

import com.yedambnb.vo.LodgingVO;

public interface LodgingListsMapper {

	public List<LodgingVO> selectLodgingList(int lodgingNo);
}
