package com.server.frontend.controller;

import jakarta.servlet.http.HttpSession;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
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

    // ---------- /dev login gate + per-login page access ----------

    /** Signed-in session for a given roleId, without touching the backend. */
    private MockHttpSession devSession(Object roleId) {
        MockHttpSession s = new MockHttpSession();
        s.setAttribute("sessionUser", new java.util.HashMap<String, Object>());
        s.setAttribute("username", "devuser");
        if (roleId != null) s.setAttribute("roleId", roleId);
        return s;
    }

    @Test
    void devIndexRedirectsToDevLoginWhenSignedOut() throws Exception {
        mvc.perform(get("/dev"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dev/login"));
    }

    @Test
    void devLoginPageRenders() throws Exception {
        mvc.perform(get("/dev/login"))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/jsp/devLogin.jsp"));
    }

    @Test
    void devLogoutSendsBackToDevLogin() throws Exception {
        mvc.perform(get("/dev/logout").session(devSession(4)))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dev/login"));
    }

    @Test
    void devViewRedirectsToDevLoginWhenSignedOut() throws Exception {
        mvc.perform(get("/dev/view/admission/addTrade"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dev/login"));
    }

    @Test
    void itiLoginCanOpenItiPageButNotNodalPage() throws Exception {
        mvc.perform(get("/dev/view/reports/api-dashboard-iti").session(devSession(4)))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/reports/api-dashboard-iti.jsp"));

        mvc.perform(get("/dev/view/reports/api-dashboard-state").session(devSession(4)))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dev?error=denied&page=reports%2Fapi-dashboard-state"));
    }

    @Test
    void nodalLoginCanOpenNodalPageButNotItiOnlyPage() throws Exception {
        mvc.perform(get("/dev/view/reports/api-dashboard-state").session(devSession(10)))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/reports/api-dashboard-state.jsp"));

        mvc.perform(get("/dev/view/labs/labs_entry").session(devSession(10)))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/dev?error=denied&page=labs%2Flabs_entry"));
    }

    @Test
    void sharedPageOpensForEveryLogin() throws Exception {
        // ReportsController allows dsc-list for roles 4, 3 and 10.
        for (Object role : new Object[]{4, 3, 10}) {
            mvc.perform(get("/dev/view/reports/dsc-list").session(devSession(role)))
                    .andExpect(status().isOk());
        }
    }

    @Test
    void adminCanOpenEveryPage() throws Exception {
        mvc.perform(get("/dev/view/reports/api-dashboard-iti").session(devSession(2)))
                .andExpect(status().isOk());
        mvc.perform(get("/dev/view/reports/api-dashboard-state").session(devSession(2)))
                .andExpect(status().isOk());
        mvc.perform(get("/dev/view/labs/labs_entry").session(devSession(2)))
                .andExpect(status().isOk());
    }

    @Test
    void unroutedWipPageOpensForEveryLogin() throws Exception {
        // admission/addTrade has no controller route and therefore no role guard.
        mvc.perform(get("/dev/view/admission/addTrade").session(devSession(4)))
                .andExpect(status().isOk());
        mvc.perform(get("/dev/view/admission/addTrade").session(devSession(10)))
                .andExpect(status().isOk());
    }

    @Test
    void sessionWithoutRoleIdIsNotFiltered() throws Exception {
        mvc.perform(get("/dev/view/reports/api-dashboard-state").session(devSession(null)))
                .andExpect(status().isOk());
    }
}
