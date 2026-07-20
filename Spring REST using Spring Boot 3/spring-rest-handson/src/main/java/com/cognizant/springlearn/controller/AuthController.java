package com.cognizant.springlearn.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RestController;

import com.cognizant.springlearn.security.JwtUtil;

import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

@RestController
public class AuthController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AuthController.class);

    @Autowired
    private JwtUtil jwtUtil;

    @Autowired
    private UserDetailsService userDetailsService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @PostMapping("/authenticate")
    public ResponseEntity<Map<String, String>> authenticate(@RequestHeader("Authorization") String authHeader) {
        LOGGER.info("Start authenticate");
        if (authHeader != null && authHeader.startsWith("Basic ")) {
            String base64Credentials = authHeader.substring("Basic ".length());
            String credentials = new String(Base64.getDecoder().decode(base64Credentials));
            String[] values = credentials.split(":", 2);
            String username = values[0];
            String password = values[1];

            UserDetails userDetails = userDetailsService.loadUserByUsername(username);
            if (userDetails != null && passwordEncoder.matches(password, userDetails.getPassword())) {
                String token = jwtUtil.generateToken(username);
                Map<String, String> map = new HashMap<>();
                map.put("token", token);
                LOGGER.info("End authenticate");
                return ResponseEntity.ok(map);
            }
        }
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }
}
