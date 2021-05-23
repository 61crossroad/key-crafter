package kr.co.keycrafter.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.keycrafter.domain.OrderVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.domain.OrderStatusDTO;

public interface OrderMapper {
	public void insertOrder(OrderVO order);
	
	public void insertOrderProduct(@Param("onum") int onum, @Param("pid") int pid, @Param("quantity") int quantity);
	
	public int updateOrder(OrderVO order);
	
	public int cancelOrder(OrderVO order);
	
	public List<OrderVO> selectOrderList(Criteria cri);
	
	public int selectOrderCount(Criteria cri);
	
	public OrderVO selectOrder(int onum);
	
	public List<OrderStatusDTO> selectStatusList();
}
