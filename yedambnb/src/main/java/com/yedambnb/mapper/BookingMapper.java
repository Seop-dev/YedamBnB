package com.yedambnb.mapper;

import java.util.List;
import java.util.Map;

import com.yedambnb.vo.BookingVO;
import com.yedambnb.vo.ReservationVO;
/**
 * 예약(Booking) 관련 데이터베이스 작업을 위한 Mapper 인터페이스
 */
public interface BookingMapper {
 
    public List<BookingVO> getBookingsByUserId(String userId);
    public int updateBookingStatus(Map<String, Object> params);
    public int insertReservation(ReservationVO rvo);
}