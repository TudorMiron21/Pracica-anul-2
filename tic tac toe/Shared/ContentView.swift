//
//  ContentView.swift
//  Shared
//
//  Created by cetasc mta on 17.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [GridItem(.flexible()),
                               GridItem(.flexible()),
                               GridItem(.flexible()),]
    
    @State private var moves :[Move?]=Array(repeating:nil, count: 9)
   // @State private var board : Board
    @State private var isGameDisabeled = false
    @State private var alertItem : AlertItem?
    @State private var currentPlayer : player?
    
    var body: some View {
        GeometryReader{geometry in
            VStack{
                Spacer()
                
                LazyVGrid(columns:columns)
                {
                    ForEach(0..<9){
                        i in
                        ZStack{
                            
                            Circle()
                                .foregroundColor(.green).opacity(0.5)
                                .frame(width: geometry.size.width/3 - 15,
                                       height:geometry.size.height/5 - 35)
                            Image(systemName: moves[i]?.x_or_o ?? "")
                                .resizable()
                                .frame(width: 40, height:40)
                                .foregroundColor(.blue)
                            
                        }
                        .onTapGesture {
                            
                            if isCircleOccupied(in: moves, forIndex: i){ return }
                            moves[i]=Move(player : .human, boardIndex: i)
                            
                            
                            //check on win condition
                            if checkWinCondition(for: .human, in: moves) == true
                            {
                                alertItem = AlertContext.humanWin
                                return
                            }
                   
                            if(checkForDraw(in: moves)){
                                alertItem = AlertContext.draw
                                return
                            }
                            
                            
                            isGameDisabeled = true
                            
                            
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                            
                             isGameDisabeled = false

                                
                                let computerPosition = findBestMove(moves: &moves)
                                
                                moves[computerPosition]=Move(player : .computer, boardIndex: computerPosition)
                                
                                if checkWinCondition(for: .computer, in: moves) == true
                                {
                                    alertItem = AlertContext.computerWin
                                    return
                                }
                                
                                if(checkForDraw(in: moves)){
                                    alertItem = AlertContext.draw
                                    return
                                }
                                
                            }
                
                            
                        }
                    }
                }
                Spacer()
            }
            .disabled(isGameDisabeled)
            .padding()
            .alert(item:$alertItem , content : { alertItem in
                
                Alert(title: alertItem.title,
                     message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: {resetGame()}))
            } )

    }
}
    func isCircleOccupied(in moves: [Move?], forIndex index :Int) ->Bool{
        return moves.contains(where :{$0?.boardIndex==index})
        }
    
     func determineComputerMovePosition(in moves:[Move?]) -> Int{
         
        var movePosition=Int.random(in: 0..<9)
         while isCircleOccupied(in: moves, forIndex: movePosition)
         {
            movePosition=Int.random(in: 0..<9)
         }
         return movePosition
         
       //  if moves[4] == nil
        // {
        //     return 4
        // }
        // else{
         //    return minimax(in: moves,)
        //    }
      
     }
    
    
    func findBestMove(moves :inout [Move?]) ->Int {
        var bestEval = Int.min
        var bestMove = -1
        for move in moves.compactMap{ $0 }.map{ $0.boardIndex }
        {
            let result = minimax(moves: &moves, maximizing: false)
            if result > bestEval{
                
                bestEval=result
                bestMove=move
            }
            
            
        }
        return bestMove
    }
    
    
  //  func minimax(in moves: inout [Move?],player: player) -> Int
   // {
        
    //      var movePosition=Int.random(in: 0..<9)
    //      while isCircleOccupied(in: moves, forIndex: movePosition)
     //     {
     //        movePosition=Int.random(in: 0..<9)
     //     }
     //     return movePosition
        
       // var maxPlayer : player = .computer
//var minPlayer : player = .human
        
        
      //  if checkWinCondition(for: minPlayer, in: moves)
     //   {
      //      return 1 + (9 - moves.compactMap { $0 }.count)
      //  }
      //  else
      //      if checkWinCondition(for: maxPlayer, in: moves)
      //  {
      //      return -(1 + (9 - moves.compactMap { $0 }.count))
       // }
      //  else
      //      if checkForDraw(in: moves)
//{
      //      return 0
     //   }
        
      //  var best: Int?
        
     //   if player == maxPlayer
       // {
      //       best = -999999
      //  }
      //  else{
     //       best =  999999
      //  }
        
       // var i:Int=0
        
      //  for move in moves{
      //      if(move == nil){
       //         moves[i] = Move(player: player ,boardIndex: i)
       //         var score: Int = minimax(in: &moves, player: minPlayer)
                
         //   }
        //    i+=1
            
      //  }
        
      //  moves[i]=nil
        
   // }
    
   // }
    
    
  func minimax(moves: inout [Move?], maximizing: Bool) ->Int{
        
        if checkWinCondition(for: .human, in: moves){return -1}
       else if checkWinCondition(for: .computer, in: moves){return 1}
        else if checkForDraw(in: moves){return 0}
        
       if maximizing{
            
           var bestEval = Int.min
           var i:Int=0
           for move in moves{
            
               if move != nil {
                   
               moves[i]=Move(player: .computer, boardIndex: i)
               let result = minimax(moves: &moves , maximizing: false)
                
               bestEval = max(result,bestEval)
                moves[i] = nil
                   
               }
               i = +1
            }
            return bestEval
            
        }
        else
            
       {
            var worstEval = Int.max
            var i:Int = 0
            for move in moves{
               
                if move != nil {
                moves[i]=Move(player: .human, boardIndex: i)
                
                let result = minimax(moves: &moves , maximizing: true)
                
                worstEval = min(result,worstEval)
                
                    moves[i] = nil
                    
                }
                i += 1
                
            }
            return worstEval
        }
        
    }
    
    
    
    func checkWinCondition(for player: player, in moves: [Move?]) -> Bool{
        
        let winPatterns : Set<Set<Int>> = [[0,1,2],[3,4,5],[6,7,8],[0,3,6],[1,4,7],[2,5,8],[0,4,8],[2,4,6]]//posibilele combinatii pe tabla pentru a castiga
        
        let playMoves = moves.compactMap { $0 }.filter { $0.player == player }//linie care elimina toate valorile nule din array-ul de moves si apoi aplica un filtru care selecteaza doar miscarile care apartin unui jucator (computer sau user)
        let playerPositions = Set(playMoves.map { $0.boardIndex })//pozitiile  unui jucator
        
        for pattern in winPatterns where pattern.isSubset(of: playerPositions){
            return true
        }
        
        
        return false
    }
    
    func checkForDraw(in moves : [Move?]) -> Bool
    {
        return moves.compactMap { $0 }.count == 9
        //daca toate pozitiile de pe tabla sunt ocupate
    }
    
    func resetGame (){
        moves = Array(repeating: nil, count: 9)
        
    }
}


enum player
{
    case human
    case computer
    case nobody
}

struct Move{
    
    let player : player
    let boardIndex: Int
    var x_or_o:String{
        
        if player == .human{ return "xmark" }
        else if player == .computer{ return "circle" }
        return " "
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




struct Board {
    
    let board : [Move]
    let turn : player
    
    init (board : [Move] = Array(repeating: Move(player: .nobody, boardIndex: -1), count: 9),turn : player = .human){
         
        self.board = board
        self.turn = turn
    }
    
    
    
}
