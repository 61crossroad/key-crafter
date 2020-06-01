package kr.co.keycrafter.service;

import java.util.List;
import java.util.UUID;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import static kr.co.keycrafter.domain.Const.*;
import kr.co.keycrafter.domain.ProductAttachVO;
import kr.co.keycrafter.domain.ProductVO;
import kr.co.keycrafter.domain.CategoryVO;
import kr.co.keycrafter.domain.ProductReplyVO;
import kr.co.keycrafter.domain.Criteria;
import kr.co.keycrafter.mapper.ProductMapper;
import kr.co.keycrafter.mapper.ProductAttachMapper;
import kr.co.keycrafter.mapper.CategoryMapper;
import kr.co.keycrafter.mapper.ProductReplyMapper;

import lombok.extern.log4j.Log4j;
import lombok.Setter;

@Log4j
@Service
public class ProductServiceImpl implements ProductService {
	@Setter(onMethod_ = @Autowired)
	private ProductMapper productMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductAttachMapper productAttachMapper;
	
	@Setter(onMethod_ = @Autowired)
	private CategoryMapper categoryMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductReplyMapper productReplyMapper;
	
	@Transactional
	@Override
	public int insertProduct(ProductVO product) {
		log.info("Insert product");
		
		// 상품 이미지가 없을 경우 기본 이미지 설정
		if (product.getAttachList() == null || product.getAttachList().size() <= 0) {
			List<ProductAttachVO> attachList = new ArrayList<>();
			ProductAttachVO attachDefault = new ProductAttachVO();
			
			UUID uuid = UUID.randomUUID();
			attachDefault.setUuid(uuid.toString());
			attachDefault.setUploadPath("default");
			attachDefault.setFileName("no_image.jpg");
			attachDefault.setPid(product.getPid());
			attachDefault.setMainImage('T');
			
			attachList.add(attachDefault);
			product.setAttachList(attachList);
		}
		
		productMapper.insertSelectKeyProduct(product);
		int resultPid = product.getPid();
		
		// product_attach 테이블에 첨부파일 insert
		product.getAttachList().forEach(attach -> {
			attach.setPid(resultPid);
			log.info(attach);
			productAttachMapper.insertAttach(attach);
		});
		
		// 루트 댓글 생성
		ProductReplyVO reply = new ProductReplyVO();
		reply.setPid(resultPid);
		reply.setLft(1);
		reply.setRgt(2);
		
		productReplyMapper.insertReply(reply);
		
		return resultPid;
	}

	@Override
	public List<ProductVO> getProductList(Criteria cri) {
		// return productMapper.getProductList();
		return productMapper.getProductListWithPaging(cri);
	}
	
	@Override
	public int getTotalCount(Criteria cri) {
		return productMapper.getTotalCount(cri);
	}
	
	@Override
	public ProductVO getProduct(int pid) {
		log.info("Get single product");
		
		ProductVO product = productMapper.getProduct(pid);
		List<CategoryVO> category = categoryMapper.selectCategoryPath(product.getCatNum());
		
		category.remove(0);
		product.setCategoryList(category);
		
		return product;
	}
	
	@Override
	public List<ProductAttachVO> getAttachForProduct(int pid) {
		log.info("Get attaches for product: " + pid );
		return productAttachMapper.getAttachForProduct(pid);
	}

	@Transactional
	@Override
	public int updateProduct(ProductVO product) {
		log.info("Update product");
		
		int result;
		int pid = product.getPid();
		
		// 모든 첨부파일을 DB에서  삭제
		result = productAttachMapper.deleteAllAttach(pid);
		log.info("Delete all attaches: " + result);
		
		result = productMapper.updateProduct(product);
		log.info("Product updated");
		
		// 첨부파일이 모두 삭제되었을때 기본 이미지 삽입
		if (product.getAttachList() == null || product.getAttachList().size() <= 0) {
			log.info("Default image added");
			
			List<ProductAttachVO> attachList = new ArrayList<>();
			ProductAttachVO attachDefault = new ProductAttachVO();
			
			UUID uuid = UUID.randomUUID();
			attachDefault.setUuid(uuid.toString());
			attachDefault.setUploadPath("default");
			attachDefault.setFileName("no_image.jpg");
			attachDefault.setPid(product.getPid());
			attachDefault.setMainImage('T');
			
			attachList.add(attachDefault);
			product.setAttachList(attachList);
		}
		
		// 상품 정보에 첨부파일이 있으면 DB의 product_attach 테이블에 파일 정보 insert
		product.getAttachList().forEach(attach -> {
			attach.setPid(pid);
			log.info("Attach list");
			log.info(attach);
			productAttachMapper.insertAttach(attach);
		});
		
		return productMapper.updateProduct(product);
	}
	
	@Transactional
	@Override
	public int deleteProduct(int pid) {
		int result = productMapper.getOrderCount(pid);
		
		if (result > 0) {
			return -1;
		}
		
		List<ProductAttachVO> attachList = productAttachMapper.getAttachForProduct(pid);
		
		// 모든 첨부파일을 DB에서 삭제
		productAttachMapper.deleteAllAttach(pid);
		
		// 모든 댓글 삭제
		productReplyMapper.deleteAllReply(pid);
		
		// 상품 삭제
		result = productMapper.deleteProduct(pid);
		
		// 모든 첨부파일을 폴더에서 삭제
		if (result > 0) {
			deleteAttachByPath(attachList);
		}
		
		return result;
	}
	
	private void deleteAttachByPath(List<ProductAttachVO> attachList) {
		log.info("Delete all attaches...");
		log.info(attachList);
		
		attachList.forEach(attach -> {
			try {
				if (!attach.getUploadPath().equals(defaultPath)) {
					Path originalFile, mediumFile, smallFile; 
					
					originalFile = Paths.get(uploadRoot, attach.getUploadPath(), attach.getUuid() + "_" + attach.getFileName());
					mediumFile = Paths.get(uploadRoot, attach.getUploadPath(), "m_" + attach.getUuid() + "_" + attach.getFileName());
					smallFile = Paths.get(uploadRoot, attach.getUploadPath(), "s_" + attach.getUuid() + "_" + attach.getFileName());
					
					log.info(originalFile);
					log.info(smallFile);
					
					Files.delete(originalFile);
					Files.delete(mediumFile);
					Files.delete(smallFile);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		});
	}
}
