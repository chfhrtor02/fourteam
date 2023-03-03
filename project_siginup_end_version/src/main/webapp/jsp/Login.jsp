<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Login</title>
   		<form>
   		<div>
    		<a href="${rootPath}/jsp/MainPage.jsp"><img class="img_logo" src="${rootPath}/png/logof.png" style="width:100%; height:100%;"></a>
    	</div>
    	</form>
    <style>

/* form-control label 요소 가져오기 */
/* const labels = document.querySelectorAll(".form-control label");

labels.forEach((label) => {
  label.innerHTML = label.innerText
    .split("")
    .map((letter, idx) =>`<span>${letter}</span>`)
    .join("");
}); */

* {
  box-sizing: border-box;
}

body{
  
  /* 화면 바디 */
  /* background-color: #D5C2EE; */
  color: #fff;
  font-family: 'Arial', sans-serif;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  overflow: hidden;
  margin: 0;
}

.container { /* 로그인 박스 전체 */
  background-color: rgba(0, 0, 0, 0.4); /* 투명도 조절 가능 1에 가까울 수록 불투명 */
  padding: 80px 60px;
  border-radius: 5px;
}

.container a { /* 회원가입 */
  text-decoration: none;
  color: #EBFBFF;
  /* 언더라인에 간격 좀 있게 넣음 */
  text-decoration:underline; text-underline-position:under;
}

.btn { /* 로그인 버튼 */
  cursor: pointer;
  display: inline-block;
  width: 100%;
  background: #5ABEFF;
  padding: 15px;
  font-family: inherit;
  font-size: 16px;
  border: 0;
  border-radius: 5px;
}
 
.text {
  margin-top: 30px;
}

.form-control { /* 아이디,비밀번호 간격 */
  position: relative;
  margin: 20px 0 40px;
  width: 300px;  
}
 
.form-control input { /* 아이디,비밀번호 박스폼 */
  background-color: transparent;
  border: 0;
  border-bottom: 2px #fff solid;
  display: block;
  width: 100%;
  padding: 15px 0;
  font-size: 18px;
  color: #fff;
} 

/* 기존) label => 내부 라벨(placeholder) */
.form-control input::placeholder {
	color:#fff;
}

/* 클릭시 아웃테두리 없애고,언더라인 색상 변경 */
.form-control input:focus,
.form-control input:valid {
  outline: 0;
  border-bottom-color: lightblue;
}

/* .form-control label {
  position: absolute;
  top: 15px;
  left: 0;
  pointer-events: none;
} */
/* 입력 창에 입력을 하면 입력창 위에 라벨을 보여주고, 그 라벨의 스타일을 변경 */
/* .form-control input:focus + label span,
.form-control input:valid + label span {
  color: lightblue;
  transform: translateY(-30px);
} */

/* 로고 이미지 */
.img_logo {
  margin-bottom: 12px;
  width: 20%;
  height: 65px;
  margin-left: auto;
  margin-right: auto;
}

</style>
    
</head>
<body>
    
	<div class="container">
		<form name="login" action="${rootPath}/member/login.do" method = "post">
	 		
	 		<div class="form-control">
	 			<!-- <label>아이디</label> -->
          		<input type="text" name="member_id" placeholder="아이디"/>
     		</div>
     
     		<div class="form-control">
          		<input type="password" name="member_pwd" placeholder="비밀번호"/>
         		<!-- <label>비밀번호</label> -->
    		</div>
   			
     		<button type="submit" class="btn" value="login">로그인</button>

    		<p class="text">아직 회원이 아니신가요? <a href="#">회원가입</a></p>
    		
    	</form>
    </div>
    
  	<!-- 로그인 메세지 -->
  	<c:if test="${not empty login_error_msg}">  
		<script>
			alert("${login_error_msg}")
		</script>
	</c:if>

</body>
</html>