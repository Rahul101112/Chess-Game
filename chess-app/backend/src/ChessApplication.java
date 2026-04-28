package com.chess;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class ChessApplication {

    public static void main(String[] args) {
        SpringApplication.run(ChessApplication.class, args);
    }

    @GetMapping("/api/health")
    public String health() {
        return "{\"status\": \"UP\", \"application\": \"Chess Game Engine\"}";
    }

    @GetMapping("/api/version")
    public String version() {
        return "{\"version\": \"1.0.0\"}";
    }
}
