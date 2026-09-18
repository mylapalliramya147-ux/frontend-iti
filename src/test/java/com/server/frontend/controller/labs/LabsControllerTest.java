package com.server.frontend.controller.labs;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.webmvc.test.autoconfigure.AutoConfigureMockMvc;
import org.springframework.mock.web.MockHttpSession;

import java.util.Map;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
class LabsControllerTest {

    @Autowired
    private org.springframework.test.web.servlet.MockMvc mvc;

    private MockHttpSession itiSession() {
        MockHttpSession s = new MockHttpSession();
        s.setAttribute("sessionUser", Map.of("username", "LOGINITI"));
        s.setAttribute("roleId", "4");
        s.setAttribute("insCode", "1401");
        return s;
    }

    private MockHttpSession districtSession() {
        MockHttpSession s = new MockHttpSession();
        s.setAttribute("sessionUser", Map.of("username", "DISTLOGIN"));
        s.setAttribute("roleId", "3");
        return s;
    }

    @Test
    void entryWithoutSessionRedirects() throws Exception {
        mvc.perform(get("/labs/entry"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/placements?error=session"));
    }

    @Test
    void entryWithItiSessionRenders() throws Exception {
        mvc.perform(get("/labs/entry").session(itiSession()))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/labs/labs_entry.jsp"));
    }

    @Test
    void entryWithDistrictSessionRedirects() throws Exception {
        mvc.perform(get("/labs/entry").session(districtSession()))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/placements?error=session"));
    }

    @Test
    void reportWithoutSessionRedirects() throws Exception {
        mvc.perform(get("/labs/report"))
                .andExpect(status().is3xxRedirection())
                .andExpect(redirectedUrl("/placements?error=session"));
    }

    @Test
    void reportWithItiSessionRenders() throws Exception {
        mvc.perform(get("/labs/report").session(itiSession()))
                .andExpect(status().isOk())
                .andExpect(forwardedUrl("/WEB-INF/labs/labs_report.jsp"));
    }
}
