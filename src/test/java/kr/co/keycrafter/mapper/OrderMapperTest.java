package kr.co.keycrafter.mapper;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.mapper.OrderMapper;
import kr.co.keycrafter.domain.OrderVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderStatusDTO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class OrderMapperTest {
	@Setter(onMethod_ = @Autowired)
	private OrderMapper orderMapper;
	
	// @Test
	public void getStatusList() {
		List<OrderStatusDTO> orderStatus = orderMapper.selectStatusList();
		
		orderStatus.forEach(status -> {
			log.info(status);
		});
	}
	
	// @Test
	public void getOrderCount() {
		Criteria cri = new Criteria();
		
		String[] keyword = new String[1];
		keyword[0] = "aaa";
		
		String[] type = new String[1];
		type[0] = "IN";
		
		/*
		cri.setKeyword(keyword);
		cri.setType(type);
		*/
		
		int count = orderMapper.selectOrderCount(cri);
		
		log.info("Order Count: " + count);
		
	}
	
	@Test
	public void getOrderList() {
		Criteria cri = new Criteria();

		/*
		cri.setPage(1);
		cri.setShow(3);
		
		String keyword = "aaa";
		String type = "IN";
		
		List<String> keywordList = cri.getKeyword();
		log.info("Keyword list");
		log.info(keywordList);
		keywordList.add(keyword);
		cri.setKeyword(keywordList);
		log.info(cri.getKeyword());
		
		List<String> typeList = cri.getType();
		typeList.add(type);
		cri.setType(typeList);
		
		cri.setKeyword(keyword);
		cri.setType(type);
		*/
		
		List<OrderVO> orderList = orderMapper.selectOrderList(cri);
		orderList.forEach(order -> log.info(order));
	}
	
	// @Test
	public void update() {
		int onum = 7;
		OrderVO order = orderMapper.selectOrder(onum);
		
		order.setName("바니 케슬");
		orderMapper.updateOrder(order);
		
		log.info(orderMapper.selectOrder(onum));
	}
	// @Test
	public void insert() {
		OrderVO order = new OrderVO();
		order.setId("aaa");
		order.setName("줄리안 라지");
		order.setContact("01012345678");
		order.setAddress("teset");
		order.setZipCode("1234");
		order.setNote("test order");
		order.setPayMethod("CD");
		order.setPayOwner("줄리안 라지");
		order.setPayNum("1234789234");
		order.setPayProvider("국민은행");
		order.setStatus(1);
		
		orderMapper.insertOrder(order);
		
		int onum = order.getOnum();
		
		log.info(orderMapper.selectOrder(onum));
	}
}
