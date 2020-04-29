package kr.co.keycrafter.controller;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.PageDTO;
import kr.co.keycrafter.service.ProductService;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
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
	public String register(@ModelAttribute("cri") Criteria cri) {
		
		return "/product/productRegister";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/insert")
	public String insertProduct(Criteria cri, ProductVO product, RedirectAttributes rttr) {
		log.info("Insert product......");
		log.info(product);
		
		int insertResult = productService.insertProduct(product);
		log.info("result: " + insertResult);
		
		if (insertResult > 0) {
			rttr.addFlashAttribute("insertResult", insertResult);
		}
		
		cri.setPage(1);

		return "redirect:/product/list" + cri.getListLink();
	}
	
	@GetMapping("/list")
	public String listProduct(Criteria cri, Model model) {
		log.info("list: " + cri);
		
		List<ProductVO> list = productService.getProductList(cri);
		int total = productService.getTotalCount(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		return "/product/productList";
	}
	
	@GetMapping("/get")
	public String getProduct(@RequestParam("pid") int pid, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("Get single product...... " + pid);
		
		ProductVO product = productService.getProduct(pid);
		
		model.addAttribute("product", product);
		
		return "/product/productSingle";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/modify")
	public String modifyProduct(@RequestParam("pid") int pid, @ModelAttribute("cri") Criteria cri, Model model) {
		log.info("Modify page");
		ProductVO product = productService.getProduct(pid);
		
		model.addAttribute("product", product);
		
		return "/product/productModify";
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/update")
	public String updateProduct(Criteria cri, ProductVO product, RedirectAttributes rttr) {
		log.info("Update product......");
		log.info(product);
		
		int updateResult;
		if (productService.updateProduct(product) > 0) {
			updateResult = product.getPid();
		}
		else {
			updateResult = 0;
		}
		
		rttr.addFlashAttribute("updateResult", updateResult);
		
		return "redirect:/product/list" + cri.getListLink();
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/delete")
	public String deleteProduct(@RequestParam("pid") int pid, Criteria cri, RedirectAttributes rttr) {
		log.info("Delete Product....... " + pid);
		
		int deleteResult = productService.deleteProduct(pid);
		log.info("deleteResult: " + deleteResult);
		
		if (deleteResult > 0) {
			rttr.addFlashAttribute("deleteResult", pid);
		}
		
		return "redirect:/product/list" + cri.getListLink();
	}
}
