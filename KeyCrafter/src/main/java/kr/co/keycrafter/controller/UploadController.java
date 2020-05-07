package kr.co.keycrafter.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

// import javax.activation.MimetypesFileTypeMap;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.beans.factory.annotation.Autowired;

import static kr.co.keycrafter.domain.Const.*;
import kr.co.keycrafter.domain.ProductAttachVO;
import kr.co.keycrafter.service.ProductService;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@RestController
public class UploadController {
	@Setter(onMethod_ = @Autowired)
	ProductService productService;
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<ProductAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("Upload files......");
		
		List<ProductAttachVO> attachList = new ArrayList<>();
		
		String uploadSubPath = getPath(); // 연/월/일 형식으로 된 폴더 경로
		File uploadFullPath = new File(uploadRoot, uploadSubPath); // 루트/ + 연/월/일
		log.info("Upload path: " + uploadFullPath);
		
		if (uploadFullPath.exists() == false) {
			uploadFullPath.mkdirs();
		}
		
		for (MultipartFile multipartFile : uploadFile) {
			log.info("-----------------------------------");
			log.info("Upload file name: " + multipartFile.getOriginalFilename());
			log.info("Upload file size: " + multipartFile.getSize());
			
			ProductAttachVO attach = new ProductAttachVO();
			String uploadFileName = multipartFile.getOriginalFilename();
			
			// Remove file path for IE
			uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\") + 1);
			log.info("File name only: " + uploadFileName);
			attach.setFileName(uploadFileName);
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" + uploadFileName;
			
			File uploadPathFileName = new File(uploadFullPath, uploadFileName);
			
			try {
				multipartFile.transferTo(uploadPathFileName);

				attach.setUuid(uuid.toString());
				
				attach.setUploadPath(uploadSubPath);
				attachList.add(attach);
				
				// if (checkImageType(uploadPathFileName)) {
					FileOutputStream thumbnailSm = new FileOutputStream(new File(uploadFullPath, "s_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnailSm, 60, 60);
					thumbnailSm.close();
					
					FileOutputStream thumbnailMd = new FileOutputStream(new File(uploadFullPath, "m_" + uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(), thumbnailMd, 600, 600);
					thumbnailMd.close();
					
				// }
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return new ResponseEntity<>(attachList, HttpStatus.OK);
	}
	
	@GetMapping("/show")
	public ResponseEntity<byte[]> getThumbnail(String fileName) {
		// log.info("FileName: " + fileName);
		
		if (fileName.contains("no_image.jpg") && fileName.contains("m_")) {
			fileName = mDefaultPathImage;
		}
		
		else if(fileName.contains("no_image.jpg") && fileName.contains("s_")) {
			fileName = sDefaultPathImage;
		}
		
		File file = new File(uploadRoot, fileName);
		// log.info("file: " + file);
		
		ResponseEntity<byte[]> result = null;
		
		try {
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@GetMapping(value = "/getImage/{pid}",
			produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<ProductAttachVO>> getAttachForProduct(@PathVariable("pid") int pid) {
		log.info("Get images for :" + pid);
		
		return new ResponseEntity<>(productService.getAttachForProduct(pid), HttpStatus.OK);
	}
	
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(@RequestParam("fileName") String fileName) {
		log.info("Delete file: " + fileName);
		
		File file;
		
		try {
			file = new File(uploadRoot, URLDecoder.decode(fileName, "UTF-8"));
			
			file.delete();
			
			String mediumFileName = file.getAbsolutePath().replace("s_", "m_");
			log.info("Medium file name: " + mediumFileName);
			file = new File(mediumFileName);
			file.delete();
			
			String largeFileName = file.getAbsolutePath().replace("m_", "");
			log.info("Large file name: " + largeFileName);
			file = new File(largeFileName);
			file.delete();
		} catch (Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/plain;charset=UTF-8");
		
		return new ResponseEntity<String>("이미지가 삭제되었습니다", header, HttpStatus.OK);
	}
	
	private String getPath() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		
		return str.replace("-", File.separator);
	}
}
