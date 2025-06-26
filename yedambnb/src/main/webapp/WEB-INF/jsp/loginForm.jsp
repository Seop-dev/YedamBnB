<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <style>
    .modal {
      display: block;
      position: fixed;
      top: 20%;
      left: 50%;
      transform: translateX(-50%);
      background: #fff;
      padding: 30px;
      border-radius: 10px;
      box-shadow: 0 0 10px rgba(0,0,0,0.3);
      width: 350px;
    }
    .modal input { width: 100%; padding: 8px; margin-bottom: 10px; }
    .modal button { width: 100%; padding: 10px; }
    .error { color: red; font-size: 0.9em; }
  </style>
</head>
<body>

  <div class="modal">
    <form action="login.do" method="post" id="loginForm">
      <label>아이디
        <input type="text" name="user_id" id="user_id" maxlength="50" required>
        <span class="error" id="idMsg"></span>
      </label>
      <label>비밀번호
        <input type="password" name="user_pw" id="user_pw" maxlength="20" required>
        <span class="error" id="pwMsg"></span>
      </label>
      <input type="submit" value="로그인">
    </form>

    <!-- 서버에서 에러 메시지 전송 시 표시 -->
    <c:if test="${not empty msg}">
      <p class="error">${msg}</p>
    </c:if>
  </div>

  <script>
  

    document.getElementById("loginForm").addEventListener("submit", function(e) {
      const id = document.getElementById("user_id").value;
      const pw = document.getElementById("user_pw").value;


      if (pw.length < 4 || pw.length > 20) {
        document.getElementById("pwMsg").innerText = "비밀번호는 4~20자 사이여야 합니다.";
        e.preventDefault();
      }
    });
  </script>

</body>
</html>
