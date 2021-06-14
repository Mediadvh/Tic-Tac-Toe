//
//  Logic.swift
//  Tic-Tac-Toe
//
//  Created by Media Davarkhah on 3/12/1400 AP.
//

import Foundation
struct TicTacToe{
    var board : [[Int]] // The Tic Tac Toe board (row-major format, 3x3 array of Integers)
}
extension TicTacToe{
    init(){
        self.init(board: [[Int]](repeating: [Int](repeating: 0, count: 3), count: 3))// 3x3 array of zeros
    }
}
extension TicTacToe{
    
    func isWin(for player:Int)->Bool{
        let goal = [player,player,player]
        // row
        for res in board{
            if res == goal{
                return true // Row is equal to what was expected
            }
        }
        // column
        for col in 0..<3{
            let res = [board[0][col],board[1][col],board[2][col]]
            if res == goal{
                return true  // Column is equal to what was expected
            }
        }
        
        let diag1 = [board[0][0],board[1][1],board[2][2]]
        if diag1 == goal{
            return true // Left-to-right diagonal is equal to what was expected
        }
        
        let diag2 = [board[0][2],board[1][1],board[2][0]]
        if diag2 == goal{
            return true  // Right-to-left diagonal is equal to what was expected
        }
        
        
        
        
        return false // No win yet for this player
    }
}
extension TicTacToe{
    var legalMoves: [(Int,Int)] {
        var legals : [(Int,Int)] = []
        
        for row in 0..<3{
            for col in 0..<3{
                if board[row][col] == 0{
                    legals.append((row,col))
                }
            }
        }
        return legals
    }
     
    var hasWinner:Bool{
        return isWin(for: 1) || isWin(for: -1)
    }
    
    var isOver:Bool{
        return hasWinner || legalMoves.isEmpty
    }
}
extension TicTacToe{
    mutating func play(at location: (Int,Int),player : Int){
        guard board[location.0][location.1] == 0 else{
            fatalError()
        }
        board[location.0][location.1] = player
    }
}
// a function that can return the "children" of a board state. The children are all possible next board states for a certain player's turn.
extension TicTacToe {
    func children(player: Int) -> [TicTacToe] {
        var nextMoves: [TicTacToe] = []
        for i in legalMoves {
            var copy = TicTacToe(board: board)
            copy.play(at: i, player: player)
            nextMoves.append(copy)
        }
        return nextMoves
    }
}
extension TicTacToe{
    
    func winner(depth: Int)->Int{
        if isWin(for: 1){
            return 10 - depth
        }else if isWin(for: -1){
            return depth - 10
        }
        return 0
    }
}
extension TicTacToe {
    // Turn a number into a character
    //  0 = " "
    // +1 = "x"
    // -1 = "o"
    static func character(_ x: Int) -> String {
        x == 0 ? " " : (x == 1 ? "x" : "o")
    
    }
    
    // Print the board
    func display() {
        var boardTemplate = """
                               +-+-+-+
                               |1|2|3|
                               +-+-+-+
                               |4|5|6|
                               +-+-+-+
                               |7|8|9|
                               +-+-+-+
                            """
        boardTemplate = boardTemplate.replacingOccurrences(of: "1", with: "\(TicTacToe.character(board[0][0]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "2", with: "\(TicTacToe.character(board[0][1]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "3", with: "\(TicTacToe.character(board[0][2]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "4", with: "\(TicTacToe.character(board[1][0]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "5", with: "\(TicTacToe.character(board[1][1]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "6", with: "\(TicTacToe.character(board[1][2]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "7", with: "\(TicTacToe.character(board[2][0]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "8", with: "\(TicTacToe.character(board[2][1]))")
        boardTemplate = boardTemplate.replacingOccurrences(of: "9", with: "\(TicTacToe.character(board[2][2]))")
        print(boardTemplate, terminator: "\n\n")
     
    }
}


func minimax(state: TicTacToe, player: Int, depth: Int = 0) -> Double {
    if state.isOver { // If the game is over ...
        return Double(state.winner(depth: depth)) // ... return the score.
    }
    let children = state.children(player: player) // Determine the children of the game state ...
                        .map({ minimax(state: $0, player: -player, depth: depth + 1) }) // ... and find their minimax scores.
    if player == 1 { // If the player is 1 (maximizer) ...
        return children.max()! // ... return the score of the child with the highest score.
    } else { // If the player is -1 (minimizer) ...
        return children.min()! // ... return the score of the child with the lowest score.
    }
}

func decision(for state: TicTacToe, player: Int) -> (Int, Int) {
    let children = state.children(player: player) // Find the children of a game state.
    let scores = children.map({ Double(player) * minimax(state: $0, player: -player) }) // Find their minimax scores and canonicalize the score by multiplying by the player.
    return state.legalMoves[scores.firstIndex(where: { $0 == scores.max()! })!] // Return the move that has the highest minimax score.
}

