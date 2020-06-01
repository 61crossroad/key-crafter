package kr.co.keycrafter.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.PageDTO;
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
	
	@GetMapping("/register")
	public String register() {
		return "/member/memberRegister";
	}
	
	@ResponseBody
	@PostMapping(value = "/check",
			consumes = "application/json")
	public ResponseEntity<String> check(@RequestBody MemberVO member) {
		String result = memberService.checkOverlap(member);
		
		return new ResponseEntity<String>(result, HttpStatus.OK);
	}
	
	@PostMapping("/insert")
	public String insert(MemberVO member, RedirectAttributes rttr) {
		log.info("Member Controller: insert");
		memberService.insertMember(member, "ROLE_USER");
		
		rttr.addFlashAttribute("result", 1);
		
		return "redirect:/";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/update")
	public String update(MemberVO member) {
		log.info("Update result: " + memberService.updateMember(member));
		return "/member/memberInfo";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/info")
	public String info() {
		return "/member/memberInfo";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/list")
	public String getList(Criteria cri, Model model) {
		int total = memberService.getMemberCount(cri);
		
		PageDTO pageDTO = new PageDTO(cri, total);
		Criteria realCri = pageDTO.getCri();
		
		List<MemberVO> memberList = memberService.getMemberList(realCri);
		
		model.addAttribute("memberList", memberList);
		model.addAttribute("pageMaker", pageDTO);
		
		return "/member/memberList";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@GetMapping("/get")
	public String getMemberInfo(@RequestParam("id") String id, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("Get member with auth");
		MemberVO member = memberService.getMemberWithAuth(id);
		
		model.addAttribute("member", member);
		
		return "/member/memberModify";
	}
	
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	@PostMapping("/modify")
	public String modifyMember(MemberVO member, Criteria cri) {
		memberService.modifyMember(member);
		
		return "redirect:/member/list" + cri.getListLink() ;
	}
}
