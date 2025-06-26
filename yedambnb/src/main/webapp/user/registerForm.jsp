<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>회원가입</title>
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

    .register-box {
      background-color: #ffffff;
      padding: 40px;
      border-radius: 12px;
      box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
      width: 400px;
    }

    .register-box h2 {
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
    .form-input input[type="password"],
    .form-input input[type="date"] {
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
    }

    .submit-btn:hover {
      background-color: #e41e4f;
    }

    .error-msg {
      color: red;
      font-size: 13px;
      display: none;
    }

    #preview {
      width: 100px;
      height: 100px;
      border-radius: 50%;
      display: block;
      margin-top: 10px;
    }
  </style>
</head>
<body>
  <div class="register-box">
    <h2>회원가입</h2>
    <form action="register.do" method="post" onsubmit="return validateForm()">
      <div class="form-input">
        <label>아이디</label>
        <input type="text" name="user_id" id="user_id" required minlength="5" maxlength="20">
        <button type="button" onclick="checkId()">중복체크</button>
        <div id="idError" class="error-msg">* 아이디는 필수입니다.</div>
      </div>

      <div class="form-input">
        <label>비밀번호</label>
        <input type="password" name="user_pw" id="user_pw" required minlength="5" maxlength="20">
      </div>

      <div class="form-input">
        <label>이름</label>
        <input type="text" name="user_name" required>
      </div>

      <div class="form-input">
        <label>생년월일</label>
        <input type="date" name="birth_date" required>
      </div>

      <div class="form-input">
        <label>전화번호</label>
        <input type="text" name="telephone" required maxlength="11">
      </div>

      <button class="submit-btn" type="submit">가입하기</button>
    </form>
  </div>

  <script>
    function checkId() {
      const userId = document.getElementById("user_id").value;
      if (!userId) {
        alert("아이디를 입력하세요.");
        return;
      }

      fetch("checkId.do?user_id=" + userId)
        .then(res => res.json())
        .then(data => {
          if (data.retCode == 'Exist') {
            alert("이미 사용 중인 아이디입니다.");
          } else {
            alert("사용 가능한 아이디입니다.");
          }	
        });
    }

    function validateForm() {
      const id = document.getElementById('user_id').value;
      const pw = document.getElementById('user_pw').value;

      if (!id) {
        document.getElementById('idError').style.display = 'block';
        return false;
      } else {
        document.getElementById('idError').style.display = 'none';
      }

      return true;
    }
  </script>
</body>
</html>
