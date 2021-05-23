package kr.co.keycrafter.service;

import java.io.File;
import java.io.InputStream;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.DeleteObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;

import static kr.co.keycrafter.domain.Const.*;

import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class S3Storage {
	private AmazonS3 s3Client;
	
	public S3Storage() {
		AWSCredentials credentials = new BasicAWSCredentials(AccessKey, SecretKey);
		
		s3Client = AmazonS3ClientBuilder.standard()
				.withCredentials(new AWSStaticCredentialsProvider(credentials))
				.withRegion(Regions.AP_NORTHEAST_2)
				.build();
	}
	
	public void upload(File filePath, String fileName, MultipartFile mFile) {
		log.info("Uploading MultipartFile to S3...... " + " " + BucketName + filePath + " " + fileName);
		
		InputStream input = null;
		
		try {
			input = mFile.getInputStream();
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(mFile.getSize());
			PutObjectRequest request = new PutObjectRequest(BucketName + filePath, fileName, input, metadata);
			request.setCannedAcl(CannedAccessControlList.PublicRead);
			s3Client.putObject(request);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try  {
				input.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void upload(File filePath, String fileName, InputStream input) {
		log.info("Uploading InputStream to S3.......");
		
		try {
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(input.available());
			PutObjectRequest request = new PutObjectRequest(BucketName + filePath, fileName, input, metadata);
			request.setCannedAcl(CannedAccessControlList.PublicRead);
			s3Client.putObject(request);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try  {
				input.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
	
	public void delete(String filePath, String fileName) {
		try {
			s3Client.deleteObject(new DeleteObjectRequest(BucketName + filePath, fileName));
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
