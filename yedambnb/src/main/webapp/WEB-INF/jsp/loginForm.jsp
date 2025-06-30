
<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <style>
    @import url('https://fonts.googleapis.com/css2?family=Noto+Sans+KR&family=Montserrat:wght@600;700&display=swap');

    body {
      margin: 0;
      padding: 0;
      background-color: #f7f7f7;
      font-family: 'Noto Sans KR', sans-serif;
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
    }

    .login-box {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    .login-box h2 {
      text-align: center;
      margin-bottom: 24px;
      color: #222222;
      font-family: 'Montserrat', sans-serif;
      font-size: 24px;
      font-weight: 700;
    }

    .form-input {
      margin-bottom: 20px;
    }

    .form-input label {
      display: block;
      margin-bottom: 6px;
      color: #484848;
      font-size: 14px;
    }

    .form-input input[type="text"],
    .form-input input[type="password"] {
      width: 100%;
      padding: 12px 14px;
      border: 1px solid #cccccc;
      border-radius: 8px;
      font-size: 14px;
      box-sizing: border-box;
    }

    .submit-btn {
      width: 100%;
      padding: 14px;
      background-color: #ff385c;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 16px;
      cursor: pointer;
      margin-top: 12px;
    }

    .submit-btn:hover {
      background-color: #e41e4f;
    }

    .error-msg {
      color: red;
      font-size: 13px;
      margin-top: 8px;
      text-align: center;
    }
  </style>
</head>
<body>
  <div class="login-box">
    <h2>로그인</h2>
    <form action="login.do" method="post" autocomplete="off">
      <div class="form-input">
        <label>아이디</label>
        <input type="text" name="user_id" required minlength="4" maxlength="15">
      </div>
      <div class="form-input">
        <label>비밀번호</label>
        <input type="password" name="user_pw" required minlength="4" maxlength="15">
      </div>
      <button class="submit-btn" type="submit">로그인</button>
      <%-- 서버 메시지 표시 --%>
      <div class="error-msg">
        <c:if test="${not empty msg}">${msg}</c:if>
      </div>
    </form>
  </div>
</body>
</html>


