//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Media Davarkhah on 3/12/1400 AP.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var position1: UIButton!
    @IBOutlet weak var position2: UIButton!
    @IBOutlet weak var position3: UIButton!
    @IBOutlet weak var position4: UIButton!
    @IBOutlet weak var position5: UIButton!
    @IBOutlet weak var position6: UIButton!
    @IBOutlet weak var position7: UIButton!
    @IBOutlet weak var position8: UIButton!
    @IBOutlet weak var position9: UIButton!
    
    @IBOutlet weak var tryAgain: UIButton!
    @IBOutlet weak var reset: UIButton!
    @IBOutlet weak var backToMenu: UIButton!
    
    var winner = -2 {
        didSet{
            if winner == 1 {
                comment.text = "You Won 🥳"
            }else if winner == -1{
                comment.text = "You Lost ☹️"
                tryAgain.isHidden = false
                
            }else{
                comment.text = "Draw"
                tryAgain.isHidden = false
            }
        }
    }
    
    fileprivate func checkWinner() {
        if newBoard.isOver {
            if newBoard.isWin(for: 1){
                winner = 1
            }else if newBoard.isWin(for: -1){
                winner = -1
            }else{
                winner = 0
            }
        }
    }
    
    var turn = 1 {
        didSet{
            // opponent is playing
            guard self.turn == -1, self.newBoard.isOver == false else{return}
            comment.text = "Opponents Turn..."
            loadingIndicator.isHidden = false
            loadingIndicator.startAnimating()
            let opponentsMove = decision(for: newBoard, player: -1)
            newBoard.play(at: opponentsMove, player: -1)
            _ = Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { (Timer) in
                self.markUI(at: opponentsMove, with: -1)
                self.loadingIndicator.isHidden = true
                self.checkWinner()
                if self.winner == -2{
                self.turn = 1
                    self.comment.text = "Your Turn!"
                    
                }
                
            }
            
            
            newBoard.display()
            
        }
    }
    
    var newBoard = TicTacToe()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingIndicator.isHidden = true
        // Do any additional setup after loading the view.
        tryAgain.isHidden = true
        reset.isHidden = false
        backToMenu.isHidden = false
        
        
    }
    
    func resetGameState(){
        position1.setImage(UIImage(named: "Empty"), for: .normal)
        position2.setImage(UIImage(named: "Empty"), for: .normal)
        position3.setImage(UIImage(named: "Empty"), for: .normal)
        position4.setImage(UIImage(named: "Empty"), for: .normal)
        position5.setImage(UIImage(named: "Empty"), for: .normal)
        position6.setImage(UIImage(named: "Empty"), for: .normal)
        position7.setImage(UIImage(named: "Empty"), for: .normal)
        position8.setImage(UIImage(named: "Empty"), for: .normal)
        position9.setImage(UIImage(named: "Empty"), for: .normal)
        
        turn = 1
        winner = -2
        newBoard = TicTacToe()
        
        comment.text = "Your Turn!"
        
        tryAgain.isHidden = true
        
    }
    
    
    func markUI(at: (Int,Int),with: Int){
        switch at{
        case (0,0):
            if with == 1{
                position1.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position1.setImage(UIImage(named: "O"), for: .normal)
            }
            
        case (0,1):
            if with == 1{
                position2.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position2.setImage(UIImage(named: "O"), for: .normal)
            }
            
        case(0,2):
            if with == 1{
                position3.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position3.setImage(UIImage(named: "O"), for: .normal)
            }
        case (1,0):
            if with == 1{
                position4.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position4.setImage(UIImage(named: "O"), for: .normal)
            }
        case (1,1):
            if with == 1{
                position5.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position5.setImage(UIImage(named: "O"), for: .normal)
            }
        case(1,2):
            if with == 1{
                position6.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position6.setImage(UIImage(named: "O"), for: .normal)
            }
        case (2,0):
            if with == 1{
                position7.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position7.setImage(UIImage(named: "O"), for: .normal)
            }
        case (2,1):
            if with == 1{
                position8.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position8.setImage(UIImage(named: "O"), for: .normal)
            }
        case(2,2):
            if with == 1{
                position9.setImage(UIImage(named: "X"), for: .normal)
                
            }
            else{
                position9.setImage(UIImage(named: "O"), for: .normal)
            }
        default:
            break
        }
    }
    
    @IBAction func position1Selected(_ sender: Any) {
       
        // User's turn
        guard turn == 1 , newBoard.isOver == false , newBoard.board[0][0] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        
        comment.text = "Your Turn!"
        markUI(at: (0,0), with: 1)
        newBoard.play(at: (0, 0), player: 1)
        checkWinner()
        turn = -1
      
       
        
        
        
    }
    @IBAction func position2Selected(_ sender: Any) {
        
        // User's turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[0][1] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (0,1), with: 1)
        newBoard.play(at: (0, 1), player: 1)
        checkWinner()
        turn = -1
        
        
        
    }
    @IBAction func position3Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[0][2] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (0,2), with: 1)
        newBoard.play(at: (0, 2), player: 1)
        checkWinner()
        turn = -1
        
        
        
    }
    @IBAction func position4Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[1][0] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (1,0), with: 1)
        newBoard.play(at: (1, 0), player: 1)
        checkWinner()
        turn = -1
        
        
       
    }
    @IBAction func position5Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[1][1] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (1,1), with: 1)
        newBoard.play(at: (1, 1), player: 1)
        checkWinner()
        turn = -1
        
    }
    @IBAction func position6Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false,newBoard.board[1][2] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (1,2), with: 1)
        newBoard.play(at: (1, 2), player: 1)
        checkWinner()
        turn = -1
       
        
        
    }
    @IBAction func position7Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[2][0] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (2,0), with: 1)
        newBoard.play(at: (2, 0), player: 1)
        checkWinner()
        turn = -1
      
        
        
    }
    @IBAction func position8Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[2][1] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (2,1), with: 1)
        newBoard.play(at: (2, 1), player: 1)
        checkWinner()
        turn = -1
        
        
    }
    @IBAction func position9Selected(_ sender: Any) {
        // User's Turn
        guard turn == 1 , newBoard.isOver == false, newBoard.board[2][2] == 0 else{
            return
        }
        loadingIndicator.isHidden = true
        comment.text = "Your Turn!"
        markUI(at: (2,2), with: 1)
        newBoard.play(at: (2, 2), player: 1)
        checkWinner()
        turn = -1
               
    }
    
    
    
    @IBAction func resetTapped(_ sender: Any) {
        resetGameState()
        
    }
    
    @IBAction func tryAgainTapped(_ sender: Any) {
        resetGameState()
        
    }
    @IBAction func backToMenuTapped(_ sender: Any) {
        
        // go back to menu
        self.performSegue(withIdentifier: "unwindToViewController1", sender: self)
        
    }

    
}

