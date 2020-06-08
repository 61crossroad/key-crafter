package kr.co.keycrafter.service;

import java.util.List;

import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderStatusDTO;
import kr.co.keycrafter.domain.OrderVO;

public interface OrderService {
	public int insertOrder(OrderVO order);
	
	public int updateOrder(OrderVO order);
	
	public int cancelOrder(int onum);
	
	public List<OrderVO> getOrderList(Criteria cri);
	
	public int getOrderCount(Criteria cri);
	
	public OrderVO getOrder(int onum);
	
	public List<OrderStatusDTO> getStatusList();
}
