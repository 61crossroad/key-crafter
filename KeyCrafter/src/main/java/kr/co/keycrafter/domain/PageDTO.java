package kr.co.keycrafter.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	private static final int PAGE_COUNT = 5;
	
	private int startPage;
	private int endPage;
	private boolean prev, next;
	
	private int total;
	private Criteria cri;
	
	public PageDTO(Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int) (Math.ceil(cri.getPage() / (double)PAGE_COUNT)) * PAGE_COUNT;
		this.startPage = this.endPage - PAGE_COUNT + 1;
		
		int realEndPage = (int) (Math.ceil((double)total / cri.getShow()));
		
		// if (realEndPage < this.endPage && realEndPage != 0) {
		if (realEndPage < this.endPage) {
			this.endPage = realEndPage;
		}
		
		if (this.cri.getPage() > this.endPage && this.endPage != 0) {
			this.cri.setPage(this.endPage);
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEndPage;
	}
}
