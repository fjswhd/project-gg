package com.ch.project;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	@Autowired
	private BCryptPasswordEncoder pEncoder;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home() {
		return "home";
	}
	@RequestMapping(value = "joinForm", method = RequestMethod.GET)
	public String joinForm() {
		return "user/joinForm";
	}
	@RequestMapping(value = "loginForm")
	public String loginForm() {
		return "user/loginForm";
	}
	@RequestMapping(value = "profileForm")
	public String profileForm() {
		return "user/profileForm";
	}
	
	
	@RequestMapping(value = "join")
	public String join(@RequestParam Map<String, String> param, Model model) {
		int result = 0;
		for(Map.Entry<String, String> entry : param.entrySet()) {
			if (entry.getKey().equals("password"))
				System.out.println(entry.getKey() +" : "+ pEncoder.encode(entry.getValue()));
			else 
				System.out.println(entry.getKey() +" : "+ entry.getValue());
	
		}
		result = 1;
		model.addAttribute("result", result);
		
		return "user/join";
	}
	@RequestMapping(value = "login", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String login(@RequestParam Map<String, String> param) {
		int result = 0;
		
		//입력한 정보와 저장된 정보를 비교
		//아이디 있음, 비밀번호 맞음
		if ( param.get("id").equals("java") && param.get("password").equals("1234") ) 
			result = 1;
		
		//아이디 있음, 비밀번호 틀림
		else if ( param.get("id").equals("java") && !param.get("password").equals("1234"))
			result = 0;
		
		//아이디 없음
		else if ( !param.get("id").equals("java"))
			result = -1;
		
		return result+"";
	}
}
