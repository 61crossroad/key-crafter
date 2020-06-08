package kr.co.keycrafter.service;

import org.junit.runner.RunWith;
import org.junit.Test;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.beans.factory.annotation.Autowired;


import kr.co.keycrafter.service.S3Storage;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"})
public class S3StorageTest {
	@Setter(onMethod_ = @Autowired)
	private S3Storage s3Client;
	
	@Test
	public void delete() {
		s3Client.delete("upload", "test.jpg");
	}
}
