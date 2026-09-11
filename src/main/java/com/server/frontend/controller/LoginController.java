package com.server.frontend.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

/**
 * Handles the officials login form on the home page.
 * Validates captcha (session-scoped), then delegates credential checking
 * to the Backend /api/auth/login endpoint.
 */
@Controller
public class LoginController {

    private final RestTemplate rest = new RestTemplate();
    private static final String AUTH_URL = "http://localhost:5050/api/auth/login";

    @PostMapping("/iti/login.do")
    public String login(@RequestParam("uname") String uname,
                        @RequestParam("pwd") String pwd,
                        @RequestParam(value = "captcha", required = false) String captcha,
                        HttpServletRequest request) {

        // 1. captcha must match the one generated for this session
        if (!CaptchaController.matches(request, captcha)) {
            request.getSession().removeAttribute("sessionUser");
            return "redirect:/?error=captcha";
        }

        // 2. credentials are checked by the backend
        Map<String, Object> result;
        try {
            Map<String, String> payload = Map.of(
                    "username", uname == null ? "" : uname.trim(),
                    "password", pwd == null ? "" : pwd,
                    "ip", request.getRemoteAddr() == null ? "" : request.getRemoteAddr(),
                    "sessionId", request.getSession().getId());
            ResponseEntity<Map> resp = rest.postForEntity(AUTH_URL, payload, Map.class);
            result = resp.getBody();
        } catch (Exception e) {
            return "redirect:/?error=server";
        }

        if (result == null || !Boolean.TRUE.equals(result.get("success"))) {
            Object msg = result == null ? null : result.get("message");
            String err = "inactive".equalsIgnoreCase(String.valueOf(msg)) || (msg != null && msg.toString().contains("inactive"))
                    ? "inactive" : "invalid";
            return "redirect:/?error=" + err;
        }

        // 3. store the authenticated user in session
        HttpSession session = request.getSession(true);
        session.setAttribute("sessionUser", result);
        session.setAttribute("username", result.get("username"));
        session.setAttribute("roleId", result.get("roleId"));
        session.setAttribute("insCode", result.get("insCode"));
        session.setAttribute("fullName", result.get("fullName"));
        session.setAttribute("itiName", result.get("itiName"));
        session.setAttribute("loginCount", result.get("loginCount"));
        session.setAttribute("lastLogins", result.get("lastLogins"));
        return "redirect:/authHome";
    }

        @PostMapping("/placementsLogin.do")
    public String placementsLogin(@RequestParam("uname") String uname,
                                  @RequestParam("pwd") String pwd,
                                  @RequestParam(value = "captcha", required = false) String captcha,
                                  HttpServletRequest request) {
        if (!CaptchaController.matches(request, captcha)) {
            request.getSession().removeAttribute("sessionUser");
            return "redirect:/placements?error=captcha";
        }
        Map<String, Object> result;
        try {
            Map<String, String> payload = Map.of(
                    "username", uname == null ? "" : uname.trim(),
                    "password", pwd == null ? "" : pwd,
                    "ip", request.getRemoteAddr() == null ? "" : request.getRemoteAddr(),
                    "sessionId", request.getSession().getId());
            ResponseEntity<Map> resp = rest.postForEntity(AUTH_URL, payload, Map.class);
            result = resp.getBody();
        } catch (Exception e) {
            return "redirect:/placements?error=server";
        }

        if (result == null || !Boolean.TRUE.equals(result.get("success"))) {
            Object msg = result == null ? null : result.get("message");
            String err = "inactive".equalsIgnoreCase(String.valueOf(msg)) || (msg != null && msg.toString().contains("inactive"))
                    ? "inactive" : "invalid";
            return "redirect:/placements?error=" + err;
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("sessionUser", result);
        session.setAttribute("username", result.get("username"));
        session.setAttribute("roleId", result.get("roleId"));
        session.setAttribute("insCode", result.get("insCode"));
        session.setAttribute("fullName", result.get("fullName"));
        session.setAttribute("itiName", result.get("itiName"));
        session.setAttribute("loginCount", result.get("loginCount"));
        session.setAttribute("lastLogins", result.get("lastLogins"));
                return "jsp/placementDashboard";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession s = request.getSession(false);
        if (s != null) s.invalidate();
        return "redirect:/";
    }
}
