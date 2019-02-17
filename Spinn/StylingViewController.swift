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
    let bgColor2 = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
   // static var playersTestArray : [Player] = []// = GamePlay()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layer = CAGradientLayer()
        layer.frame = view.bounds //hela skärmen
        //layer.colors?[UIColor.yellow.cgColor,UIColor.green.cgColor]
        
        layer.colors = [bgColor2.cgColor, bgColor.cgColor]
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 1)
        self.view.layer.insertSublayer(layer, at: 0)
        
        //view.backgroundColor = bgColor2
    
    }
    
//    func addPlayer(name: String)  {
//        
//        if( !GamePlay.playerArray.contains(where: { $0.getName()  == name})) {
//            print("Adding player with name \(name)")
//            GamePlay.playerArray.append(Player(name))
//        } else {
//        }
//        
//        for player in GamePlay.playerArray {
//            print(player.getName())
//        }
//        
//    }
    


}
