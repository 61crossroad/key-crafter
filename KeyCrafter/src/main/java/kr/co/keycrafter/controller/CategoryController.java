package kr.co.keycrafter.controller;

import java.util.List;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.RequestBody;

import lombok.extern.log4j.Log4j;
import lombok.AllArgsConstructor;

import kr.co.keycrafter.domain.CategoryVO;
import kr.co.keycrafter.service.CategoryService;

@Log4j
@AllArgsConstructor
@RestController
@RequestMapping("/category")
public class CategoryController {
	private CategoryService categoryService;
	
	@GetMapping(value = "/list",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> list() {
		log.info("Get category list...... ");
		
		return new ResponseEntity<List<CategoryVO>>(categoryService.selectCategoryList(), HttpStatus.OK);
	}
	
	@GetMapping(value="/product/{pid}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<CategoryVO>> listForProduct(@PathVariable("pid") int pid) {
		return new ResponseEntity<List<CategoryVO>>(categoryService.selectCategoryForProduct(pid), HttpStatus.OK);
	}
	
	@PostMapping(value = "/insert",
			consumes = "text/plain")
	public void insert(@RequestBody String catName) {
		log.info("Insert category: " + catName);
		
		categoryService.insertCategory(catName);
	}
	
	@PutMapping(value = "/update",
			consumes = "application/json",
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> update(@RequestBody CategoryVO category) {
		log.info("Update Category");
		log.info(category);
		
		int result = categoryService.updateCategory(category);
		
		return result == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@DeleteMapping(value = "/delete/{catnum}",
			produces = MediaType.TEXT_PLAIN_VALUE)
	public ResponseEntity<String> delete(@PathVariable("catnum") int catNum) {
		log.info("Delete category: " + catNum);
		
		return categoryService.deleteCategory(catNum) == 1
				? new ResponseEntity<>("success", HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
}
