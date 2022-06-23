//
//  ContentView.swift
//  Shared
//
//  Created by cetasc mta on 23.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var credits = 10
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
                        
                        CardView(symbol: $symbols[numbers[0]],backround: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]],backround: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]],backround: $backgrounds[2])
                        
                        Spacer()
                    }
                    HStack{
                        
                        Spacer()
                        
                        CardView(symbol: $symbols[numbers[0]],backround: $backgrounds[0])
                        CardView(symbol: $symbols[numbers[1]],backround: $backgrounds[1])
                        CardView(symbol: $symbols[numbers[2]],backround: $backgrounds[2])
                        
                        Spacer()
                    }                }
                Spacer()
                
                Button {
                    //
                    
         
                    
                    self.backgrounds=self.backgrounds.map{ _ in Color.white }
                    
                    self.numbers = self.numbers.map({_ in Int.random(in: 0...self.symbols.count - 1)})
                    
                    //self.numbers[0] = Int.random(in: 0...self.symbols.count - 1 )
                    //self.numbers[1] = Int.random(in: 0...self.symbols.count - 1 )
                    //self.numbers[2] = Int.random(in: 0...self.symbols.count - 1 )
                    
                    if self.numbers[0] == self.numbers[1] && self.numbers[1] == self.numbers[2]
                    {
                        //win condition
                        self.credits += betAmount * 10
                        //update backround to green
                        
                        self.backgrounds=self.backgrounds.map{ _ in Color.green }
                    }
                    else
                    {
                        self.credits -= betAmount
                    }

                } label: {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all,10)
                        .padding([.leading, .trailing],30)
                        .background(.mint)
                        .cornerRadius(15)
                }
            
                Spacer()

                
            }
        
            
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
