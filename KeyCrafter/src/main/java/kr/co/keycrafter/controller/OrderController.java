package kr.co.keycrafter.controller;

import java.util.List;
import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderStatusDTO;
import kr.co.keycrafter.domain.OrderVO;
import kr.co.keycrafter.domain.PageDTO;
import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.service.OrderService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/order/*")
@Controller
public class OrderController {
	private OrderService orderService;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public String register(@ModelAttribute("cri") Criteria cri, Model model, HttpSession session) {
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartList");
		model.addAttribute("productList", cartList);
		
		return "/order/orderRegister";
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/insert")
	public String insert(@ModelAttribute("cri") Criteria cri, OrderVO order, HttpSession session) {
		log.info("Insert order");
		// log.info(order);
		
		int onum = orderService.insertOrder(order);
		
		session.removeAttribute("cartList");
		
		return "redirect:/order/confirm?onum=" + onum;
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/confirm")
	public String confirm(@ModelAttribute("cri") Criteria cri, @RequestParam("onum") int onum, Model model) {
		log.info("Confirm order");
		
		OrderVO orderResult = orderService.getOrder(onum);
		model.addAttribute("order", orderResult);
		
		return "/order/orderConfirm";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String modify(@ModelAttribute("cri") Criteria cri, @RequestParam("onum") int onum, Model model, Authentication auth) {
		log.info("Order modify page");
		// log.info(cri);
		
		if (hasAuthority(cri, auth)) {
			OrderVO order = orderService.getOrder(onum);
			model.addAttribute("order", order);
			
			List<OrderStatusDTO> statusList = orderService.getStatusList();
			model.addAttribute("statusList", statusList);
			
			return "/order/orderModify";
		}
		
		else {
			return "/errorPage";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/update")
	public String update(Criteria cri, OrderVO order, RedirectAttributes rttr, Authentication auth) {
		log.info("Update order");
		// log.info(cri);
		// log.info(order);
		
		if (hasAuthority(cri, auth)) {
			int updateResult = orderService.updateOrder(order);
			rttr.addFlashAttribute("updateResult", updateResult);
			
			return "redirect:/order/list" + cri.getListLink();
		}
		
		else {
			return "/errorPage";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/cancel")
	public String cancel(Criteria cri, @RequestParam("onum") int onum, Authentication auth) {
		log.info("Cancel order");
		// log.info(cri);
		
		if (hasAuthority(cri, auth)) {
			orderService.cancelOrder(onum);
			
			return "redirect:/order/list" + cri.getListLink();
		}
		
		else {
			return "/errorPage";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/list")
	public String list(Criteria cri, Model model, Authentication auth) {
		log.info("Get order list");
		// log.info(cri);
		
		if (hasAuthority(cri, auth)) {
			int total = orderService.getOrderCount(cri);
			
			PageDTO pageDTO = new PageDTO(cri, total);
			Criteria realCri = pageDTO.getCri();
			
			List<OrderVO> orderList = orderService.getOrderList(realCri);
			
			model.addAttribute("orderList", orderList);
			model.addAttribute("pageMaker", pageDTO);
			
			return "/order/orderList";
		}
		
		else {
			return "/errorPage";
		}
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/get")
	public String get(@ModelAttribute("cri") Criteria cri, @RequestParam("onum") int onum, Model model) {
		log.info("Get single order: " + onum);
		// log.info(cri);
		
		OrderVO order = orderService.getOrder(onum);
		model.addAttribute("order", order);
		
		return "/order/orderSingle";
	}
	
	private boolean hasAuthority(Criteria cri, Authentication authentication) {
		UserDetails user = (UserDetails) authentication.getPrincipal();
		List<GrantedAuthority> authList = new ArrayList<GrantedAuthority>(user.getAuthorities());
		
		List<String> keywordList = cri.getKeyword();
		List<String> typeList = cri.getType();
		
		for (int i = 0; i < typeList.size(); i++) {
			if (typeList.get(i).contains("I") && keywordList.get(i).equals(user.getUsername())) {
				return true;
			}
		}
		
		for (int i = 0; i < authList.size(); i++) {
			if (authList.get(i).getAuthority().contains("MEMBER") || authList.get(i).getAuthority().contains("ADMIN")) {
				return true;
			}
		}
		
		return false;
	}
}
