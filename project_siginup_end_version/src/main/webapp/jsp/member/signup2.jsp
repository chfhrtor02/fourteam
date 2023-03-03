<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@	taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="rootPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="ko-kr">
<head>
<meta charset="UTF-8">
<title>회원가입 페이지</title>
<!-- bootstrap -->
<link href="<c:url value='/bootstrap-5.2.0/css/bootstrap.min.css'/>" rel="stylesheet">
<script src="<c:url value='/bootstrap-5.2.0/js/bootstrap.min.js'/>"></script>
<script src="<c:url value='/jquery-3.6.0/jquery.min.js'/>"></script>


<style>
.err 
{ 
	position:absolute, right;
	/* width : 10px;
	height: 10px; */
 	font-size:0.8em; 
 	color:red;
 	
}

#table_join_wrap {
	margin:auto;
	width: 900px;
}


#join_table th {
	width: 150px;
}

#join_table td
{
	width: 750px;
}

</style>

<!-- 우편번호주소검색  -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<!--  본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다-->
<script>
function searchPostcode(){/*1 */
	new daum.Postcode({//2
		oncomplete: function(data){//3
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var roadAddr =data.roadAddress; //도로명주소 변수
			var extraRoadAddr='';//참고 항목 변수
			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
	        // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	        if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){//4
	            extraRoadAddr += data.bname;
	        }
	        // 건물명이 있고, 공동주택일 경우 추가한다.
	        if(data.buildingName !== '' && data.apartment === 'Y'){
	           extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	        }
	        // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	        if(extraRoadAddr !== ''){
	            extraRoadAddr = ' (' + extraRoadAddr + ')';
	        }
			
	     // 우편번호와 주소 정보를 해당 필드에 넣는다.
	        document.getElementById('member_addrn').value = data.zonecode;
	        document.getElementById("member_addr1").value = roadAddr;
	        /* document.getElementById("jibunAddress").value = data.jibunAddress; */
	        
			//}
	      /*   var guideTextBox = document.getElementById("guide");
	        
	        // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	        if(data.autoRoadAddress) {
	            var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	            guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	            guideTextBox.style.display = 'block';
	
	        } else if(data.autoJibunAddress) {
	            var expJibunAddr = data.autoJibunAddress;
	            guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	            guideTextBox.style.display = 'block';
	        } else {
	            guideTextBox.innerHTML = '';
	            guideTextBox.style.display = 'none';
	        } */
	        
		} //oncomplete: function(data){//3
			
	}).open();//2
}//1

</script>

<script>
$(function(){
	
	/* 아이디 중복점검  */
	$("#id_check_button").click(function(){
	
		 $.ajax({
			 url : '/member/idcheck.do',
			 type : 'get',
			 dataType:'text',
			 data : {
				member_id : $('#member_id').val()
			 }, // data 
			 success : function(data) {
				 
				 // 서버 => 클라이언트
				 console.log("data : " + data);	
				 // alert(data);
				 
				// var json = JSON.parse(data)
				$('#msg_id_error').html(data);
				 //
		 	} // success
		 }) // ajax
	});
	
	/* 이메일 중복점검  */
	$("#email_check_button").click(function(){
	
		 $.ajax({
			 url : '/member/emailcheck.do',
			 type : 'get',
			 dataType:'text',
			 data : {
				member_email : $('#member_email').val()
			 }, // data 
			 success : function(data) {
				 
				 // 서버 => 클라이언트
				 console.log("data : " + data);	
				 // alert(data);
				 
				// var json = JSON.parse(data)
				$('#msg_email_error').html(data);
				 //
		 	} // success
		 }) // ajax
	});
	
	/* 휴대폰 중복점검  */
	$("#phone_check_button").click(function(){
	
		 $.ajax({
			 url : '/member/phonecheck.do',
			 type : 'get',
			 dataType:'text',
			 data : {
				member_phone : $('#member_phone').val()
			 }, // data 
			 success : function(data) {
				 
				 // 서버 => 클라이언트
				 console.log("data : " + data);	
				 // alert(data);
				 
				// var json = JSON.parse(data)
				$('#msg_phone_error').html(data);
				 //
		 	} // success
		 }) // ajax
	});
	
	/*회원정보전송 */
	$("#submit_btn").click(function(){
		
		alert("전송");
		
		console.log("패스워드1:"+$("#member_pwd").val());
		console.log("패스워드2:"+$("#member_pwd2").val());
		console.log("패스워드 동일여부:"+($("#member_pwd").val() === $("#member_pwd2").val()));
		//$("#password").val() == $("#password2").val()
		
		if($("#member_pwd").val() !== $("#member_pwd2").val()){
			alert("패스워드가 일치하지 않습니다")
		}
		else{
			$("#memberVO").submit();
		}
	});
	
	
});

</script>

</head>
<body>

<div class="d-flex justify-content-center mt-3 mb-3">
	<h3>회원가입</h3>
</div>
<div id ="table_join_wrap">
<table id="join_table" class="table table-bordered mx-auto">
	<form:form modelAttribute="memberVO" 
			   method="POST" action="${rootPath}/member/joinAction.do">
	<!-- 아이디 -->
	<tr>
		<th>아이디 </th>
		<td> 
			<div class="row">
				<div class="col-sm-5">		
					<input type="text" id="member_id" name="member_id" class="form-control">
				</div>
				<div class="col-sm-3 ">
			 		<button type="button"  id="id_check_button" class="btn btn-outline-primary">중복확인</button>
			 	</div>
			 	<!-- id 중복점검 메세지 -->
				<div id="msg_id_error" class="err col-sm-4 pt-2">
					<form:errors path="member_id" cssClass="err" />
				</div>
			</div>	
			
		</td>
	</tr>
	<!-- 패스워드 -->
	<tr>
		<th>패스워드 </th>
		<td> 
			<input type="text" id="member_pwd" name="member_pwd" class="form-control w-50">	
			 <form:errors path="member_pwd" cssClass="err"/>
		</td>
	</tr>
	<!-- 패스워드 확인 -->
	<tr>
		<th>패스워드 확인 </th>
		<td> 
			<input type="text" id="member_pwd2" name="member_pwd2" class="form-control w-50">	
		</td>
	</tr>
	</form:form>
	<!-- 이름 -->
	<tr>
		<th>이름 </th>
		<td> 
			<input type="text" id="member_name" name="member_name" class="form-control w-50">	
		</td>
	</tr>
	<!-- 성별 -->
	<tr>
		<th>성별 </th>
		<td> 
			<div class="row"> 
				<div class="col-1"></div>
				<div class="form-check col-1">
				  	<input type="radio" class="form-check-input" id="member_gender_M" name="member_gender" value="M" checked>남
				  	<label class="form-check-label" for="radio1"></label>
				</div>
				<div class="form-check col-1">
				  <input type="radio" class="form-check-input" id="member_gender_F" name="member_gender" value="F">여
				  <label class="form-check-label" for="radio2"></label>
				</div>
				<div class="col-9"></div>
			</div>
		</td>
	</tr>
	<!-- 이메일 -->
	<tr>
		<th>이메일 </th>
		<td> 
			<div class="row">
				<div class="col-sm-4">		
					<input type="text" id="member_email" name="member_email" class="form-control">	
				</div>
				<div class="col-sm-3">
			 		<button type="button"  id="email_check_button" class="btn btn-outline-primary">중복확인</button>
			 	</div>
			 	<!-- 이메일 메세지 -->
			 	<div id="msg_email_error" class="err col-sm-5 pt-2">
					<form:errors path="member_email" cssClass="err" />
				</div>
			</div>	
		</td>
	</tr>
	<!-- 휴대폰 -->
	<tr>
		<th>휴대폰 </th>
		<td>
		<div class="row">
				<div class="col-sm-5">		
					<input type="text" id="member_phone" name="member_phone" class="form-control">	
				</div>
				<div class="col-sm-3">
			 		<button type="button"  id="phone_check_button" class="btn btn-outline-primary">중복확인</button>
			 	</div>
			 	<!-- 휴대폰 메세지 -->
			 	<div id="msg_phone_error" class="err col-sm-4 pt-2">
					<form:errors path="member_phone" cssClass="err" />
				</div>
			</div>	
		</td>
	</tr>
	<!--우편번호 -->
	<tr>
		<th>우편번호</th>
		<td>
			<div class="row">
				<div class="col-5">
					<input type="text" id="member_addrn" name="member_addrn" class="form-control w-70" readonly>	
				</div>
				<div class="col-7">
					<button type="button" class="btn btn-outline-primary" onclick="searchPostcode()">주소검색</button>
				</div>
			</div> 
			
		</td>
		<!--주소-->
	<tr>
		<th>주소</th>
		<td> 
			<input type="text" id="member_addr1" name="member_addr1" class="form-control w-75" readonly>	
		</td>
		<!--우편번호 -->
	<tr>
		<th>상세주소</th>
		<td> 
			<input type="text" id="member_addr2" name="member_addr2" class="form-control w-75">	
		</td>
	</tr>
		<!--우편번호 -->
	<tr>
		<th>생일(6자리로)</th>
		<td> 
			<input type="text" id="member_birthday" name="member_birthday" class="form-control w-25">	
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<div class="row">
				<div class="col-4"></div>
				<div class="col-2 clearfix">
					<div class="float-end">
						<button type="submit" id="submit_btn" class="btn btn-outline-primary">제출</button>
					</div>
				</div> 
				<div class="col-2">
					<button type="reset" class="btn btn-outline-primary">취소</button>
				</div>
				<div class="col-4"></div>
			</div>		
		</td>
	</tr>
	</table>
</div>
</body>
</html>