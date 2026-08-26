package com.server.frontend.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.io.OutputStream;
import java.security.SecureRandom;

/**
 * Serves the login captcha image and stores the expected text in the HTTP session.
 * Replaces the legacy captcha.jsp. Supports ?ts= cache-busting refreshes.
 */
@Controller
public class CaptchaController {

    private static final String SESSION_KEY = "CAPTCHA_TEXT";
    private static final String CHARS = "0123456789";
    private static final SecureRandom RANDOM = new SecureRandom();

    @GetMapping(value = "/captcha", produces = MediaType.IMAGE_PNG_VALUE)
    public void captcha(HttpServletRequest request, HttpServletResponse response, OutputStream out) throws IOException {
        String text = randomText(4);
        request.getSession().setAttribute(SESSION_KEY, text);
        response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");
        response.setDateHeader("Expires", 0);

        BufferedImage img = new BufferedImage(135, 30, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = img.createGraphics();
        g.setColor(Color.WHITE);
        g.fillRect(0, 0, 135, 30);

        // noise lines
        for (int i = 0; i < 5; i++) {
            g.setColor(new Color(180 + RANDOM.nextInt(60), 180 + RANDOM.nextInt(60), 180 + RANDOM.nextInt(60)));
            g.drawLine(RANDOM.nextInt(135), RANDOM.nextInt(30), RANDOM.nextInt(135), RANDOM.nextInt(30));
        }

        // characters
        int x = 12;
        for (char c : text.toCharArray()) {
            g.setColor(new Color(30 + RANDOM.nextInt(80), 30 + RANDOM.nextInt(80), 120 + RANDOM.nextInt(120)));
            g.setFont(new Font("Arial", Font.BOLD | Font.ITALIC, 20 + RANDOM.nextInt(6)));
            double rot = (RANDOM.nextDouble() - 0.5) * 0.5;
            g.rotate(rot, x, 22);
            g.drawString(String.valueOf(c), x, 22);
            g.rotate(-rot, x, 22);
            x += 24;
        }
        g.dispose();

        ImageIO.write(img, "png", out);
        out.flush();
    }

    static boolean matches(HttpServletRequest request, String submitted) {
        Object expected = request.getSession().getAttribute(SESSION_KEY);
        return expected != null && submitted != null
                && expected.toString().equalsIgnoreCase(submitted.trim());
    }

    private String randomText(int len) {
        StringBuilder sb = new StringBuilder(len);
        for (int i = 0; i < len; i++) sb.append(CHARS.charAt(RANDOM.nextInt(CHARS.length())));
        return sb.toString();
    }
}
