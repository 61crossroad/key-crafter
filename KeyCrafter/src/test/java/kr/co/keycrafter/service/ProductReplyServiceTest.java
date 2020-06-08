package kr.co.keycrafter.service;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.service.ProductReplyService;
import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.ProductReplyPageDTO;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductReplyServiceTest {
	@Setter(onMethod_ = @Autowired)
	private ProductReplyService productReplyService;
	
	@Test
	public void deleteReply() {
		ProductReplyVO reply = new ProductReplyVO();
		
		reply.setRnum(89);
		reply.setId("ddd");
		
		int result = productReplyService.deleteReply(reply);
		
		log.info("Delete reply result: " + result);
	}

	/*
	@Test
	public void updateReply() {
		ProductReplyVO reply = new ProductReplyVO();
		reply.setRnum(15);
		reply.setContent("댓글 수정 테스트");
		
		// productReplyService.updateReply(reply);
		
		productReplyService.deleteReply(reply);
	}
	
	@Test
	public void getList() {
		ProductReplyPageDTO productReplyPage = productReplyService.getReplyList(11, 2); 
		List<ProductReplyVO> list = productReplyPage.getReplyList();
		
		log.info("Total Count: " + productReplyPage.getCount());
		list.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void insertReply() {
		ProductReplyVO reply = new ProductReplyVO();
		
		reply.setRnum(3);
		reply.setPid(11);
		reply.setId("aaa");
		reply.setContent("회원 댓글 테스트");
		
		productReplyService.insertReply(reply);
	}
	*/
}
