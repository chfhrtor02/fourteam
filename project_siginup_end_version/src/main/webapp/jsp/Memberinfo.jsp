<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>

<style>
  
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
  }

  .search_box {
    width: 520px;
    height: 50px;
    border: 2px solid #0325cf;
    display: flex;
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
    /* 재사용 클래스 */
  .color_navitem {
    color: #0392cf;
  }
  main{
    margin: auto; /* header의 양쪽 여백(margin)을 동등하게 맞춤 ->수평가운데정렬 */
    display:flex;
    width: 1020px;
    height: 870px;
    position: relative;
  }
  .side-view{
  	position:absolute, left;
  	width: 216px;
  	height: 870px%;
  	background-color: green;
  	flex-direction: column;
  }
  .side-menu{
  
  }
  .member-view{
  	position:absolute, right;
  	width: 864px;
  	height: 870px;
  	background-color:blue;
  	flex-direction: column;
  }
  .member-info{
  
  }
  footer{
  margin:auto;
  width:1080;
  height:120px;
  background-color: lightgray;
  }
</style>

</head>

<body>
  <header>
  
  <!--html-->
  
  <!--
  TODO : 회원가입/로그인 페이지 링크걸기
  -->
    <div class="links">
      <a href="/" class="link_text">회원가입</a>
      <a href="LoginPage_test.jsp" class="link_text">로그인</a>
    </div>
  <!--
  TODO : 이미지 링크걸기
  -->
    <a href="MainPage.jsp"><img src="${rootPath}/png/logof.png" class="img_logo"/></a>
    <a><img src="${rootPath}/png/logoff2.png" class="img_logo2"/></a>
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
          <li><a href="/">회원정보</a></li>
          <li><a href="/">게시판</a></li>
          <li><a href="/">Q&A</a></li>
        </ul>

      </div>
    </nav>
  </header>

<main>

<div class=side-view ></div>
<div class=member-view ></div>

</main>

<footer>
end
</footer>


</body>
</html>