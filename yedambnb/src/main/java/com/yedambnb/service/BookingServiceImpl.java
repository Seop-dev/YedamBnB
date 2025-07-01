package com.yedambnb.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.yedambnb.common.DataSource;
import com.yedambnb.mapper.BookingMapper;
import com.yedambnb.vo.BookingVO;
import com.yedambnb.vo.ReservationVO;

public class BookingServiceImpl implements BookingService {

    // DB 커넥션과 SQL 실행을 위한 세션 객체를 DataSource로부터 얻어옵니다.
    // openSession(true)는 자동 커밋(auto-commit)을 의미합니다.
	public SqlSession sqlSession = DataSource.getInstance().openSession(true);
    
    // sqlSession을 통해 BookingMapper 인터페이스의 구현체를 얻어옵니다.
    // 이 mapper 객체를 통해 XML에 정의된 SQL을 실행할 수 있습니다.
	public BookingMapper mapper = sqlSession.getMapper(BookingMapper.class);

    @Override
    public List<BookingVO> getBookingsByUserId(String userId) {
        // Controller로부터 받은 userId를 Mapper에게 그대로 전달하고
        // Mapper가 DB에서 조회한 결과를 Controller에게 그대로 반환합니다.
        return mapper.getBookingsByUserId(userId);
    }
    
    @Override
    public boolean cancelBooking(int bookingId) {
        // Mapper에 bookingId와 새로운 상태('CANCELED')를 함께 넘겨주기 위해 Map을 사용합니다.
        Map<String, Object> params = new HashMap<>();
        params.put("bookingId", bookingId);
        params.put("status", "CANCELED");
        
        // Mapper의 updateBookingStatus를 호출하고,
        // 성공적으로 1개의 행이 수정되었으면 true를, 아니면 false를 반환합니다.
        return mapper.updateBookingStatus(params) == 1;
    }

	@Override
	public boolean addReservation(ReservationVO rvo) {
		int r = mapper.insertReservation(rvo);
		if (r == 1) {
			return true;
		}
		return false;
	}

}