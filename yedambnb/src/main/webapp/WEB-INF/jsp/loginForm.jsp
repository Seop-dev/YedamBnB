<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="section" style="margin-top: 100px; margin-bottom: 100px;">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-lg-5">
                <h2 class="font-weight-bold text-primary heading mb-5">로그인</h2>
                
                <%-- 이 폼의 action="login.do"는 다른 팀원분이 구현하실 부분입니다. --%>
                <form action="login.do" method="post">
                    <div class="mb-3">
                        <label for="userId" class="form-label">아이디</label>
                        <input type="text" class="form-control" id="userId" name="userId" required>
                    </div>
                    <div class="mb-3">
                        <label for="userPw" class="form-label">비밀번호</label>
                        <input type="password" class="form-control" id="userPw" name="userPw" required>
                    </div>
                    <button type="submit" class="btn btn-primary">로그인</button>
                </form>
            </div>
        </div>
    </div>
</div>