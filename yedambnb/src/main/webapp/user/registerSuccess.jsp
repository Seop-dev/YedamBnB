<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>가입 완료</title>
  <style>
    body {
      font-family: 'Noto Sans KR', sans-serif;
      background-color: #f9f9f9;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
    }

    .complete-box {
      text-align: center;
      background-color: #fff;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
    }

    .complete-box h2 {
      font-size: 28px;
      color: #2c3e50;
      margin-bottom: 16px;
    }

    .complete-box p {
      font-size: 20px;
      margin-bottom: 24px;
      color: #444;
    }

    .complete-box a {
      font-size: 18px;
      color: #6a1b9a;
      text-decoration: none;
    }

    .complete-box a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
  <div class="complete-box">
    <h2>🎉 회원가입이 완료되었습니다 🎉</h2>
    <a href="/yedambnb/main.do">홈으로</a>
  </div>
</body>
</html>