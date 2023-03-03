<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>메인페이지 테스트</title>
    
      <style>
  * 
  /*css*/
  /* links = 우측상단 로그인/회원가입 */
  /* nav_items = 중앙 링크*/
  /* search_box = 검색창*/
  /* img 좌우측 상단 이미지*/
  
  { 
     box-sizing: border-box; /* 길이 계산을 편하게 하기위함. */
  }
  body {
    margin: 0; /* body의 기본마진을 없애줍니다(선택사항) */
    font-family: sans-serif;
  }
  a {
    text-decoration: none; /* 기본 밑줄을 제거합니다 */
    color: #0392cf;
  }
  a:hover {
    text-decoration: underline; /* 마우스 커서가 올라갔을 때 밑줄을 생성합니다(로그인관련 링크)*/
  }
  header {
    margin: auto; /* header의 양쪽 여백(margin)을 동등하게 맞춤 -> 수평가운데정렬 */
    width: 1080px;
    height: 215px;
    display: flex;
    align-items: center; /* 하위 요소들 수직 가운데정렬 */
    position: relative;
  }
  fieldset {
    border: none; /* 기본 border 없애기 */
  }
  .visually-hidden { /* legend 안보이게 설정. 이렇게하면 접근성을 준수하면서 디자인을 해치지 않습니다. */
    position: absolute !important;
    height: 1px;
    width: 1px;
    overflow: hidden;
    clip: rect(1px 1px 1px 1px);
    clip: rect(1px, 1px, 1px, 1px);
    white-space: nowrap;
  }
  .links { /* 링크들(회원가입/로그인)을 상단 우측에 위치시킵니다. */
    position: absolute;
    top: 0;
    right: 0;
  }

  .link_text {
    font-size: 10px;
    margin-left: 5px;
  }
  .img_logo {
    margin-bottom: 12px;
    width: 220px;
    height: 65px;
    position: absolute;
    left:0px;
    top: 80px;
  }

  .search_box {
    width: 520px;
    height: 50px;
    border: 2px solid #0325cf;
    display: flex;
    position:absolute;
    margin:auto;
    left: 50%;
    transform:translate(-50%, -50%); 
    align-items: center;
  }
  .search_box input {
    flex: 9; /* search-box내부에서 9만큼의 크기를 차지(비율) */
    height: 46px;
    padding-left: 12px;
    padding-right: 12px;
    border: none;
    outline: none;
    font-size: 18px;
  }
  .search_box button {
    flex: 1; /* search-box내부에서 1만큼의 크기를 차지(비율) */
    height: 46px;
    margin: 0;
    padding: 0;
    border: none;
    outline: none;
    background: #0325cf;
    color: #ffffff;
  }
    .img_logo2{
 	margin-bottom: 12px;
    width: 180px;
    height: 65px; 
    position: absolute;
    right:0px;
    top: 85px;
  }
  /* nav */
  header > nav {
    width: 100%;
    height: 45px;
    position: absolute;
    bottom: 0;
  }
  .nav_items {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 15px;
    font-weight: bold;
    border-top: 1px solid #0392cf;
  }
  .nav_items ul > li {
    display: inline-block;
    margin-left: 20px;
  }

  .nav_items ul > li > a {
    text-decoration: none;
    cursor: pointer;
  }
  main{
	margin: auto; /* header의 양쪽 여백(margin)을 동등하게 맞춤 -> 수평가운데정렬 */
    width: 1020px;
    height: 515x;
    display: flex;
    align-items: center; /* 하위 요소들 수직 가운데정렬 */
    position: relative;
  }
  .slideshow-container{
  	margin: auto;
    width: 1020px;
    height: 515px;
    overflow: hidden;
  }
  
  .prev, .next {
    position: absolute;
    top: 50%;
    font-size: 20px;
    font-weight: bold;
    padding: 16px;
    margin-top: -22px;
    color: white;
    background-color: black;
    cursor: pointer;
    text-decoration: none;
  }
  .next {
    right: 0;
  }

  
  footer {
    background: white;
    margin: auto;
    width: 1080px;
    height: 75px;
  }
  /* 재사용 클래스 */
  .color_navitem {
    color: #0392cf;
  }

</style>

<!-- 슬라이드쇼 함수 -->
<script>
  var slideIndex = 1;
  showSlides(slideIndex);
  
  setInterval(function() {plusSlides(1)},5000);
  
  function plusSlides(n) {
    showSlides(slideIndex += n);
  }
  
  function showSlides(n) {
    var i;
    var slides = document.getElementsByClassName("mySlides");
    var dots = document.getElementsByClassName("dot");
    if (n > slides.length) {slideIndex = 1}
    if (n < 1) {slideIndex = slides.length}
    for (i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    for (i=0;i<dots.length;i++){
    	dots[i].className = dots[i].className.replace("active","");
    }
    slides[slideIndex-1].style.display = "block";
    dots[slideIndex-1].className+="active";
  }
</script>
  </head>
  <body>
  
  <header>
  
  <!--html-->
  
  <!--
  TODO : 회원가입/로그인 페이지 링크걸기
  -->
    <div class="links">
    
	       <!-- 로그인 인증 되었을때 -->
	    <c:if test="${not empty MEMBER_SES.member_id}">
	         <span class="link_text">${MEMBER_SES.member_id}님 안녕하세요</span>
	        <a href="${rootPath}/member/logout.do" class="link_text">로그아웃</a>
	     </c:if>
	     
			<!-- 로그아웃했을때 -->
		<c:if test="${not empty logout_msg}">
			<script>
				alert("${logout_msg}")
			</script>
		</c:if>
			    
	         <!-- 로그인 인증 되지 않았을때 -->
	     <c:if test="${empty MEMBER_SES.member_id}">
	        <a href="/" class="link_text">회원가입</a>
	        <a href="${rootPath}/jsp/Login.jsp" class="link_text">로그인</a>
	     </c:if>
     </div>
  <!--
  TODO : 이미지 링크걸기
  -->
    <a href="${rootPath}/jsp/MainPage.jsp"><img src="${rootPath}/png/logof.png" class="img_logo"/></a>
    
    <form>
      <fieldset>
        <legend class="visually-hidden">검색</legend>
        <div class="search_box">
          <input type="text" maxlength="225" tabindex="1" />
          <button type="submit" tabindex="2">
            검색
          </button>
        </div>
      </fieldset>
    </form>
    
    <a><img src="${rootPath}/png/logoff2.png" class="img_logo2"/></a>
    
    
    
    <nav>
      <div class="nav_items">
        <ul>
  <!--
  TODO : 각 항목 링크 걸기
  1 : 상품 카테고리 A
  2 : 상품 카테고리 B
  3 : 상품 카테고리 C
  4 : 회원정보
  5 : 게시판
  6 : Q&A
  -->
      	  <li><a href="/">상품 카테고리 A</a></li>
          <li><a href="/">상품 카테고리 B</a></li>
          <li><a href="/">상품 카테고리 C</a></li>
          <li><a href="${rootPath}/jsp/Memberinfo.jsp">회원정보</a></li>
          <li><a href="/">게시판</a></li>
          <li><a href="/">Q&A</a></li>
        </ul>

      </div>
    </nav>
  </header>
  <!-- TODO 
  메인 레이아웃에 이미지슬라이드삽입(이미지링크도 넣을지 확인)-->
  
  <main>
  
<div class="slideshow-container" >
  <img class="mySlides" src="${rootPath}/png/slider001.png" style="width:100%; height:100%;">
  <img class="mySlides" src="${rootPath}/png/hollys001.png" style="width:100%; height:100%;">
  <img class="mySlides" src="${rootPath}/png/slider003.png" style="width:100%; height:100%;">
  <a class="prev" onclick="plusSlides(-1)" style="left: 0;">&#10094;</a>
  <a class="next" onclick="plusSlides(1)" style="right: 0;">&#10095;</a>
</div>
  </main>
    <!-- TODO 
  하단 구현 어떻게 할지-->
  <footer>
  <div>
  <br>FourTeam
  <br>대표이사:000, 주소:000, Tel: 0000-0000
  <br>사업자등록번호: 000-00-00000, 통신판매업신고: 000-서울0구-0000
  </div>

	</footer>
  </body>
</html>