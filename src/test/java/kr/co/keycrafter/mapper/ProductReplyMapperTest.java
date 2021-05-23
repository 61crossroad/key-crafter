package kr.co.keycrafter.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.mapper.ProductReplyMapper;
import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.Criteria;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class ProductReplyMapperTest {
	@Setter(onMethod_ = @Autowired)
	private ProductReplyMapper productReplyMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	@Test
	public void getReply() {
		log.info(productReplyMapper.selectReply(14));
	}
	
	/*
	@Test
	public void initReply() {
		ProductReplyVO reply = new ProductReplyVO();
		reply.setPid(10);
		reply.setLft(1);
		reply.setRgt(2);
		
		productReplyMapper.insertReply(reply);
	}
	
	@Test
	public void getChildren() {
		List<ProductReplyVO> replyList = productReplyMapper.selectChildren(11, 15);
		
		replyList.forEach(reply -> log.info(reply));
	}

	@Test
	public void getList() {
		List<ProductReplyVO> replyList = productReplyMapper.selectList(2);
		
		replyList.forEach(reply -> log.info(reply));
	}
	
	@Test
	public void setReplies() {
		Criteria cri = new Criteria(1, 20, 1);
		
		List<ProductVO> productList = productMapper.getProductListWithPaging(cri);
		
		productList.forEach(product -> {
			productReplyMapper.setReply(product.getPid());
		});
	}
	*/
}
