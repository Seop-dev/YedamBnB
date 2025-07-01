package com.yedambnb.vo;

import lombok.Data;

@Data
public class ReservationVO {
  private String userId;
  private int totalPrice;
  private int memberCount;
  private String checkInDate;
  private String checkOutDate;
  private int lodgingNo;
}
