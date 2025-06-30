package com.yedambnb.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.Criteria;
import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.BnbMapper;
import com.yedambnb.vo.LodgingVO;

public class BnbServiceImpl implements BnbService {

	@Override
	public List<LodgingVO> searchBnbListPaging(Criteria cri, String keyword) {
		try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
			BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
			return mapper.searchBnbListPaging(cri, keyword);
		}
	}

	@Override
	public int getTotalCount(String keyword) {
		try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
			BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
			return mapper.getTotalCount(keyword);
		}
	}

	@Override
	public List<LodgingVO> getListInBoundsPaging(Criteria cri, Map<String, Double> bounds) {
		try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
			BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
			return mapper.getListInBoundsPaging(cri, bounds);
		}
	}

	@Override
	public int getCountInBounds(Map<String, Double> bounds) {
		try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
			BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
			return mapper.getCountInBounds(bounds);
		}
	}
	
	@Override
	public List<LodgingVO> searchBnbListAll(String keyword) {
		try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
			BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
			return mapper.searchBnbListAll(keyword);
		}
	}

	

	@Override
	public List<LodgingVO> getListInBounds(Map<String, Double> bounds) {
		// TODO Auto-generated method stub
		return null;
	}
}