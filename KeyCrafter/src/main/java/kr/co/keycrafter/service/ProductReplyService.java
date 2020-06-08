package kr.co.keycrafter.service;

import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.ProductReplyPageDTO;

public interface ProductReplyService {
	public ProductReplyVO insertReply(ProductReplyVO reply);
	
	public int deleteReply(ProductReplyVO reply);
	
	public int deleteAllReply(int pid);
	
	public ProductReplyPageDTO getReplyList(int pid, int page);
}
