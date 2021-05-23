package kr.co.keycrafter.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.co.keycrafter.mapper.OrderMapper;
import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderStatusDTO;
import kr.co.keycrafter.domain.OrderVO;
import kr.co.keycrafter.domain.ProductVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class OrderServiceImpl implements OrderService {
	private OrderMapper orderMapper;
	private ProductMapper productMapper;
	
	@Transactional
	@Override
	public int insertOrder(OrderVO order) {
		log.info("Insert order");
		
		orderMapper.insertOrder(order);
		int onum = order.getOnum();
		
		order.getProductList().forEach(product -> {
			orderMapper.insertOrderProduct(onum, product.getPid(), product.getQuantity());
		});
		
		return onum;
	}

	@Transactional
	@Override
	public int updateOrder(OrderVO order) {
		log.info("Update order");
		
		int result = orderMapper.updateOrder(order);
		
		return result;
	}

	@Override
	public int cancelOrder(int onum) {
		OrderVO order = new OrderVO();
		order.setOnum(onum);
		order.setStatus(5); // 5: "주문 취소"
		
		return orderMapper.cancelOrder(order);
	}

	@Override
	public List<OrderVO> getOrderList(Criteria cri) {
		log.info("Select order list");
		
		List<OrderVO> orderList = orderMapper.selectOrderList(cri);
		
		orderList.forEach(order -> {
			List<ProductVO> productList = productMapper.getProductListForOrder(order.getOnum());
			order.setProductList(productList);
		});
		
		orderList.forEach(order -> {
			log.info(order);
		});
		
		return orderList;
	}
	
	@Override
	public int getOrderCount(Criteria cri) {
		return orderMapper.selectOrderCount(cri);
	}

	@Override
	public OrderVO getOrder(int onum) {
		log.info("Select single order");
		
		OrderVO order = orderMapper.selectOrder(onum);
		List<ProductVO> productList = productMapper.getProductListForOrder(onum);
		
		order.setProductList(productList);
		
		log.info(order);
		
		return order;
	}
	
	@Override
	public List<OrderStatusDTO> getStatusList() {
		return orderMapper.selectStatusList();
	}
}
