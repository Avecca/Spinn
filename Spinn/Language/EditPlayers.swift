//
//  EditPlayers.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import Foundation

struct EditPlayers {
    
    //var player: Player?
    static var playerArray: [Player] = []
    // static var playersTestArray : [Player] = []// = GamePlay()
    //var reverseArray: [Player] = []
    
//    init(){
//        playerArray = []
//
//    }
    
    //var choosenSubject : String?
    
    func addPlayer(name: String)  { //

        
        //TODO dubbelkolla, kanske görs 2 ggr
        if( !Players.playerArray.contains(where: { $0.getName()  == name})) {
           // print("Adding player with name \(name)")
            Players.playerArray.append(Player(name))
        } else {
        }

       // for player in Players.playerArray {
           // print(player.getName())
        //}

    }

    func addPlayerPoints(playerName: String , points: Int)  {

        if let i = Players.playerArray.firstIndex(where: { $0.getName() == playerName}) {

            Players.playerArray[i].addingPoints(addPoints: points)
        }

    }

    func removePlayer(index: Int) {

        Players.playerArray.remove(at: index)
        //print("player removed!")

    }
//
    func nilPlayerArray()  {
        Players.playerArray.removeAll()

//        if Players.playerArray.isEmpty {
//            print("Arreyen är nollad")
//        }

    }
    
    
   func orderPlayerArray()  {
        
        
        Players.orderedArray.removeAll()
        
        Players.orderedArray = Players.playerArray
        
//        for i in Players.playerArray {
//            print(i)
//        }
    
        Players.orderedArray.sort(by: { $0.getPoints() > $1.getPoints() })
        
    }
    
    
}
