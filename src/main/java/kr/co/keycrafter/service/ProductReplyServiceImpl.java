package kr.co.keycrafter.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.security.crypto.password.PasswordEncoder;

import kr.co.keycrafter.mapper.ProductReplyMapper;
import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.ProductReplyPageDTO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@AllArgsConstructor
@Service
public class ProductReplyServiceImpl implements ProductReplyService {
	private ProductReplyMapper productReplyMapper;
	private PasswordEncoder passwordEncoder;

	@Transactional
	@Override
	public ProductReplyVO insertReply(ProductReplyVO reply) {
		log.info("Insert reply");
		log.info(reply);
		
		if (reply.getPassword() != null) {
			reply.setPassword(passwordEncoder.encode(reply.getPassword()));
		}
		
		List<ProductReplyVO> childrenList = productReplyMapper.selectChildren(reply);
		
		if (childrenList.size() == 1) {
			int left = childrenList.get(0).getLft();
			
			productReplyMapper.updateLeft(reply.getPid(), left, 2);
			productReplyMapper.updateRight(reply.getPid(), left, 2);
			
			reply.setLft(left + 1);
			reply.setRgt(left + 2);
			
			productReplyMapper.insertReply(reply);
		}
		else {
			int right = childrenList.get(childrenList.size() - 1).getRgt();
			
			productReplyMapper.updateLeft(reply.getPid(), right, 2);
			productReplyMapper.updateRight(reply.getPid(), right, 2);
			
			reply.setLft(right + 1);
			reply.setRgt(right + 2);
			
			productReplyMapper.insertReply(reply);
		}
		
		reply = productReplyMapper.selectReply(reply.getRnum());
		
		return reply;
	}
	
	@Override
	public int deleteReply(ProductReplyVO reply) {
		log.info("Delete reply......");
		log.info(reply);
		
		int result = 0;
		
		ProductReplyVO originReply = productReplyMapper.selectReply(reply.getRnum());
		
		reply.setContent("삭제된 댓글입니다.");
		reply.setDeleted("Y");
		
		if (reply.getPassword() != null 
				&& passwordEncoder.matches(reply.getPassword(), originReply.getPassword())) {
			reply.setPassword(passwordEncoder.encode(reply.getPassword()));
			
			result = productReplyMapper.deleteReply(reply);
		}
		
		else if (reply.getPassword() == null && reply.getId().equals(originReply.getId())) {
			result = productReplyMapper.deleteReply(reply);
		}
		
		return result;
	}
	
	@Override
	public int deleteAllReply(int pid) {
		return productReplyMapper.deleteAllReply(pid);
	}

	@Override
	public ProductReplyPageDTO getReplyList(int pid, int page) {
		int count = productReplyMapper.selectCount(pid);
		int startNum, endNum;
		List<ProductReplyVO> fullList = productReplyMapper.selectList(pid);
		List<ProductReplyVO> pageList = new ArrayList<ProductReplyVO>();
		
		if (page == 0) {
			if (count > 1) {
				endNum = (int)Math.ceil((double)(count - 1) / 10) * 10;
				startNum = endNum - 9;
				endNum = (count - 1 < endNum ? count - 1 : endNum);
			}
			else {
				startNum = 1;
				endNum = 0;
			}
		}
		else {
			startNum = (page - 1) * 10 + 1;
			endNum = (count - 1 < page * 10 ? count - 1 : page * 10);
		}
		
		// log.info("Check start, end num: " + startNum + " " + endNum);
		
		for (int i = startNum; i <= endNum; i ++) {
			pageList.add(fullList.get(i));
		}
		
		return new ProductReplyPageDTO(count - 1, fullList.get(0).getRnum(), pageList);
	}
}
