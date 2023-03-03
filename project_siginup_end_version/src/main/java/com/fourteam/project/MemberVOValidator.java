package com.fourteam.project;

import java.util.regex.Pattern;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.fourteam.project.membervo.MemberVO;

import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class MemberVOValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		
		return MemberVO.class.equals(clazz);
	}
	
	@Override
	public void validate(Object target, Errors errors) {
		
		log.info("Spring Form validate method");
		
		MemberVO member =(MemberVO)target;
		
		//아이디="[a-zA-Z]{1}\\w{4,19}"

		String regexId ="[a-zA-Z]{1}\\w{4,19}";
		if(Pattern.matches(regexId, member.getMember_id()) == false) {
			
			log.error("아이디오류 ");
			errors.rejectValue("member_id","error");
		}
		
		//pwd= "(?=.*[a-zA-Z])((?=.*\\d)(?=.*\\W)).{8,20} 8자에서 20자 이내로
		String regexPwd = "(?=.*[a-zA-Z])((?=.*\\d)(?=.*\\W)).{8,20}";
		if(Pattern.matches(regexPwd, member.getMember_pwd()) == false) {
			
			log.error("패스워드 오류");
			errors.rejectValue("member_pwd","error");
		}
		
		//pwd 불일치
		
		
		
		//이름 	"[가-힣]{2,50}" 2자에서 50자 이내로
		String regexName =	"[가-힣]{2,50}";
		if(Pattern.matches(regexName, member.getMember_name()) == false) {
			
			log.error("이름오류");
			errors.rejectValue("member_name","error");
		}
		
		//이메일[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z0-9]{2,250} 2자에서 250자 이내로 
		String regexEmail= "[a-zA-Z0-9_+.-]+@([a-zA-Z0-9-]+\\\\.)+[a-zA-Z0-9]{2,250}";
		if(Pattern.matches(regexName, member.getMember_email()) == false) {
		
			log.error("email오류");
			errors.rejectValue("member_email","error");
		}
		
		//휴대폰번호 "01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$" 01x-xxxx-xxxx
		String regexPhone =	"01(?:0|1|[6-9])-(?:\\d{3}|\\d{4})-\\d{4}$";
		if(Pattern.matches(regexName, member.getMember_phone()) == false) {
			
			log.error("휴대폰");
			errors.rejectValue("member_phone","error");
		}
		
		//생일  xxxxxx 주민번호 앞6자리
		String regexBirthday = "[0-9]*${6}";
		if(Pattern.matches(regexName, member.getMember_phone()) == false) {
			
			log.error("생일");
			errors.rejectValue("member_birthday","error");
		}
		
	}
}
