package com.yedambnb.service;

import java.util.List;

import com.yedambnb.vo.BookingVO;
import com.yedambnb.vo.ReservationVO;

public interface BookingService {

   
    public List<BookingVO> getBookingsByUserId(String userId);
    public boolean cancelBooking(int bookingId);
    
    public boolean addReservation(ReservationVO rvo);

}