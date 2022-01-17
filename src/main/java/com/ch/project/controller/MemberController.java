package com.ch.project.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.request;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Date;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ch.project.model.Member;
import com.ch.project.service.MemberService;

@Controller
@RequestMapping("member")
public class MemberController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BCryptPasswordEncoder bpPass;        	// 비밀번호를 암호화 (60개의 문자 랜덤으로)
	
	// 회원가입 폼으로 이동
	@RequestMapping("/joinForm")
	public String joinForm() {
		return "member/joinForm";
	}
	// 프로필 입력 폼으로 이동
	@RequestMapping("/profileForm")
	public String profileForm(Model model, RedirectAttributes re, HttpServletRequest request) {
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		
		int result = 0;
		Member member = null;
		if (flashMap != null) {
			result = (Integer)flashMap.get("result");
			member = (Member)flashMap.get("member");
		}
		
		
		/* flashMap에 Map으로 담겨져 온 경우
		 * HashMap<String, Object> param = (HashMap<String, Object>)flashMap.get("param"); 
		 * int result = (Integer) param.get("result"); 
		 * Member member = (Member) param.get("member");
		 */
		
		if (result != 1) {
			re.addFlashAttribute("result", result);
			return "redirect:/error";
		}
		
		model.addAttribute("member", member);
		return "member/profileForm";
	}
	@RequestMapping("/join")
	public String join(Member member, Model model, RedirectAttributes re, HttpServletRequest request) {
		int result = 0;
		
		if(request.getHeader("referer") == null) {
			result = -1;
			model.addAttribute("result", result);
			return "error";
		}
		
		String password = bpPass.encode(member.getPassword());
		member.setPassword(password);
		
		//막아둠
		result = ms.insert(member);
		
		//result = 1;
		
		re.addFlashAttribute("result", result);
		re.addFlashAttribute("member", member);
		
		/* 
		 * Map<String, Object> param = new HashMap<String, Object>();
		 * 
		 * param.put("result", result); 
		 * param.put("member", member);
		 * 
		 * re.addFlashAttribute("param", param);
		 */
		
		return "redirect:/member/profileForm.do";
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
	@RequestMapping("/profileInsert")
	public String profileInsert(@RequestParam("picture") MultipartFile mf, @RequestParam Map<String, String> param, Model model, HttpSession session, HttpServletRequest request) throws IOException {
		if (request.getHeader("referer") == null) {
			return "redirect:/member/loginForm";
		}
		String realPath = session.getServletContext().getRealPath("/resources/profile");	//실제 저장 위치
		
		System.out.println(param);
		
		String m_id = param.get("m_id");
		
		Member member = ms.selectMember(m_id);
		
		System.out.println(member);
		
		String fileName = mf.getOriginalFilename();
		System.out.println(mf);
		System.out.println(fileName);
		//파일 입력하지 않았으면 파일명을 noFile로, 파일을 입력했으면 UUID+파일 확장자로 파일명 변경하고 파일을 저장, 
		if (fileName.equals("")) {
			fileName = "noFile";
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
		
		return "redirect:/member/loginForm.do";
	}
	
	
	
	
	// 로그인 폼으로 이동
	@RequestMapping("loginForm")
	public String loginForm(HttpServletRequest request, Model model) {
		return "member/loginForm";
	}

	@RequestMapping(value = "login", produces = "text/html;charset=utf-8")
	@ResponseBody
	public String login(String m_id, String password, HttpSession session) {
		int result = 0;   // 암호가 다르다
		Member member = ms.selectMember(m_id);
		if (member == null || member.getDel().equals("y"))
			result = -1;  // 없는 id
		else {
			// if (member.getPassword().equals(member2.getPassword())) 이렇게 쓰면 안 된다
			// 입력된 데이터도 암호화 시켜서 DB에 있는 암호와 비교해야 한다(matches)
			if (bpPass.matches(password, member.getPassword())) {
				result = 1;   // 성공(id와 암호가 일치)
				session.setAttribute("member", member);
			}
		}
		
		return result+"";
	}
	// 로그 아웃
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/home.do";
	}
	
	
	// 비밀번호 찾기 폼으로 이동
	@RequestMapping("findPwForm")
	public String findPwForm(String m_id, Model model) {
		// 아이디 찾기 후 비밀번호를 찾으면 값이 자동으로 넘어가게 하기 위함
		model.addAttribute("m_id", m_id);
		return "member/findPwForm";
	}
	
	// 비밀번호 찾기
	@RequestMapping("findPwResult")
	public String findPwResult(Member member, Model model) {
		int result = 0;
		Member member2 = ms.selectFindPw(member);
		if (member2 != null) {
			// 아이디가 존재 할 때 결과 값 1을 반영
			result = 1;
			model.addAttribute("member", member2);
			
			// 난수 생성
			String msg = "";
			String code = "";
			Random random = new Random();
			for(int i=0; i<3; i++) {
				int index = random.nextInt(25)+65; //A~Z까지 랜덤 알파벳 생성
				code += (char)index;
			}
			int numIndex = random.nextInt(9999)+1000; //4자리 랜덤 정수 생성
			code += numIndex;		
			msg = (String)code;  //메시지 내용 함수입력
					
			MimeMessage mm = jMailSender.createMimeMessage();
			try {
				MimeMessageHelper mmh = new MimeMessageHelper(mm, true, "utf-8");
				mmh.setSubject("타이거 임시비밀번호 입니다.");
				mmh.setText("임시비밀번호 : " + msg);
				mmh.setTo(member.getM_id());
				mmh.setFrom("email@email.com");
				jMailSender.send(mm);
				
				// 이메일이 성공적으로 보내졌으면 멤버 비밀번호를 변경
				member.setPassword(msg);
				int resultUpdatePw = ms.updatePw(member);
				model.addAttribute("resultUpdatePw", resultUpdatePw);
				
			} catch (Exception e) {
				result = 0;
				model.addAttribute("msg", e.getMessage());
			}		
		} else {
			result = -1;
		}
		model.addAttribute("result", result);
		return "member/findPw";
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
	