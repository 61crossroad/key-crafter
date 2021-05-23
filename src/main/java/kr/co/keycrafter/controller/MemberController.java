package kr.co.keycrafter.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.PageDTO;
import kr.co.keycrafter.service.MemberService;
import kr.co.keycrafter.service.OauthService;

import static kr.co.keycrafter.domain.Const.*;

@Log4j
@AllArgsConstructor
@RequestMapping("/member/*")
@Controller
public class MemberController {
	private MemberService memberService;
	private OauthService oauthService;
	
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
	
	@GetMapping("/register/{serviceName}")
	public String registerOauth(HttpServletRequest request, @PathVariable String serviceName, Model model) {
		String state = oauthService.generateState(serviceName);
		request.getSession().setAttribute("storedState_" + serviceName, state);
		
		String redirectRequest = "https://nid.naver.com/oauth2.0/authorize?client_id="
				+ NaverClientID + "&response_type=code&redirect_uri="
				+ NaverCallbackURL + "&state=" + state;
		
		model.addAttribute("redirectRequest", redirectRequest);
		
		return "/member/oauthRedirect";
	}
	
	@GetMapping("/register/{serviceName}/callback")
	public String callbackNaver(HttpServletRequest request, @PathVariable String serviceName, Model model) {
		// CSRF 방지를 위한 상태 토큰 검증 검증
		// 세션 또는 별도의 저장 공간에 저장된 상태 토큰과 콜백으로 전달받은 state 파라미터의 값이 일치해야 함

		// 콜백 응답에서 state 파라미터의 값을 가져옴
		String state = request.getParameter("state");

		// 세션 또는 별도의 저장 공간에서 상태 토큰을 가져옴
		String storedState = (String) request.getSession().getAttribute("storedState_" + serviceName);
		
		log.info("[Got Naver callback] state : " + state);
		log.info("[Got Naver callback] storedState : " + storedState);

		if( !state.equals( storedState ) ) {
		    //return RESPONSE_UNAUTHORIZED; //401 unauthorized
			log.info("401 unauthorized");
			model.addAttribute("callbackResult", "401 unauthorized");
		} else {
		    //Return RESPONSE_SUCCESS; //200 success
			log.info("200 authorized");
			model.addAttribute("callbackResult", "200 authorized");
		}
		
		return "/member/callback";
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
