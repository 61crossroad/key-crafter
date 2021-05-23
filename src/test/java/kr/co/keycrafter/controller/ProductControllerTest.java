package kr.co.keycrafter.controller;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;

import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.beans.factory.annotation.Autowired;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/security-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
public class ProductControllerTest {
	@Setter(onMethod_ = @Autowired)
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	@Test
	public void testNoSearch() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/product/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	// @Test
	public void testMultipleSearch() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/product/list")
						.param("type", "NDP")
						.param("keyword", "V")
						.param("type", "NDP")
						.param("keyword", "A"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
	
	// @Test
	public void testGet() throws Exception {
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/product/50"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		
		/*
		log.info(
				mockMvc.perform(MockMvcRequestBuilders.get("/category/list"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
		*/
	}
	
	// @Test
	public void testList() throws Exception {
		log.info(
				mockMvc.perform(
						MockMvcRequestBuilders.get("/product/list")
						.param("page", "1")
						.param("show", "12")
						.param("keyword", "바밀로")
						.param("type", "CDNP"))
				.andReturn()
				.getModelAndView()
				.getModelMap());
	}
}
