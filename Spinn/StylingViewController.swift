//
//  StylingViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-06.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class StylingViewController: UIViewController {
    
    //let bgColor = #colorLiteral(red: 0.6305440068, green: 0.8406034112, blue: 0.5077832937, alpha: 1)
   // let bgColor2 = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    let bgGold = UIColor(red: 255/255, green: 215/255, blue: 0, alpha: 1) //rgb(255,215,0)
    let layer = CAGradientLayer()
   // static var playersTestArray : [Player] = []// = GamePlay()
    let btnFont = "Rockwell-Bold"
    let btnSize = 32
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBackgroundStyling()
    }
    
    //Hides the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    func addBackgroundStyling() {
        
        //Split color at the diagonal
        layer.frame = view.bounds //hela skärmen
        //layer.colors?[UIColor.yellow.cgColor,UIColor.green.cgColor]

        layer.colors = [UIColor.red.cgColor, bgGold.cgColor]
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 1)
        
        //IF backgrouund color make sure the layer is underneath all other elements
        self.view.layer.insertSublayer(layer, at: 0)
        
  
    }
    
}


//Picture background
//        let bgImg = UIImageView(frame: UIScreen.main.bounds)
//        bgImg.image = UIImage(named: "YSparkle")
//        bgImg.contentMode = UIView.ContentMode.scaleAspectFill
//        self.view.insertSubview(bgImg, at: 0)


//view.backgroundColor = bgGold
