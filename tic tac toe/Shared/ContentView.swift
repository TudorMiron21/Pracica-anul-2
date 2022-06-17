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
                                .foregroundColor(.green).opacity(0.8)
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
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
                                
                                let computerPosition=determineComputerMovePosition(in: moves)
                                moves[computerPosition]=Move(player : .computer, boardIndex: computerPosition)
                            }
                
                            
                        }
                    }
                }
                Spacer()
            }
            .padding()

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
    }
}


enum player
{
    case human
    case computer
}

struct Move{
    
    let player : player
    let boardIndex: Int
    var x_or_o:String{
        return player == .human ? "xmark" : "circle"
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

