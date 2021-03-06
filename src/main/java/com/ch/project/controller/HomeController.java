package com.ch.project.controller;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ch.project.model.Category;
import com.ch.project.service.BoardService;

@Controller
public class HomeController {
	@Autowired
	private BoardService bs;
	
	@RequestMapping(value = "home", method = RequestMethod.GET)
	public String home(Model model) {
		List<Category> categoryList = bs.getCategories();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		Calendar cal = Calendar.getInstance();
		String today = sdf.format(cal.getTime());
		
		cal.add(Calendar.MONTH, 3);
		String lastday = sdf.format(cal.getTime());
		
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("today", today);
		model.addAttribute("lastday", lastday);
		
		return "home";
	}
	@RequestMapping(value = "error", method = RequestMethod.GET)
	public String error(Model model, HttpSession session, HttpServletRequest request) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);

		int result = -1;
		if(flashMap != null) {
			result = (Integer) flashMap.get("result");
		}
		
		session.invalidate();
		
		model.addAttribute("result", result);	
		return "error";
	}
	
	
	/*
	 * @RequestMapping(value = "joinForm", method = RequestMethod.GET) public String
	 * joinForm() { return "user/joinForm"; }
	 */
	/*
	 * @RequestMapping(value = "loginForm") public String loginForm() { return
	 * "user/loginForm"; }
	 * 
	 * @RequestMapping(value = "profileForm") public String profileForm() { return
	 * "user/profileForm"; }
	 */
	
	
	/*
	 * @RequestMapping(value = "idChk", produces = "text/html;charset=utf-8")
	 * 
	 * @ResponseBody public String login(String m_id) { int result = 0;
	 * 
	 * //?????? ???????????? id??? 0 //??????????????? ???????????? 1
	 * 
	 * 
	 * return result+""; }
	 */
	
	/*
	 * @RequestMapping(value = "join") public String join(@RequestParam Map<String,
	 * String> param, Model model) { int result = 0; for(Map.Entry<String, String>
	 * entry : param.entrySet()) { if (entry.getKey().equals("password"))
	 * System.out.println(entry.getKey() +" : "+ pEncoder.encode(entry.getValue()));
	 * else System.out.println(entry.getKey() +" : "+ entry.getValue());
	 * 
	 * }
	 * 
	 * return "redirect:loginForm.do"; }
	 * 
	 * @RequestMapping(value = "login", produces = "text/html;charset=utf-8")
	 * 
	 * @ResponseBody public String login(@RequestParam Map<String, String> param) {
	 * int result = 0;
	 * 
	 * //????????? ????????? ????????? ????????? ?????? //????????? ??????, ???????????? ?????? if ( param.get("id").equals("java") &&
	 * param.get("password").equals("1234") ) result = 1;
	 * 
	 * //????????? ??????, ???????????? ?????? else if ( param.get("id").equals("java") &&
	 * !param.get("password").equals("1234")) result = 0;
	 * 
	 * //????????? ?????? else if ( !param.get("id").equals("java")) result = -1;
	 * 
	 * return result+""; }
	 */
}
