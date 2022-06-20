//
//  Alerts.swift
//  tic tac toe (iOS)
//
//  Created by cetasc mta on 20.06.2022.
//

import Foundation
import SwiftUI

struct AlertItem :Identifiable{
    
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle:Text
}

struct AlertContext{
    
    let humanWin = AlertItem(title: Text("YOU WIN!!"),
                             message:Text("you are so smart"),
                             buttonTitle:Text("play again"))
    let computerWin = AlertItem(title: Text("YOU LOSE!!"),
                             message:Text("No wory, you can play again"),
                             buttonTitle:Text("play again"))
    let draw = AlertItem(title: Text("Draw!"),
                             message:Text("Boring game"),
                             buttonTitle:Text("play again"))}
