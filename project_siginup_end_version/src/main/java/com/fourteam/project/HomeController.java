package com.fourteam.project;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.fourteam.project.membervo.MemberVO;


import lombok.extern.slf4j.Slf4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Slf4j
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		logger.info("Welcome home!");
		
		return "MainPage";
		//return "redirect:/member/view_all.do";
	}
	
//	@RequestMapping("/")
//	public String home(Model model) {
//		
//		log.info("home");
//		
//		model.addAttribute("memberVO", new MemberVO());
//		
//		return "/form";
//	}


//	@RequestMapping("/form")
//	public String form(Model model) {
//		
//		log.info("model form !");
//		
//		model.addAttribute("memberVO", new MemberVO());
//		
//		return "form";
//	} //
//	
	
}
