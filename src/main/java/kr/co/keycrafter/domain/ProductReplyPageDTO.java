package kr.co.keycrafter.domain;

import java.util.List;

import kr.co.keycrafter.domain.ProductReplyVO;

import lombok.AllArgsConstructor;
import lombok.Data;

@AllArgsConstructor
@Data
public class ProductReplyPageDTO {
	private int count;
	private int rootRnum;
	private List<ProductReplyVO> replyList;
}
