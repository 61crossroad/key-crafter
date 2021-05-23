package kr.co.keycrafter.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kr.co.keycrafter.domain.ProductReplyVO;

public interface ProductReplyMapper {
	public void insertReply(ProductReplyVO reply);
	
	public ProductReplyVO selectReply(int rnum);
	
	public List<ProductReplyVO> selectChildren(ProductReplyVO reply);
	
	public int updateLeft(@Param("pid") int pid, @Param("leftOrRight") int leftOrRight, @Param("amount") int amount);
	
	public int updateRight(@Param("pid") int pid, @Param("leftOrRight") int leftOrRight, @Param("amount") int amount);
	
	public int deleteReply(ProductReplyVO reply);
	
	public int deleteAllReply(int pid);
	
	public int selectCount(int pid);
	
	public List<ProductReplyVO> selectList(int pid);
}
