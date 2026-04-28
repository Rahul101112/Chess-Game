package com.chess.engine;

/**
 * Represents a chess board state and provides game logic
 */
public class Board {
    private String fen = "rnbqkbnr/pppppppp/8/8/8/8/PPPPPPPP/RNBQKBNR w KQkq - 0 1";

    public Board() {
        // Initialize board with starting position
    }

    public String getFen() {
        return fen;
    }

    public boolean isValidMove(Move move) {
        // TODO: Implement move validation logic
        return true;
    }

    public void makeMove(Move move) {
        // TODO: Implement move logic
    }

    public boolean isGameOver() {
        // TODO: Implement game over detection
        return false;
    }
}
