package com.ch.project.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ch.project.model.Board;
import com.ch.project.model.Member;
import com.ch.project.model.Parti;
import com.ch.project.model.Request;
import com.ch.project.service.BoardService;
import com.ch.project.service.MemberService;
import com.ch.project.service.PartiService;
import com.ch.project.service.RequestService;

@Controller
@RequestMapping("myPage")
public class MyPageController {
	@Autowired
	private MemberService ms;
	@Autowired
	private BoardService bs;
	@Autowired
	private RequestService rs;
	@Autowired
	private PartiService ps;
	@Autowired
	private BCryptPasswordEncoder bpPass; // 비밀번호를 암호화 (60개의 문자 랜덤으로)

	// 마이페이지 화면으로 이동
	@RequestMapping("/main")
	public String myPage(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}

		Member member = (Member) session.getAttribute("member");
		String m_id = member.getM_id();
		Member member1 = ms.selectMember(m_id);

		// level 구하기
		Calendar today = Calendar.getInstance();

		Calendar birthday = Calendar.getInstance();
		birthday.setTime(member.getBirthday());

		int level = today.get(Calendar.YEAR) - birthday.get(Calendar.YEAR) + 1;

		// 내가 쓴 글 구하기
		List<Board> myBoardList = bs.getMyBoard("m_id");

		// 내가 신청한 글 구하기
		List<Request> myRequestList = rs.getMyRequest("m_id");

		// 내가 참여한 활동 리스트 구하기
		List<Parti> myPartiList = ps.getMyParti("m_id");

		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());

		model.addAttribute("level", level);
		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);
		model.addAttribute("myPartiList", myPartiList);
		model.addAttribute("today", todayStr);
		model.addAttribute("member1", member1);

		return "myPage/myMain";
	}

	@RequestMapping("/Boards")
	public String Boards(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}

		Member member = (Member) session.getAttribute("member");

		String m_id = member.getM_id();
		List<Board> myBoardList = bs.getMyBoard(m_id);

		model.addAttribute("myBoardList", myBoardList);

		return "myPage/boards";
	}

	@RequestMapping("/Requests")
	public String Requests(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}

		Member member = (Member) session.getAttribute("member");

		String m_id = member.getM_id();
		List<Board> myBoardList = bs.getMyBoard(m_id);
		List<Request> myRequestList = rs.getMyRequest(m_id);

		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);

		return "myPage/requests";
	}

	@RequestMapping("/Partis")
	public String Partis(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}

		Member member = (Member) session.getAttribute("member");

		String m_id = member.getM_id();
		List<Board> myBoardList = bs.getMyBoard(m_id);
		List<Request> myRequestList = rs.getMyRequest(m_id);
		List<Parti> myPartiList = ps.getMyParti(m_id);

		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String todayStr = sdf.format(today.getTime());

		model.addAttribute("myBoardList", myBoardList);
		model.addAttribute("myRequestList", myRequestList);
		model.addAttribute("myPartiList", myPartiList);
		model.addAttribute("today", todayStr);

		return "myPage/partis";
	}

	@RequestMapping("/UpdateForm")
	public String UpdateForm(Model model, HttpSession session, RedirectAttributes ra) {
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}
		Member member = (Member) session.getAttribute("member");

		model.addAttribute("member", member);
		return "myPage/updateForm";

	}

	@RequestMapping("/Update")
	public String Update(@RequestParam("picture") MultipartFile mf, Model model, HttpSession session, HttpServletRequest request, RedirectAttributes ra) throws IOException {
//		member.setM_id(member1.getM_id());
//		System.out.println("m_id = "+member1.getM_id());
		if (session.getAttribute("member") == null) {
			ra.addFlashAttribute("result", 0);
			return "redirect:/error";
		}
		String realPath = session.getServletContext().getRealPath("/resources/profile"); // 실제 저장 위치
		
		Member member = ms.selectMember("m_id");
		String m_id = member.getM_id();

		String fileName = mf.getOriginalFilename();
		// 파일 입력하지 않았으면 파일명을 noFile로, 파일을 입력했으면 UUID+파일 확장자로 파일명 변경하고 파일을 저장,
		if (fileName.equals("")) {
			fileName = "user.svg";
		} else {
			// 파일명을 변경하고 싶을 때 : 날짜(연월일시분초), UUID
			UUID uuid = UUID.randomUUID();
			fileName = uuid + fileName.substring(fileName.lastIndexOf('.'));

			FileOutputStream fos = new FileOutputStream(new File(realPath + "/" + fileName));
			fos.write(mf.getBytes());
			fos.close();
		}

		member.setPicture(fileName);
		
		int result = 0;
		result = ms.updateProfile(member);

		model.addAttribute("result", result); 
		return "myPage/update";
	}

}
