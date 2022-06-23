//
//  CardView.swift
//  slots app
//
//  Created by cetasc mta on 24.06.2022.
//

import SwiftUI

struct CardView: View {
    @Binding var symbol : String
    @Binding var backround: Color
    
    var body: some View {
        
        Image(symbol)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .background(backround.opacity(0.5))
            .cornerRadius(30)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(symbol: Binding.constant("apple"), backround: Binding.constant(Color.green))
    }
}
