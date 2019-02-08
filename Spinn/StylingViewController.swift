//
//  StylingViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-06.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class StylingViewController: UIViewController {
    
    let bgColor = #colorLiteral(red: 0.6305440068, green: 0.8406034112, blue: 0.5077832937, alpha: 1)
    var player: Player?
    var playerArray: [Player] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
    
    }
    
    func addPlayer(name: String)  {
        
        if( !playerArray.contains(where: { $0.getName()  == name})) {
            print("Adding player with name \(name)")
            playerArray.append(Player(name))
        } else {
        }
        
        for player in playerArray {
            print(player.getName())
        }
        
    }
    
    func addPlayerPoints(playerName: String , points: Int)  {
 
        if let i = playerArray.firstIndex(where: { $0.getName() == playerName}) {
            
            playerArray[i].addingPoints(addPoints: points)
        }
        
    }
    
    func removePlayer(index: Int) -> Bool {
//        if let i = playerArray.firstIndex(where: { $0.getName() == playerName}) {
//
//            playerArray.remove(at: i)
//        }
        print("Removing Player in Styling")
        print("Index är \(index)")
       // let i =
        for item in playerArray {
            print(item)
        }
        
        
            playerArray.remove(at: index)
            print("player removed!")
            return true
     
        
        
 
    }
    
    func nilPlayerArray()  {
        playerArray.removeAll()
        
        if playerArray.isEmpty {
            print("Arreyen är nollad")
        }
        
    }
    


}
