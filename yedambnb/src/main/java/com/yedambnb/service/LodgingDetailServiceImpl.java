package com.yedambnb.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.LodgingDetailMapper;
import com.yedambnb.vo.LodgingVO;

public class LodgingDetailServiceImpl implements LodgingDetailService{

	SqlSession sqlSession = DataSource.getInstance().openSession();
	LodgingDetailMapper mapper = sqlSession.getMapper(LodgingDetailMapper.class);
	
	@Override
	public List<LodgingVO> lodgingDetail(int lodgingNo) {
		return mapper.selectLodging(lodgingNo);
	}

	
}
