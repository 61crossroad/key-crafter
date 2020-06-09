package kr.co.keycrafter.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;

import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.ProductVO;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/cart/*")
@Controller
public class CartController {
	
	@PostMapping(value = "/add",
			consumes = "application/json")
	@ResponseBody
	public ResponseEntity<String> insertCart(@RequestBody ProductVO product, HttpSession session) {
		log.info("Add product to cart: " + product.getPid());
		// log.info(product);
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartList");
		// log.info(cartList);
		
		boolean flag = false;
		
		if (cartList == null) {
			cartList = new ArrayList<ProductVO>();
			cartList.add(product);
		}
		else {
			for (int i = 0; i < cartList.size(); i++) {
				ProductVO cart = cartList.get(i);
				
				if (cart.getPid() == product.getPid()) {
					cart.setQuantity(cart.getQuantity() + product.getQuantity());
					flag = true;
				}
			}
			
			if (flag == false) {
				cartList.add(product);
			}
		}
		
		// log.info(cartList);
		
		session.setAttribute("cartList", cartList);
		
		return new ResponseEntity<>("success", HttpStatus.OK);
	}
	
	@PutMapping("/update")
	@ResponseBody
	public ResponseEntity<String> updateCart(@RequestParam("pid") int pid, @RequestParam("quantity") int quantity, HttpSession session) {
		log.info("Update cart");
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartList");
		// log.info(cartList);
		
		for (int i = 0; i < cartList.size(); i++) {
			ProductVO product = cartList.get(i);
			if (product.getPid() == pid) {
				if (quantity == 0) {
					cartList.remove(i);
				}
				else {
					product.setQuantity(quantity);
				}
			}
		}
		
		session.setAttribute("cartList", cartList);
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
	}
	
	@GetMapping("/list")
	public String getCartList(@ModelAttribute("cri") Criteria cri, HttpSession session) {
		log.info("Cart list page");
		
		return "/cart/cartList";
	}
	
	@PostMapping("/addList")
	public String insertThenListCart(@ModelAttribute("cri") Criteria cri, ProductVO product, HttpSession session) {
		log.info("Insert product then list cart");
		// log.info(product);
		
		List<ProductVO> cartList = (List<ProductVO>)session.getAttribute("cartList");
		
		boolean flag = false;
		
		if (cartList == null) {
			cartList = new ArrayList<ProductVO>();
			cartList.add(product);
		}
		else {
			for (int i = 0; i < cartList.size(); i++) {
				ProductVO cart = cartList.get(i);
				
				if (cart.getPid() == product.getPid()) {
					cart.setQuantity(cart.getQuantity() + product.getQuantity());
					flag = true;
				}
			}
			
			if (flag == false) {
				cartList.add(product);
			}
		}
		
		// log.info(cartList);
		
		session.setAttribute("cartList", cartList);
		
		return "redirect:/cart/list";
	}
}
