//
//  Spinn.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit


class Spinn {
    
    var finished: Bool = false
    
    //min and max time the arrow is spinning
    let minDelay: Float = 2.5
    let maxDelay : Float = 11 //10 seconds
    
    //rotate a button
    func rotateImage(btn: UIButton)  {
        
        self.finished = false
        //print("\(finished) är boolen vid starttryck")
        
        UIView.animate( withDuration: 0.02,
                        delay: 0.0,
                        options: .curveLinear,
                        animations: {
                            
                            
                            btn.transform = btn.transform.rotated(by: .pi / 50) // CGAffineTransform(rotationAngle: .pi)//self.spinnImgBtn.transform.rotated(by: .pi)
                            //self.updateIcon.transform = CGAffineTransform(rotationAngle: .pi)
                        },
                        completion: { completed in
                            if !self.finished {
                                //print("\(self.finished) är boolen vid completed")
                                
                                self.rotateImage(btn: btn)
                            }
                        }
        )
        
        
    }
    
    //stop spinning when this function is called
    func endSpinn(delay: Float) {
        
        //print("\(delay) är doublelen")
        DispatchQueue.main.asyncAfter(deadline: (.now() + Double(delay))) {
            
            self.finished = true
            //print("\(self.finished) är boolen")
      
        }
    }
    
    //Random delay to stop the spinning at
    func delay() -> Float {
        
        return Float.random(in: minDelay ... maxDelay)
    }
    
}


