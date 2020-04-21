package kr.co.keycrafter.controller;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.service.ProductService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RequestMapping("/product/*")
@Controller
public class ProductController {
	ProductService productService;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/register")
	public String register() {
		return "/product/productRegister";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/list")
	public String listProduct() {
		return "/product/productList";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/insert")
	public String insert(ProductVO product, RedirectAttributes rttr) {
		log.info("Insert product!");
		log.info(product);
		/*
		if (product.getAttachList() != null) {
			product.getAttachList().forEach(attach -> log.info(attach));
		}
		*/
		
		/*
		int resultPid = productService.insertProduct(product);
		
		rttr.addFlashAttribute("result", resultPid);
		log.info("result: " + resultPid);
		*/
		return "redirect:/product/register";
	}
	
	@GetMapping("/temp")
	public String getProduct() {
		return "/product/productSingle";
	}
}
