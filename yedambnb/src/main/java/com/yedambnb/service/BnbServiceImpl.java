package com.yedambnb.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.Criteria;
import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.BnbMapper;
import com.yedambnb.vo.BnbVO;

// ... imports ...
public class BnbServiceImpl implements BnbService {
	@Override
	public List<BnbVO> searchBnbListPaging(Criteria cri, String keyword) {
	    try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
	        BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);

	        // ★★★ 디버깅 코드 시작 ★★★
	        System.out.println(">>> Service: Mapper를 통해 DB에서 데이터를 가져옵니다...");
	        List<BnbVO> list = mapper.searchBnbListPaging(cri, keyword);
	        System.out.println(">>> Service: 가져온 목록의 크기: " + (list != null ? list.size() : "null"));

	        if (list != null && !list.isEmpty()) {
	            // 목록의 첫 번째 항목만 꺼내서 좌표 값을 직접 출력해봅니다.
	            BnbVO firstItem = list.get(0);
	            System.out.println(">>> Service: 첫 번째 숙소 이름: " + firstItem.getLodgingName());
	            System.out.println(">>> Service: 첫 번째 숙소 위도(latitude): " + firstItem.getLatitude());
	            System.out.println(">>> Service: 첫 번째 숙소 경도(longitude): " + firstItem.getLongitude());
	        }
	        System.out.println("------------------------------------");
	        // ★★★ 디버깅 코드 종료 ★★★

	        return list;
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
    public List<BnbVO> getListInBounds(Map<String, Double> bounds) {
        try (SqlSession sqlSession = DataSource.getInstance().openSession(true)) {
            BnbMapper mapper = sqlSession.getMapper(BnbMapper.class);
            return mapper.selectListInBounds(bounds);
        }
    }
}