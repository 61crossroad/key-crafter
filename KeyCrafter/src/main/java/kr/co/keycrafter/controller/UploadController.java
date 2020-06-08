package kr.co.keycrafter.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

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
import kr.co.keycrafter.service.S3Storage;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Log4j
@RestController
public class UploadController {
	@Setter(onMethod_ = @Autowired)
	private ProductService productService;
	
	@Setter(onMethod_ = @Autowired)
	private S3Storage s3Client;
	
	@PostMapping(value = "/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
	public ResponseEntity<List<ProductAttachVO>> uploadAjaxPost(MultipartFile[] uploadFile) {
		log.info("Upload files......");
		
		List<ProductAttachVO> attachList = new ArrayList<>();
		
		String uploadSubPath = getPath(); // 연/월/일 형식으로 된 폴더 경로
		File uploadFullPath = new File(UploadRoot, uploadSubPath); // 루트/ + 연/월/일
		log.info("Upload path: " + uploadFullPath);
		
		if (uploadFullPath.exists() == false) {
			uploadFullPath.mkdirs();
		}
		
		// AWS S3 Object VER.
		// S3Storage s3Client = new S3Storage();
		
		for (MultipartFile multipartFile : uploadFile) {
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
			
			try {
				s3Client.upload(uploadFullPath, uploadFileName, multipartFile);
				
				OutputStream os = new ByteArrayOutputStream();
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), os, 60, 60);
				ByteArrayOutputStream baos = (ByteArrayOutputStream) os;
				// @SuppressWarnings("null")
				InputStream input = new ByteArrayInputStream(baos.toByteArray());
				s3Client.upload(uploadFullPath, "s_" + uploadFileName, input);
				
				os = new ByteArrayOutputStream();
				Thumbnailator.createThumbnail(multipartFile.getInputStream(), os, 600, 600);
				baos = (ByteArrayOutputStream) os;
				// @SuppressWarnings("null")
				input = new ByteArrayInputStream(baos.toByteArray());
				s3Client.upload(uploadFullPath, "m_" + uploadFileName, input);
				
				attach.setUuid(uuid.toString());
				attach.setUploadPath(uploadSubPath);
				attachList.add(attach);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
			
			/* LOCAL TEST Ver.
		for (MultipartFile multipartFile : uploadFile) {
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
			*/
			
		return new ResponseEntity<>(attachList, HttpStatus.OK);
	}
	
	@GetMapping("/show")
	public ResponseEntity<byte[]> getThumbnail(String fileName) {
		// log.info("FileName: " + fileName);
		
		if (fileName.contains("no_image.jpg") && fileName.contains("m_")) {
			fileName = DefaultPathImageM;
		}
		
		else if(fileName.contains("no_image.jpg") && fileName.contains("s_")) {
			fileName = DefaultPathImageS;
		}
		
		File file = new File(UploadRoot, fileName);
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
	public ResponseEntity<String> deleteFile(@RequestParam("filePath") String filePath, @RequestParam("fileName") String fileName) {
		log.info("Delete file: " + filePath + File.separator + fileName);
		
		try {
			String decodedFilePath = UploadRoot + File.separator + URLDecoder.decode(filePath, "UTF-8");
			String decodedFileName = URLDecoder.decode(fileName, "UTF-8");
			log.info("Decoded file: " + decodedFilePath + File.separator + decodedFileName);
			s3Client.delete(decodedFilePath, decodedFileName);
			
			decodedFileName = decodedFileName.replace("s_", "m_");
			s3Client.delete(decodedFilePath, decodedFileName);
			
			decodedFileName = decodedFileName.replace("m_", "");
			s3Client.delete(decodedFilePath, decodedFileName);
			
		} catch (Exception e) {
			e.printStackTrace();
			
			return new ResponseEntity<>(HttpStatus.NOT_FOUND);
		}
		
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "text/plain;charset=UTF-8");
		
		return new ResponseEntity<String>("이미지가 삭제되었습니다", header, HttpStatus.OK);
	}
	
	/* LOCAL VER.
	@PostMapping("/deleteFile")
	public ResponseEntity<String> deleteFile(@RequestParam("fileName") String fileName) {
		log.info("Delete file: " + fileName);
		
		File file;
		
		try {
			file = new File(UploadRoot, URLDecoder.decode(fileName, "UTF-8"));
			
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
	*/
	
	private String getPath() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String str = sdf.format(new Date());
		
		return str.replace("-", File.separator);
	}
}
