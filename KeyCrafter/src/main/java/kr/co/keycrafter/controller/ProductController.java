package kr.co.keycrafter.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.keycrafter.domain.ProductAttachVO;
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
	public String listProduct(Model model) {
		List<ProductVO> list = productService.getProductList();
		
		model.addAttribute("list", list);
		
		return "/product/productList";
	}
	
	@GetMapping("/test")
	public void listTest(Model model) {
		log.info("List Products......");
		List<ProductVO> list = productService.getProductList();
		
		list.forEach(obj -> log.info(obj.getPName()));
		
		model.addAttribute("list", list);
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/insert")
	public String insert(ProductVO product, RedirectAttributes rttr) {
		log.info("Insert product......");
		/*
		if (product.getAttachList() != null) {
			product.getAttachList().forEach(attach -> log.info(attach));
		}
		*/
		
		// 상품 이미지가 없을 경우 기본 이미지 설정
		if (product.getAttachList() == null || product.getAttachList().size() <= 0) {
			List<ProductAttachVO> attachList = new ArrayList<>();
			ProductAttachVO attachDefault = new ProductAttachVO();
			
			attachDefault.setUuid("no");
			attachDefault.setUploadPath("default");
			attachDefault.setFileName("image.jpg");
			attachDefault.setPid(product.getPid());
			attachDefault.setMainImage('T');
			
			attachList.add(attachDefault);
			product.setAttachList(attachList);
		}
		
		log.info(product);
		
		int resultPid = productService.insertProduct(product);
		
		rttr.addFlashAttribute("result", resultPid);
		log.info("result: " + resultPid);

		return "redirect:/product/list";
	}
	
	@GetMapping("/temp")
	public String getProduct() {
		return "/product/productSingle";
	}
}
