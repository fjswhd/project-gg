package com.ch.project.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ch.project.model.MailSender;
import com.ch.project.model.Member;
import com.ch.project.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpPass;        	// 비밀번호를 암호화 (60개의 문자 랜덤으로)
	@Autowired
	private MailSender mailSender;
	
	// 회원가입 폼으로 이동
	@RequestMapping("/joinForm")
	public String joinForm(HttpSession session) {
		if(session.getAttribute("member") != null) {
			return "redirect:/home";
		}
		return "member/joinForm";
	}
	// 프로필 입력 폼으로 이동
	@RequestMapping("/profileForm")
	public String profileForm(String m_id, Model model) {
//		falshAttribute사용 시
//		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
//		
//		int result = 0;
//		Member member = null;
//		if (flashMap != null) {
//			result = (Integer)flashMap.get("result");
//			member = (Member)flashMap.get("member");
//		}
//		
		
		/* flashMap에 Map으로 담겨져 온 경우
		 * HashMap<String, Object> param = (HashMap<String, Object>)flashMap.get("param"); 
		 * int result = (Integer) param.get("result"); 
		 * Member member = (Member) param.get("member");
		 */

		model.addAttribute("m_id", m_id);
		return "member/profileForm";
	}
	@RequestMapping(value = "/join", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String join(Member member, Model model, RedirectAttributes re, HttpServletRequest request) {
		String result = "0";
		
		if(request.getHeader("referer") == null) {
			result = "-1";
			return result;
		}
		
		String password = bpPass.encode(member.getPassword());
		member.setPassword(password);
		
		//기본 프로필 설정 >> db에서
		
		//막아둠
		int iResult = ms.insert(member);
		//int iResult = 1;
		
		if (iResult == 1) {
			result = member.getM_id();
		} else {
			result = "0";
		}
		
//		re.addFlashAttribute("result", result);
//		re.addFlashAttribute("member", member);
		
		return result;
	}

	// 아이디 중복체크 할때 사용
	@RequestMapping(value = "idChk", produces = "text/html;charset=utf-8")
	@ResponseBody // jsp로 가지말고 바로 본문으로 전달
	public String idChk(String m_id) {
		String msg = "";
		Member member = ms.selectMember(m_id);
		if (member == null) {
			msg = "1";
		} else {
			msg = "0";
		}
		return msg;
	}

	// 닉네임 중복체크
	@RequestMapping(value = "nickChk", produces = "text/html;charset=utf-8")
	@ResponseBody // jsp로 가지말고 바로 본문으로 전달
	public String nickChk(String nickname) {
		String msg = "";
		Member member = ms.selectMemberWithNick(nickname);
		if (member == null) {
			msg = "1";
		} else {
			msg = "0";
		}
		return msg;
	}
	
	//member로 넣으면 400에러 enctype과 관련된문제같음
	@RequestMapping(value = "/profileInsert")
	@ResponseBody
	public Map<String, Object> profileInsert(@RequestParam("picture") MultipartFile mf, @RequestParam Map<String, String> param, Model model, HttpSession session, HttpServletRequest request) throws IOException {
		
		String realPath = session.getServletContext().getRealPath("/resources/profile");	//실제 저장 위치
		
		String m_id = param.get("m_id");
		
		Member member = ms.selectMember(m_id);
		
		String fileName = mf.getOriginalFilename();
		//파일 입력하지 않았으면 파일명을 noFile로, 파일을 입력했으면 UUID+파일 확장자로 파일명 변경하고 파일을 저장, 
		if (fileName.equals("") || fileName == null) {
			fileName = "user.svg";
		} else {
			//파일명을 변경하고 싶을 때 : 날짜(연월일시분초), UUID
			UUID uuid = UUID.randomUUID();
			fileName = uuid + fileName.substring(fileName.lastIndexOf('.'));
			
			FileOutputStream fos = new FileOutputStream(new File(realPath + "/" + fileName));
			fos.write(mf.getBytes());
			fos.close();			
		}
		
		//생일 입력 안하면 가입한 날짜를 생일로
		Date birthday = param.get("birthday").equals("") ? member.getBirthday() : Date.valueOf(param.get("birthday"));
		String place = param.get("place").equals("") ? "알 수 없음" : param.get("place");
		String tag = param.get("tag").equals("") ? "알 수 없음" : param.get("tag") ;

		member.setPicture(fileName);
		member.setBirthday(birthday);
		member.setPlace(place);
		member.setTag(tag);
		
		int result = 0;
		result = ms.updateProfile(member);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String reg_date = sdf.format(member.getReg_date());
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		
		Calendar cBirthday = Calendar.getInstance();
		cBirthday.setTime(member.getBirthday());
		
		int level = today.get(Calendar.YEAR) - cBirthday.get(Calendar.YEAR) + 1;
		
		//닉네임 픽쳐 플레이스 레이팅 가입일 태그 생일
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("nickname", member.getNickname());
		resultMap.put("picture", member.getPicture());
		resultMap.put("place", member.getPlace());
		resultMap.put("rating", member.getRating());
		resultMap.put("reg_date", reg_date);
		resultMap.put("level", level);
		resultMap.put("tag", member.getTag());
		
		return resultMap;
	}
	
	@RequestMapping(value = "/getProfile", produces = "application/json;charset=utf-8")
	@ResponseBody
	public Map<String, Object> getProfile(@RequestBody Map<String, Object> param) {
		String m_id = (String) param.get("m_id");
		
		Member member = ms.selectMember(m_id);

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String reg_date = sdf.format(member.getReg_date());
		
		//level 구하기
		Calendar today = Calendar.getInstance();
		
		Calendar birthday = Calendar.getInstance();
		birthday.setTime(member.getBirthday());
		
		int level = today.get(Calendar.YEAR) - birthday.get(Calendar.YEAR) + 1;
		
		//닉네임 픽쳐 플레이스 레이팅 가입일 태그 생일
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("nickname", member.getNickname());
		result.put("picture", member.getPicture());
		result.put("place", member.getPlace());
		result.put("rating", member.getRating());
		result.put("reg_date", reg_date);
		result.put("level", level);
		result.put("tag", member.getTag());
		
		return result;
	}
	
	
	// 로그인 폼으로 이동
	@RequestMapping("loginForm")
	public String loginForm(HttpServletRequest request, Model model) {
		String prev = "";
		
		if(request.getHeader("referer") != null) {
			prev = request.getHeader("referer");
		}
		
		model.addAttribute("prev", prev);
		
		return "member/loginForm";
	}

	@RequestMapping(value = "login", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String login(String m_id, String password, String prev, HttpSession session) {
		if(prev.contains("profileForm") || prev.contains("findPwForm")) {
			prev = "/project/home.do";
		}
		
		
		String result = "0";   // 암호가 다르다
		Member member = ms.selectMember(m_id);
		if (member == null || member.getDel().equals("y"))
			result = "-1";  // 없는 id
		else {
			// if (member.getPassword().equals(member2.getPassword())) 이렇게 쓰면 안 된다
			// 입력된 데이터도 암호화 시켜서 DB에 있는 암호와 비교해야 한다(matches)
			if (bpPass.matches(password, member.getPassword())) {
				result = prev;   // 성공(id와 암호가 일치)
				session.setAttribute("member", member);
			}
		}
		
		return result;
	}
	// 로그 아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
	}
	
	
	// 비밀번호 찾기 폼으로 이동
	@RequestMapping("findPwForm")
	public String findPwForm() {
		return "member/findPwForm";
	}
	
	//이메일 인증번호 보내기
	@RequestMapping(value = "authUser", produces = "html/text;charset=utf-8")
	@ResponseBody
	public String authUser(String m_id) {
		//6자리 랜덤 정수 만들기
		String result = "";
		
		for(int i = 0; i < 6; i++) {
			int num = (int)(Math.random() * 10);
			result += num;
		}
		
		mailSender.authMail(m_id, result);
		
		return result;
	}
	
	
	// 비밀번호 찾기
	@RequestMapping("findPw")
	public String findPwResult(Member member, Model model, HttpServletRequest request) {
		String newPw = mailSender.getNewPassword();
		
		mailSender.initPwMailSend(member.getM_id(), newPw, request);
		
		newPw = bpPass.encode(newPw);
		member.setPassword(newPw);
		
		int result = ms.updateMember(member);
		
		
		return "redirect:/member/loginForm.do";
	}
	
	// 마이페이지 메인으로 이동
	@RequestMapping("myMain")
	public String myMain(Model model, HttpSession session) {
		String m_id = (String)session.getAttribute("m_id");
		Member member = ms.select(m_id);
		model.addAttribute("member", member);
		return "myPage/myMain";
	}
	
	// 프로필 상세보기
	@RequestMapping("profileView")
	public String profileView(String nickname, HttpSession session, Model model) {
		int result = 0; 
		Member member = ms.selectNick(nickname); // 선택한 계정의 정보를 가져옴
		if (member.getDel() == "y") { // 회원 탈퇴 처리 되어있는지 확인
			result = 0; // 회원 탈퇴 처리가 되어있음
		} else {
			result = 1; // 회원 탈퇴 처리가 안되있을 경우
		model.addAttribute("result", result); // 회원 탈퇴 여부 확인
		model.addAttribute("member", member); // 프로필에서 회원정보 입력하기 위해서
		return "myPage/profileView";
		}
	}
	// 마이페이지 회원정보 수정폼으로 이동
	@RequestMapping("updateForm")
	public String updateForm(Model model, HttpSession session) {
		String m_id = (String)session.getAttribute("m_id");
		Member member = ms.select(m_id);
		model.addAttribute("member", member);
		return "myPage/updateForm";
	}
		
	// 마이페이지 회원정보 수정
	@RequestMapping("updateResult")
	public String updateResult(Member member, Model model, HttpSession session) throws IOException {
		// 사진을 리소스 폴더에 저장하기 위한 로직
		String fileName1 = member.getFile().getOriginalFilename();
		if (fileName1 != null && !fileName1.equals("")) {
			UUID uuid = UUID.randomUUID(); // 파일이름이 겹치지 않게 하기 위함
			String fileName = uuid+"_"+fileName1;
			// 파일을 리소스 폴더에 저장
			String real = session.getServletContext().getRealPath("/resources/memberImg");
			FileOutputStream fos = new FileOutputStream(new File(real+"/"+fileName));
			fos.write(member.getFile().getBytes());
			fos.close();
			// 정보를 수정
			member.setM_img(fileName);
		}	
		
		int result = ms.update(member);
		
		model.addAttribute("result", result);
		return "myPage/updateResult";
	}
		
	// 비밀번호 변경 폼으로 이동
	@RequestMapping("updatePw")
	public String updatePw(Model model, HttpSession session) {
		String m_id = (String)session.getAttribute("m_id");
		Member member = ms.select(m_id);
		model.addAttribute("member", member);
		return "myPage/updatePw";
	}
	
	// 비밀번호 변경
	@RequestMapping("updatePwResult")
	public String updatePwResult(Member member, Model model) {
		int result = ms.updatePw(member);
		model.addAttribute("result", result);
		return "myPage/updatePwResult";
	}

	// 마이페이지 회원 탈퇴
	@RequestMapping("delete")
	public String delete(HttpSession session, Model model) {
		String m_id=(String)session.getAttribute("m_id");
		int result=ms.delete(m_id);
		if (result>0) session.invalidate();
		model.addAttribute("result", result);
		return "myPage/delete";
	}
}
	