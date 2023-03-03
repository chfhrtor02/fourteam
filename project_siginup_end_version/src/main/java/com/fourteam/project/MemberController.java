package com.fourteam.project;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.fourteam.project.memberservice.IMemberService;
import com.fourteam.project.membervo.MemberVO;


import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/member")
public class MemberController {
	
	@Autowired
	IMemberService iMemberService;
	
	@Autowired
	private MemberVOValidator validator;
	
	//가입형식
	@GetMapping("/join.do")
	public String join(Model model) {
		log.info("회원가입홈");
		model.addAttribute("memberVO", new MemberVO());
		return "/member/signup";
	}
	
	@RequestMapping("joinAction.do") 
	public ModelAndView formAction(@ModelAttribute("memberVO") MemberVO memberVO,
								   BindingResult result) {
		
		log.info("spring form-validation formAction ");
		log.info("테스트:"+memberVO);
		
		//Spring form validate
	/*	this.validator.validate(memberVO, result);*/
		
		ModelAndView model = new ModelAndView();
		model.getModel().putAll(result.getModel());
		model.setViewName("/member/signup");
		String msg=	iMemberService.insertMember(memberVO);
		
		log.info("msg:"+msg);
		
		model.setViewName("/common/message");
		model.addObject("msg",msg);
		
		if(msg.trim().equals("회원가입에 성공하셨습니다")) {
			
			model.addObject("movePath","Login.jsp");
		}
		else {
			model.addObject("movePath","/member/signup.jsp");
		}
		
		return model;
	} //
	
	@GetMapping("/view.do")
	public String view(@RequestParam("id") String id, Model model) {
		log.info("회원정보보기");
		model.addAttribute("member", iMemberService.getMember(id));
		return	"/member/view";
	}
	
	@GetMapping("/view_all.do")
	public String viewAll(Model model) {
		log.info("전체 회원정보");
		model.addAttribute("members", iMemberService.getAllMembers());
		return "/member/viewAll";
	}
	
	@GetMapping("login.do")
	public void getOneMembers() throws Exception{}
	
	@PostMapping("login.do")
	public String getOneMembers(MemberVO memberVO, HttpSession session, Model model) throws Exception{
		log.info("memberVO:{}",memberVO);
		
		memberVO = iMemberService.getOneMember(memberVO);
		
		log.info("memberVO2:{}",memberVO);
		
		if(memberVO.getMember_id() != null) {
			session.setAttribute("MEMBER_SES", memberVO);
			log.info("로그인:성공");
			return "/MainPage";
		}
		else {
			log.info("로그인:실패");
			model.addAttribute("login_error_msg","아이디및 비밀번호가 틀리셨습니다");
		
			return "/Login";
		}
	}
	   @RequestMapping("logout.do")
	    public String logout(MemberVO memberVO, HttpSession session ,Model model) throws Exception{
	        log.info("logoutMainGET메서드 진입");
	        model.addAttribute("logout_msg", "로그아웃 됬습니다");
	        session.invalidate();
	       
	       return "/MainPage";
	    }
	
	   
	 
}
