package com.fourteam.project;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.fourteam.project.memberservice.IMemberService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/member")
public class MemberCheckController {
	
	@Autowired
	IMemberService iMemberService;
	
	//아이디 중복점검 
	@GetMapping(value="/idcheck.do", produces="text/plain; charset=utf-8")
	public ResponseEntity<String> idcheck(@RequestParam("member_id") String memberID){
		
		log.info("idcheck");
		log.info("결과:"+iMemberService.getMember(memberID));
		String msg = iMemberService.getMember(memberID).getMember_id() == null ? "중복된 아이디가 없습니다": "중복된 아이디가 있습니다" ;
		return ResponseEntity.ok(msg);
	}
	
	//이메일 중복점검
	@GetMapping(value="/emailcheck.do", produces="text/plain; charset=utf-8")
	public ResponseEntity<String> emailcheck(@RequestParam("member_email") String memberEmail){
			
			log.info("emailcheck");
			log.info("결과:"+iMemberService.isMember("member_email", memberEmail));
			String msg = iMemberService.isMember("member_email", memberEmail) == false ? "중복된 이메일(이)가 없습니다": "중복된 이메일(이)가 있습니다" ;
			return ResponseEntity.ok(msg);
		}

	//휴대폰 중복점검
	@GetMapping(value="/phonecheck.do", produces="text/plain; charset=utf-8")
	public ResponseEntity<String> phoneCheck(@RequestParam("member_phone") String memberPhone){
			
			log.info("phoneCheck");
			log.info("결과:"+iMemberService.isMember("member_phone", memberPhone));
			String msg = iMemberService.isMember("member_phone", memberPhone) == false ? "중복된 휴대폰번호(이)가 없습니다": "중복된 중복된휴대폰(이)가 있습니다" ;
			return ResponseEntity.ok(msg);
		}
	
	
}
