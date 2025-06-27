package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.LodgingListsMapper;
import com.yedambnb.vo.LodgingVO;

public class LodgingListServiceImpl implements LodgingListService {

	SqlSession sqlSession = DataSource.getInstance().openSession();
	LodgingListsMapper mapper = sqlSession.getMapper(LodgingListsMapper.class);
	
	@Override
	public List<LodgingVO> lodgingList(int lodgingNo) {
		return mapper.selectLodgingList(lodgingNo);
	}

	
}
