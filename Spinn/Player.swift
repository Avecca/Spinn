//
//  Player.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-07.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation




class Player {
    
    private var playerName: String
    private var playerPoints = 0
    
    init(_ name: String){
        
//        guard let validName = name else {
//            print("Couldnt add player by name \(name)")
//            return
//        }
        
        self.playerName = name //validName
    }
    
    
    func addingPoints(addPoints: Int) {
        
        playerPoints += addPoints        
    }
    
    func getName() -> String {
        return playerName
    }
    
    func getPoints() -> Int {
        return playerPoints
    }
}
