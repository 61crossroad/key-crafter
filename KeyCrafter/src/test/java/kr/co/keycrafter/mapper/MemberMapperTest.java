package kr.co.keycrafter.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

import kr.co.keycrafter.domain.MemberVO;
import kr.co.keycrafter.domain.AuthVO;

@Log4j
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml"
})
@RunWith(SpringJUnit4ClassRunner.class)
public class MemberMapperTest {
	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwEncoder;
	
	@Setter(onMethod_ = @Autowired)
	private DataSource ds;
	
	// @Test
	public void getMemberWithAuth() {
		MemberVO member = mapper.getMemberWithAuth("aaa");
		log.info(member);
		
		member.getAuthList().forEach(auth -> log.info(auth));
	}
	
	// @Test
	public void insertAuthBatis() {
		AuthVO auth = new AuthVO();
		auth.setAuth("ROLE_ADMIN");
		auth.setId("admin2");
		mapper.insertAuth(auth);
	}

	// @Test
	public void insertAuth() {
		// mapper.insertAuth("admin", "ROLE_ADMIN");
		Connection con = null;
		PreparedStatement pstmt = null;
		String sql = "INSERT INTO member_auth (id, auth) VALUES (?, ?)";
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, "admin");
			pstmt.setString(2, "ROLE_ADMIN");
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (Exception e) {}
			}
			
			if (con != null) {
				try {
					pstmt.close();
				} catch (Exception e) {}
			}
		}
	}
	
	// @Test
	public void insertMember() {
		MemberVO member = new MemberVO();
		AuthVO auth = new AuthVO();
		
		member.setId("admin");
		// member.setPassword("admin");
		member.setPassword(pwEncoder.encode("admin"));
		member.setName("관리자");
		member.setEmail("admin@keycrafter.co.kr");
		member.setContact("01012345678");
		member.setAddress("서울시 마포구 합정동");
		member.setZipCode("04024");
		
		auth.setId(member.getId());
		auth.setAuth("ROLE_ADMIN");
		
		mapper.insertMember(member);
		mapper.insertAuth(auth);
		
		// log.info(member);
	}
	
	// @Test
	public void getId() {
		log.info("getId: " + mapper.getId("asdn"));
	}
	
	// @Test
	public void deleteMember() {
		log.info("delete member: " + mapper.deleteMember("admin"));
	}
}
