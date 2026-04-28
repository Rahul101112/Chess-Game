package com.chess.controller;

import com.chess.engine.Board;
import com.chess.engine.MinimaxAI;
import com.chess.engine.Move;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/game")
@CrossOrigin(origins = "*") // In production, restrict this to your domain
public class GameController {

    private Board currentBoard = new Board();
    private MinimaxAI ai = new MinimaxAI();

    @PostMapping("/start")
    public String startGame(@RequestParam String playerSide) {
        currentBoard = new Board(); // Reset board to initial FEN
        if (playerSide.equalsIgnoreCase("black")) {
            // If player is black, AI (White) makes the first move
            Move aiMove = ai.getBestMove(currentBoard, 4); // Depth 4
            currentBoard.makeMove(aiMove);
        }
        return currentBoard.getFen();
    }

    @PostMapping("/move")
    public String makeMove(@RequestBody Move playerMove) {
        // 1. Validate and make player move
        if (currentBoard.isValidMove(playerMove)) {
            currentBoard.makeMove(playerMove);
            
            // 2. Check for game over (Checkmate/Draw)
            if (currentBoard.isGameOver()) return currentBoard.getFen();

            // 3. AI calculates and makes its move
            Move aiMove = ai.getBestMove(currentBoard, 4); // Adjust depth for difficulty
            if(aiMove != null) {
                currentBoard.makeMove(aiMove);
            }
        }
        return currentBoard.getFen(); // Return updated board state
    }
}