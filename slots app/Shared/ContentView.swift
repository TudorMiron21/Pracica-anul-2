//
//  ContentView.swift
//  Shared
//
//  Created by cetasc mta on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var credits = 1000
    @State private var symbols = ["apple","star","cherry"]
    @State private var numbers = Array(repeating: 0 , count: 9)
    @State private var backgrounds = Array(repeating: Color.white, count: 9)
    
                                      @State private var betAmount = 1
    var body: some View {
       ZStack{
            
           Rectangle().foregroundColor(.blue).ignoresSafeArea()
           
           Rectangle().foregroundColor(Color(red: 102/255, green: 212/255, blue: 207/255)).opacity(0.5).rotationEffect(Angle(degrees:45)).ignoresSafeArea()
           
            
            VStack{
                Spacer()
                //title
               
                
                HStack{
                    
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("My Pacanea!").bold().foregroundColor(.white)
                    Image(systemName: "star.fill").foregroundColor(.yellow)

                }.scaleEffect(2)
                
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all,10)
                    .background(.white.opacity(0.5))
                    
                    .cornerRadius(20)
                Spacer()
                Text("Bet: " + String(betAmount))
                    .foregroundColor(.black)
                    .padding(.all,10)
                    .background(.white.opacity(0.5))
                    
                    .cornerRadius(20)
             
                //Spacer()
                
                HStack{
                    
                    Button{
                        self.betAmount=1
                    }label: {
                        Text("1")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,10)
                            .padding([.leading, .trailing],30)
                            .background(.mint)
                            .cornerRadius(15)
                        
                    }
                    
                    Button{
                        self.betAmount=5
                    }label: {
                        Text("5")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,10)
                            .padding([.leading, .trailing],30)
                            .background(.mint)
                            .cornerRadius(15)
                        
                    }
                    
                    Button{
                        self.betAmount=10
                    }label: {
                        Text("10")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,10)
                            .padding([.leading, .trailing],30)
                            .background(.mint)
                            .cornerRadius(15)
                        
                    }
                }
                
                VStack{
                HStack{
                    
                    Spacer()
                    
                    CardView(symbol: $symbols[numbers[0]],backround: $backgrounds[0])
                    CardView(symbol: $symbols[numbers[1]],backround: $backgrounds[1])
                    CardView(symbol: $symbols[numbers[2]],backround: $backgrounds[2])
                    
                    Spacer()
                }
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[3]],backround: $backgrounds[3])
                        CardView(symbol: $symbols[numbers[4]],backround: $backgrounds[4])
                        CardView(symbol: $symbols[numbers[5]],backround: $backgrounds[5])
                        
                        Spacer()
                    }
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[6]],backround: $backgrounds[6])
                        CardView(symbol: $symbols[numbers[7]],backround: $backgrounds[7])
                        CardView(symbol: $symbols[numbers[8]],backround: $backgrounds[8])
                        
                        Spacer()
                    }                }
                Spacer()
                HStack{
                    
                Button {
                    
                    //
                    self.processResults()
    
                } label: {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all,10)
                        .padding([.leading, .trailing],30)
                        .background(.mint)
                        .cornerRadius(15)
                }
                    
                    Button {
                        
                        //
                        self.processResults(true)
        
                    } label: {
                        Text("Max Spin(5 X Spin)")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all,10)
                            .padding([.leading, .trailing],30)
                            .background(.mint)
                            .cornerRadius(15)
                    }
                       
                    
            }
            
                Spacer()

                
            }
            
        
            
        }
        
    }
    
    func processResults(_ isMax:Bool = false){
        
        if credits>0{
        self.backgrounds=self.backgrounds.map{ _ in Color.white }
        
        
        if isMax{
            
            //spin all the cards
            self.numbers = self.numbers.map({_ in Int.random(in: 0...self.symbols.count - 1)})

        }
        else{
            
            //spin the middle row
            self.numbers[3] = Int.random(in: 0...self.symbols.count - 1 )
            self.numbers[4] = Int.random(in: 0...self.symbols.count - 1 )
            self.numbers[5] = Int.random(in: 0...self.symbols.count - 1 )
        }
        
        processWin(isMax)
            
        }
        else{
            self.credits = 0
            
        }
        
    }
    
    func isMatch(_ index1: Int ,_ index2:Int,_ index3:Int) ->Bool{
        
        if self.numbers[index1] == self.numbers[index2] && self.numbers[index2] == self.numbers[index3]{
            self.backgrounds[index1] = Color.green
            self.backgrounds[index2] = Color.green
            self.backgrounds[index3] = Color.green
            
        }
        return false
    }
    
    func processWin(_ isMax: Bool = false){
        //check the matches
        
        var matches = 0
        if !isMax{
          
            //processing for single spin
            if self.numbers[3] == self.numbers[4] && self.numbers[4] == self.numbers[5]
            {
                //win condition
                matches += 1
                //update backround to green
                
                //self.backgrounds=self.backgrounds.map{ _ in Color.green }
                self.backgrounds[3] = Color.green
                self.backgrounds[4] = Color.green
                self.backgrounds[5] = Color.green
            }
            else
            {
                self.credits -= betAmount
            }
        }else{
            
            //processing for single spin
            
            //top row
            if isMatch(0, 1, 2){matches += 1}
            //middle row
            if isMatch(3, 4, 5){matches += 1}
            //last row
            if isMatch(6, 7, 8){matches += 1}
            //first diagonal
            if isMatch(0, 4, 8){matches += 1}
            //second diagonal
            if isMatch(2, 4, 6){matches += 1}
            
            //chech for number of matches
            if matches > 0
            {
                self.credits += matches * betAmount * 5
            }
            
            else if !isMax
            {
                //0 wins, single spin
                self.credits -= betAmount
                
            }else
            {
                //0 wins, max spin
                self.credits -= betAmount * 5
            }
        }
        
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
