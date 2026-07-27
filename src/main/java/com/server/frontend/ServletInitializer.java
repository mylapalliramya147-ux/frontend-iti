package com.server.frontend;
<<<<<<< HEAD
=======

>>>>>>> fbde2adcc50f300886bfc66e204bdc842cd0547a
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

public class ServletInitializer extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(FrontendApplication.class);
	}

}
