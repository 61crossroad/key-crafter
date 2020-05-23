package kr.co.keycrafter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.service.MemberService;

@Log4j
@AllArgsConstructor
@RequestMapping("/member/*")
@Controller
public class MemberController {
	private MemberService memberService;
	
	@GetMapping("/login")
	public void login(String error, Model model) {
		if (error != null) {
			log.info("Login error occurred " + error);
			model.addAttribute("error", "true");
		}
		
		else {
			model.addAttribute("error", "false");
		}
	}
	
	@PostMapping("/insert")
	public String insert(MemberVO member, RedirectAttributes rttr) {
		log.info("Member Controller: insert");
		memberService.insertMember(member, "ROLE_USER");
		
		rttr.addFlashAttribute("result", 1);
		
		return "redirect:/";
	}
	
	@PostMapping("/update")
	public String update(MemberVO member) {
		log.info("Update result: " + memberService.updateMember(member));
		return "/member/memberInfo";
	}
	
	@GetMapping("/register")
	public String register() {
		return "/member/memberRegister";
	}
	
	@GetMapping("/info")
	public String info() {
		return "/member/memberInfo";
	}
}
