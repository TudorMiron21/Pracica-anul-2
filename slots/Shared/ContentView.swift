//
//  ContentView.swift
//  Shared
//
//  Created by cetasc mta on 24.06.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var credits = 1000
    var body: some View {
       ZStack{
            
           Rectangle().foregroundColor(.blue)
           
            
            
            
            VStack{
                //title
                
                HStack{
                    
                    Image(systemName: "star.fill").foregroundColor(.yellow)
                    Text("My Slots!").bold().foregroundColor(.white)
                    Image(systemName: "star.fill").foregroundColor(.yellow)

                }.scaleEffect(2)
                
                Text("Credits: " + String(credits))
                    .foregroundColor(.black)
                    .padding(.all,10)
                    .background(.white.opacity(0.5))
                    
                    .cornerRadius(20)
                
                //cards
                Spacer()
                HStack{
                    
                Spacer()
                    
                    Image("apple")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(30)
                    
                    Image("apple")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(30)
                    
                    Image("apple")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(30)
                    Spacer()
                }
                Spacer()
                
                Button {
                    //
                    self.credits += 1
                } label: {
                    Text("Spin")
                        .bold()
                        .foregroundColor(.white)
                        .padding(.all,10)
                        .padding([.leading, .trailing],30)
                        .background(.blue)
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
