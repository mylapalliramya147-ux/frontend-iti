package com.server.frontend.controller;

import java.util.HashMap;
import java.util.Map;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

/**
 * Handles the officials login form on the home page.
 * Validates captcha (session-scoped), then delegates credential checking
 * to the Backend /api/auth/login endpoint.
 */
@Controller
public class LoginController {

    private final RestTemplate rest = new RestTemplate();
    @Value("${backend.api.base-url}/api/auth/login")
    private String AUTH_URL;

    @PostMapping("/iti/login.do")
    public String login(@RequestParam("uname") String uname,
                        @RequestParam("pwd") String pwd,
                        @RequestParam(value = "captcha", required = false) String captcha,
                        HttpServletRequest request) {

        // 1. captcha must match the one generated for this session
        if (!CaptchaController.matches(request, captcha)) {
            HttpSession stale = request.getSession(false);
            if (stale != null) {
                stale.removeAttribute("sessionUser");
            }
            return "redirect:/?error=captcha";
        }

        // 2. credentials are checked by the backend
        Map<String, Object> result = callAuthBackend(request, uname, pwd);
        if (result == null) {
            return "redirect:/?error=server";
        }
        if (!Boolean.TRUE.equals(result.get("success"))) {
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
            HttpSession placementStale = request.getSession(false);
            if (placementStale != null) {
                placementStale.removeAttribute("sessionUser");
            }
            return "redirect:/placements?error=captcha";
        }
        Map<String, Object> placementResult = callAuthBackend(request, uname, pwd);
        if (placementResult == null) {
            return "redirect:/placements?error=server";
        }
        if (!Boolean.TRUE.equals(placementResult.get("success"))) {
            Object msg = placementResult == null ? null : placementResult.get("message");
            String err = "inactive".equalsIgnoreCase(String.valueOf(msg)) || (msg != null && msg.toString().contains("inactive"))
                    ? "inactive" : "invalid";
            return "redirect:/placements?error=" + err;
        }

        HttpSession placementSession = request.getSession(true);
        placementSession.setAttribute("sessionUser", placementResult);
        placementSession.setAttribute("username", placementResult.get("username"));
        placementSession.setAttribute("roleId", placementResult.get("roleId"));
        placementSession.setAttribute("insCode", placementResult.get("insCode"));
        placementSession.setAttribute("fullName", placementResult.get("fullName"));
        placementSession.setAttribute("itiName", placementResult.get("itiName"));
        placementSession.setAttribute("loginCount", placementResult.get("loginCount"));
        placementSession.setAttribute("lastLogins", placementResult.get("lastLogins"));
        return "redirect:/placements/loginSuccess";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        HttpSession activeSession = request.getSession(false);
        if (activeSession != null) {
            activeSession.invalidate();
        }
        return "redirect:/";
    }

    private Map<String, Object> callAuthBackend(HttpServletRequest request, String uname, String pwd) {
        try {
            Map<String, String> payload = new HashMap<>();
            payload.put("username", uname == null ? "" : uname.trim());
            payload.put("password", pwd == null ? "" : pwd);
            payload.put("ip", request.getRemoteAddr() == null ? "" : request.getRemoteAddr());
            payload.put("sessionId", request.getSession().getId());
            ResponseEntity<AuthResponse> response =
                    rest.postForEntity(AUTH_URL, payload, AuthResponse.class);
            AuthResponse body = response.getBody();
            return body == null ? null : body.toMap();
        } catch (Exception e) {
            return null;
        }
    }

    /** Typed view of the backend /api/auth/login JSON body. */
    public static class AuthResponse {
        private Boolean success;
        private String message;
        private Object username;
        private Object roleId;
        private Object insCode;
        private Object fullName;
        private Object itiName;
        private Object loginCount;
        private Object lastLogins;

        public Boolean getSuccess() {
            return success;
        }

        public void setSuccess(Boolean success) {
            this.success = success;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }

        public Object getUsername() {
            return username;
        }

        public void setUsername(Object username) {
            this.username = username;
        }

        public Object getRoleId() {
            return roleId;
        }

        public void setRoleId(Object roleId) {
            this.roleId = roleId;
        }

        public Object getInsCode() {
            return insCode;
        }

        public void setInsCode(Object insCode) {
            this.insCode = insCode;
        }

        public Object getFullName() {
            return fullName;
        }

        public void setFullName(Object fullName) {
            this.fullName = fullName;
        }

        public Object getItiName() {
            return itiName;
        }

        public void setItiName(Object itiName) {
            this.itiName = itiName;
        }

        public Object getLoginCount() {
            return loginCount;
        }

        public void setLoginCount(Object loginCount) {
            this.loginCount = loginCount;
        }

        public Object getLastLogins() {
            return lastLogins;
        }

        public void setLastLogins(Object lastLogins) {
            this.lastLogins = lastLogins;
        }

        Map<String, Object> toMap() {
            Map<String, Object> map = new HashMap<>();
            map.put("success", success);
            map.put("message", message);
            map.put("username", username);
            map.put("roleId", roleId);
            map.put("insCode", insCode);
            map.put("fullName", fullName);
            map.put("itiName", itiName);
            map.put("loginCount", loginCount);
            map.put("lastLogins", lastLogins);
            return map;
        }
    }
}
