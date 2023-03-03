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
	    
	        
		} //oncomplete: function(data){//3
			
	}).open();//2
}//1

</script>

<script>
$(function(){
	
	var formFlag={
				idcheck: false,
				pwdcheck: false,
				nacheck:false,
				emcheck:false,
				phcheck:false,
				addr1check:false,
				bircheck: false
			
	}
	
	$("#member_id").blur(function(){
		
		var regexId=/[a-zA-Z]{1}\w{4,19}/
		if(regexId.test($("#member_id").val())== true){
			console.log("통과:")
			
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
			 });// ajax
			 
			formFlag.idcheck = true;
			 
		}
		else{
			console.log("미통과");
			formFlag.idcheck = false;
			$("#msg_id_error").html("아이디는 8~20사이로 작성하세요.");
			$("#member_id").focus();
			$("#member_id").val("");
		}
	});
	
	$("#member_pwd2").blur(function(){
		//동등여부 &정규표현식  점검
		var regexPwd=/[a-zA-Z]{1}\w{4,19}/
		if(regexPwd.test($("#member_pwd2").val())== true){
			console.log("통과:")
			formFlag.idcheck = true;
		}
		else{
			console.log("미통과")
			formFlag.idcheck = false;
			$("#msg_id_error").html("아이디는 8~20사이로 작성하세요.");
			
		}
	});
	
	$("#member_name").blur(function(){
		//이름 에러  정규식 2~50자 
		var regexName=/[가-힣]{2,50}/
		if(regexName.test($("#member_name").val())== true)
		{
			console.log("이름:ok")
			$("#msg_name_error").html("");
			formFlag.nacheck =true;
		}//if
		else{
			console.log("에러뜸:")
			formFlag.nacheck =false;
			$("#msg_name_error").html("이름은 2자~50자 이내의 한글로입력하세요.");
			$("#member_name").focus();
			$("#member_name").val("");
		}//else
	
	}); //function
	
	$("#member_email").blur(function(){
		//이메일  정규식 
		var regexEmail=/[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]/
		if(regexEmail.test($("#member_email").val())== true)
		{
			console.log("이메일:ok")
			$("#msg_email_error").html("");
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
			 });// ajax
			 
			formFlag.emcheck=true;
		}//if
		else{
			console.log("이메일에러:")
			formFlag.emcheck=false;
			$("#msg_email_error").html("이메일은 2~250자 이내로 영어대소문자숫자로 입력하세요.");
			$("#member_email").focus();
			$("#member_email").val("");
		}//else
	});
	
	$("#member_phone").blur(function(){
		var regexPhone = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/
		//휴대폰  정규식
		if(regexPhone.test($("#member_phone").val())== true){
			console.log("휴대폰:")
			$("#msg_phone_error").html("");
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
		 }); // ajax
		}//if
		else{
			console.log("phone에러:")
			formFlag.emcheck=false;
			$("#msg_phone_error").html("\"\-\"추가하여 010-4자-4자로 적어주세요.");
			$("#member_phone").focus();
			$("#member_phone").val("");
		}//else
			
	});
		
	//우편번호	
	/* $("#member_addrn").blur(function(){
	
		if($("#member_addrn").val()!==""){
			console.log("주소입력OK")
			formFlag.addr1check =true;
		}//if
		else{
			console.log("주소입력에러")
			formFlag.addr1check =false;
			$("#msg_addr_error").html("주소검색을 통해 주소입력하세요.")
			$("#member_addrn").focus();
			$("#member_addrn").val("");
		}//else
	}); */
	
	$("#member_birthday").blur(function(){
		//생년월일 정규식
		regexBirthday=/^[0-9]{6}$/
		if(regexBirthday.test($("#member_birthday").val())== true){
				console.log("birthday:ok")
			$("#msg_birthday_error").html("");
			formFlag.bircheck=true;
		}//if
		else{
			console.log("birthday error:")
			formFlag.bircheck=false;
			$("#msg_birthday_error").html("주민번호앞6자리로적어주세요.");
			$("#member_birthday").focus();
			$("#member_birthday").val("");
		}//else
	});
	
	
	
	/*회원정보전송 */
	$("#submit_btn").click(function(){
			
		//주소점검
		if($("#member_addrn").val()!=="" && $("#member_addr2").val()!==""){
			console.log("주소입력OK")
			$("#msg_addr_error").html("");
			formFlag.addr1check =true;
		}//if
		else{
			console.log("주소입력에러")
			
			if($("#member_addr2").val()==="" && $("#member_addrn").val()!=="" ){
				console.log("상세주소입력에러");
				$("#msg_addr_error").html("상세주소를 입력해주세요.");
				$("#member_addr2").focus();
			}
			else if($("#member_addrn").val()==="" && $("#member_addr2").val()!==""){
				console.log("기본주소입력에러");
				$("#msg_addr_error").html("주소검색을 통해 주소입력하세요.");
				$("#addrsearch_btn").focus();
			}
			
			formFlag.addr1check =false;
		
		}//else
			
		/* alert($("#msg_id_error").text()); */
		
		console.log("패스워드1:"+$("#member_pwd").val());
		console.log("패스워드2:"+$("#member_pwd2").val());
		console.log("패스워드 동일여부:"+($("#member_pwd").val() === $("#member_pwd2").val()));
		//$("#password").val() == $("#password2").val()
		
		
		//회원등록 전송시 체크현황
		if($("#msg_id_error").text().trim()==='중복된 아이디가 없습니다'){
			formFlag.idcheck=true;//아이디가 체크 ok
		}//id
		else{
			formFlag.idcheck=false;
		}
		
		
		if($("#member_pwd").val() !== $("#member_pwd2").val())
		{
			//alert("패스워드가 일치하지 않습니다")
			
			$("#msg_pwd_error").text("패스워드가 일치하지 않습니다");
			
			formFlag.pwdcheck=false;
		} 
		
		if(($("#member_pwd").val() === $("#member_pwd2").val() && $("#msg_pwd_error").text().trim()!== "패스워드는 8~20 영문 대소문자 와 최소 1개의 숫자 혹은 특수 문자를 포함해야 하세요.") ||
		   ($("#member_pwd").val() === $("#member_pwd2").val() && $("#msg_pwd_error").text().trim()!== "패스워드가 일치하지 않습니다"))
		{
			console.log("패스워드통과:")
			$("#msg_pwd_error").text("");
			formFlag.pwdcheck=true;
		} //pw3
		
		else{
			formFlag.pwdcheck=false;
		}
		
		if($("#msg_name_error").text().trim()==""){
		
			formFlag.nacheck=true;
		}//name
		else{
			formFlag.nacheck=false;
		}
		
		console.log("email error:"+$("#msg_email_error").text());
		
		if($("#msg_email_error").text().trim()==="중복된 이메일(이)가 없습니다"){
			
			formFlag.emcheck=true;
		}//email
		else{
			formFlag.emcheck=false;
		}
		//중복된 중복된휴대폰(이)가 있습니다
		if(	$("#msg_phone_error").text().trim()!=="중복된 중복된휴대폰(이)가 있습니다" ||
			$("#msg_phone_error").text().trim()==="중복된 휴대폰번호(이)가 없습니다" || 
		   $("#msg_phone_error").text().trim()!=="\"-\"추가하여 010-4자-4자로 적어주세요.")
		{	
			formFlag.phcheck=true;
		}//phone
		
		if($("#msg_phone_error").text().trim()=="중복된 중복된휴대폰(이)가 있습니다" || 
			$("#msg_phone_error").text().trim()!=="중복된 휴대폰번호(이)가 없습니다" || 
		   $("#msg_phone_error").text().trim()=="\"-\"추가하여 010-4자-4자로 적어주세요."	){
			formFlag.phcheck=false;
		}
		
		console.log("test:"+formFlag.phcheck)
		
		if($("#msg_birthday_error").text().trim()==""){
			
			formFlag.bircheck =true;
		}//brithday
		else{
			formFlag.bircheck=false;
		}
		
		
		console.log("formFlag.idcheck:"+formFlag.idcheck);
		console.log("formFlag.pwdcheck:"+formFlag.pwdcheck);
		console.log("formFlag.nacheck:"+formFlag.nacheck);
		console.log("formFlag.emcheck:"+formFlag.emcheck);
		console.log("formFlag.phcheck:"+formFlag.phcheck);
		console.log("formFlag.addr1check:"+formFlag.addr1check);
		console.log("formFlag.bircheck:"+formFlag.bircheck);
		
		
		//전체 플래그 체크 성공시 
		//if(true){ //''ex)if (formFlag.idcheck==true && formFlag.pwdcheck==true &&...)
		if(	
			formFlag.idcheck == true && 
			formFlag.pwdcheck == true &&
			formFlag.nacheck == true &&
			formFlag.emcheck == true &&
			formFlag.phcheck == true &&
			formFlag.addr1check == true &&
			formFlag.bircheck == true 
		){
			console.log("폼점검완료");	
	 		$("#memberVO").submit(); //전송 
		}
		 else{//일일이 실패한 경우 넣기 
			console.log("폼점검실패");
		 	alert("다시확인해주세요")
		 	
		    if(formFlag.idcheck == false){
		    	$("#member_id").val("");		    	
		    	$("#member_id").focus();
		    	$("#msg_id_error").html("아이디는 8~20사이로 작성하세요.")
		    } 
		    
		    if(formFlag.pwdcheck == false){
		    	$("#member_pwd").val("");	
		    	$("#member_pwd2").val("");
		    	$("#member_pwd").focus();
		    	$("#msg_pwd_error").html("패스워드는 8~20 영문 대소문자 와 최소 1개의 숫자 혹은 특수 문자를 포함해야 하세요.")
		    } 
		    
		    
		    if(formFlag.nacheck == false){
		    	$("#member_name").val("");		    	
		    	$("#member_name").focus();
		    	$("#msg_name_error").html("이름은 2자~50자 이내의 한글로입력하세요.");
		    } 
		    
		    if(formFlag.emcheck == false){
		    	$("#member_email").val("");		    	
		    	$("#member_email").focus();
		    	$("#msg_email_error").html("이메일은 2~250자 이내로 영어대소문자숫자로 입력하세요.");
		    } 
		 
		    if(formFlag.phcheck == false){
		    	$("#member_phone").val("");		    	
		    	$("#member_phone").focus();
		    	$("#msg_ph_error").html("\"-\"추가하여 010-4자-4자로 적어주세요.");
		    } 		 
		    
		 	
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
					<%-- 	<form:errors path="member_id" cssClass="err" /> --%>
					</div>
				</div>	
				
			</td>
		</tr>
		<!-- 패스워드 -->
		<tr>
			<th>패스워드 </th>
			<td> 
				<input type="text" id="member_pwd" name="member_pwd" class="form-control w-50">	
				<span id="msg_pwd_error" class="err">
				</span>
			</td>
		</tr>
		<!-- 패스워드 확인 -->
		<tr>
			<th>패스워드 확인 </th>
			<td> 
				<input type="text" id="member_pwd2" name="member_pwd2" class="form-control w-50">	
			</td>
		</tr>
	
		<!-- 이름 -->
		<tr>
			<th>이름 </th>
			<td> 
				<input type="text" id="member_name" name="member_name" class="form-control w-50">
				<span id="msg_name_error" class="err">
				</span>
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
						<button type="button" id ="addrsearch_btn" class="btn btn-outline-primary" onclick="searchPostcode()">주소검색</button>
					</div>
					<span id="msg_addr_error" class="err">
					</span>
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
				<span id="msg_birthday_error" class="err">	
				</span>
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div class="row">
					<div class="col-4"></div>
					<div class="col-2 clearfix">
						<div class="float-end">
							<button type="button" id="submit_btn" class="btn btn-outline-primary">제출</button>
						</div>
					</div> 
					<div class="col-2">
						<button type="reset" class="btn btn-outline-primary">취소</button>
					</div>
					<div class="col-4"></div>
				</div>		
			</td>
		</tr>
		</form:form>
		
	</table>

</div>
</body>
</html>