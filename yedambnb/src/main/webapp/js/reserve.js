/**
 * 
 */

 document.querySelector('.btn').addEventListener('click', function(e) {
 e.preventDefault();
 const checkInDate = document.getElementById("checkIn").value;
 const checkOutDate = document.getElementById("checkOut").value;
 const lodgingNo = document.querySelector("#lodgingNo").value;
 const totalPrice = document.querySelector('#pricePerNight').textContent;
 const memCount = document.querySelector('#guests').value;
 
 
 const url = 'addBooking.do?lodging_no='+lodgingNo+ '&check_in_date='+checkInDate+'&check_out_date='+checkOutDate + '&memberCount=' +memCount+ '&totalPrice=' + totalPrice;
  
  
  console.log("url 은 : " + url);
  console.log("lodgingNo: " , lodgingNo);
  console.log("checkInDate: ", checkInDate);
  console.log("checkOutDate: ", checkOutDate);
  console.log(memCount);
  console.log(totalPrice);
  
  
  fetch(url)
    .then(result => result.json())
    .then(data => {
      if(data.retCode == "Success") {
        alert("예약이 완료되었습니다.");
      } else {
        alert("예약을 취소했습니다");
      }
    });
});