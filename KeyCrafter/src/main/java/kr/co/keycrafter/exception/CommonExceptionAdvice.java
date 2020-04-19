package kr.co.keycrafter.exception;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.NoHandlerFoundException;

import lombok.extern.log4j.Log4j;

@Log4j
@ControllerAdvice
public class CommonExceptionAdvice {
	@ExceptionHandler(Exception.class)
	public String except(Exception e, Model model) {
		log.error("Exception......" + e.getMessage());
		e.printStackTrace();
		model.addAttribute("exception", e);
		log.error(model);
		return "errorPage";
	}
	
	@ExceptionHandler(NoHandlerFoundException.class)
	public String handle404(NoHandlerFoundException e) {
		return "error404";
	}
}
