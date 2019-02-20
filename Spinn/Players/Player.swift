//
//  Player.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-07.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation




struct Player {  //TODO använd Struct eller class
    //struct kan inte använda arv och objecten kan inte refereras på från flera olika instanser
    
    private var playerName: String
    private var playerPoints = 0
    
    init(_ name: String){
        
//        guard let validName = name else {
//            print("Couldnt add player by name \(name)")
//            return
//        }
        
        self.playerName = name //validName
        self.playerPoints = 0
        
    }
    
    
    mutating func addingPoints(addPoints: Int) {
        
        //self.playerPoints += addPoints  //med class
        self.playerPoints += addPoints //med struct add mutating func
    }
    
    func getName() -> String {
        return playerName
    }
    
    func getPoints() -> Int {
        return playerPoints
    }
}
