package kr.co.keycrafter.service;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderVO;
import kr.co.keycrafter.service.OrderService;
import kr.co.keycrafter.mapper.ProductMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class OrderServiceTest {
	@Setter(onMethod_ = @Autowired)
	private OrderService orderService;
	
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;

	@Test
	public void getStatusList() {
		/*
		List<String> statusList = orderService.getStatusList();
		
		for (String status : statusList) {
			log.info(status);
		}
		*/
	}
	
	// @Test
	public void getOrder() {
		orderService.getOrder(7);
	}
	
	// @Test
	public void getList() {
		Criteria cri = new Criteria();
		
		/*
		String[] keyword = new String[1];
		keyword[0] = "줄리안 라지";
		
		String[] type = new String[1];
		type[0] = "IN";
		
		cri.setKeyword(keyword);
		cri.setType(type);
		*/
		
		orderService.getOrderList(cri);
		/*
		orderList.forEach(order -> {
			log.info(order);
		});
		*/
	}
	
	// @Test
	public void update() {
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO product;
		
		product = productMapper.getProductSimple(2);
		product.setQuantity(4);
		productList.add(product);
		
		product = productMapper.getProductSimple(6);
		product.setQuantity(4);
		productList.add(product);

		/*
		OrderVO order = new OrderVO();
		
		order.setId("aaa");
		order.setName("찰리 파커");
		order.setContact("01012345678");
		order.setAddress("teset");
		order.setZipCode("1234");
		order.setNote("test order");
		order.setPayMethod("CD");
		order.setPayOwner("줄리안 라지");
		order.setPayNum("1234789234");
		order.setPayProvider("국민은행");
		order.setStatus(1);
		*/
		OrderVO order = orderService.getOrder(8);
		
		order.setName("찰리 파커");
		order.setProductList(productList);
		
		orderService.updateOrder(order);
	}
	
	// @Test
	public void insert() {
		List<ProductVO> productList = new ArrayList<ProductVO>();
		ProductVO product;
		
		product = productMapper.getProductSimple(2);
		product.setQuantity(5);
		productList.add(product);
		
		product = productMapper.getProductSimple(6);
		product.setQuantity(5);
		productList.add(product);
		
		productList.forEach(obj -> log.info(obj));
		
		OrderVO order = new OrderVO();
		
		order.setId("aaa");
		order.setName("조 패스");
		order.setContact("01012345678");
		order.setAddress("teset");
		order.setZipCode("1234");
		order.setNote("test order");
		order.setPayMethod("CD");
		order.setPayOwner("줄리안 라지");
		order.setPayNum("1234789234");
		order.setPayProvider("국민은행");
		order.setStatus(1);
		order.setProductList(productList);
		
		int onum = orderService.insertOrder(order);
		
		log.info(orderService.getOrder(onum));
	}
}
