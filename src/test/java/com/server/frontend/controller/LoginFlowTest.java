package com.server.frontend.controller;

import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.mock.web.MockHttpSession;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class LoginFlowTest {

    @Autowired
    private org.springframework.test.web.servlet.MockMvc mvc;

    private MockHttpSession sessionWithCaptcha() throws Exception {
        MockHttpSession session = new MockHttpSession();
        // hit the captcha endpoint so the controller stores the text in this session
        mvc.perform(get("/captcha").session(session)).andExpect(status().isOk());
        return session;
    }

    private String captchaText(HttpSession session) {
        return (String) session.getAttribute("CAPTCHA_TEXT");
    }

    @Test
    void wrongCaptchaRedirectsHomeWithError() throws Exception {
        MockHttpSession s = sessionWithCaptcha();
        String wrong = "zzzzz".equals(captchaText(s)) ? "aaaaa" : "zzzzz";
        mvc.perform(post("/iti/login.do")
                        .param("uname", "iti1536").param("pwd", "cSoMG2").param("captcha", wrong)
                        .session(s))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/?error=captcha"));
    }

    @Test
    void correctCaptchaButWrongPasswordRedirectsWithInvalid() throws Exception {
        MockHttpSession s = sessionWithCaptcha();
        mvc.perform(post("/iti/login.do")
                        .param("uname", "iti1536").param("pwd", "definitely-wrong").param("captcha", captchaText(s))
                        .session(s))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/?error=invalid"));
    }

    @Test
    void fullLoginSuccessStoresUserAndAuthHomeShowsRole() throws Exception {
        MockHttpSession s = sessionWithCaptcha();
        mvc.perform(post("/iti/login.do")
                        .param("uname", "iti1536").param("pwd", "cSoMG2").param("captcha", captchaText(s))
                        .session(s))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/authHome"));

        assertEquals(4, ((Number) s.getAttribute("roleId")).intValue());
        assertEquals("iti1536", s.getAttribute("username"));

        mvc.perform(get("/authHome").session(s))
                .andExpect(status().isOk());
    }

    @Test
    void authHomeWithoutLoginRedirectsToError() throws Exception {
        mvc.perform(get("/authHome"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/?error=session"));
    }
}
