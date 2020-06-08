package kr.co.keycrafter.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.ProductReplyPageDTO;
import kr.co.keycrafter.service.ProductReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@RestController
@RequestMapping("/preply")
public class ProductReplyController {
	private ProductReplyService replyService;
	
	@PostMapping(value = "/insert",
			consumes = "application/json")
	public ResponseEntity<String> insertReply(@RequestBody ProductReplyVO reply) {
		log.info("Insert reply");
		// log.info(reply);
		
		ProductReplyVO resultReply = replyService.insertReply(reply);
		// log.info(resultReply);
		
		return resultReply != null
				? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value = "/list/{pid}/{page}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<ProductReplyPageDTO> getList(@PathVariable("pid") int pid, @PathVariable("page") int page) {
		log.info("Get reply list: " + pid + ", page: " + page);
		ProductReplyPageDTO productReplyPage = replyService.getReplyList(pid, page);
		
		// productReplyPage.getReplyList().forEach(reply -> log.info(reply));
		
		return productReplyPage != null
				? new ResponseEntity<ProductReplyPageDTO>(productReplyPage, HttpStatus.OK)
						: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@PostMapping(value = "/delete",
			consumes = "application/json")
	public ResponseEntity<String> deleteReply(@RequestBody ProductReplyVO reply) {
		log.info("Delete reply: ");
		
		int deleteResult = replyService.deleteReply(reply);
		
		if (deleteResult == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		}
		
		else if (deleteResult == 0) {
			return new ResponseEntity<String>("forbidden", HttpStatus.OK);
		}
		
		else {
			return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
