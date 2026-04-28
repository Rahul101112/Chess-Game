package com.chess.engine;

import java.util.List;

public class MinimaxAI {

    public Move getBestMove(Board board, int depth) {
        double bestValue = Double.NEGATIVE_INFINITY;
        Move bestMove = null;
        List<Move> legalMoves = board.generateLegalMoves();

        for (Move move : legalMoves) {
            board.makeMove(move);
            // AI is trying to maximize its score, so the next turn minimizes it
            double boardValue = minimax(board, depth - 1, Double.NEGATIVE_INFINITY, Double.POSITIVE_INFINITY, false);
            board.undoMove(move);

            if (boardValue > bestValue) {
                bestValue = boardValue;
                bestMove = move;
            }
        }
        return bestMove;
    }

    private double minimax(Board board, int depth, double alpha, double beta, boolean isMaximizingPlayer) {
        if (depth == 0 || board.isGameOver()) {
            return evaluateBoard(board);
        }

        List<Move> legalMoves = board.generateLegalMoves();

        if (isMaximizingPlayer) {
            double maxEval = Double.NEGATIVE_INFINITY;
            for (Move move : legalMoves) {
                board.makeMove(move);
                double eval = minimax(board, depth - 1, alpha, beta, false);
                board.undoMove(move);
                maxEval = Math.max(maxEval, eval);
                alpha = Math.max(alpha, eval);
                if (beta <= alpha) break; // Alpha-beta pruning
            }
            return maxEval;
        } else {
            double minEval = Double.POSITIVE_INFINITY;
            for (Move move : legalMoves) {
                board.makeMove(move);
                double eval = minimax(board, depth - 1, alpha, beta, true);
                board.undoMove(move);
                minEval = Math.min(minEval, eval);
                beta = Math.min(beta, eval);
                if (beta <= alpha) break; // Alpha-beta pruning
            }
            return minEval;
        }
    }

    private double evaluateBoard(Board board) {
        // TODO: Implement material counting and positional heuristics (piece-square tables)
        // e.g., Queen = 900, Rook = 500, Bishop/Knight = 300, Pawn = 100
        return 0.0; 
    }
}