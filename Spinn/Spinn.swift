//
//  Spinn.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import AVFoundation


class Spinn {
    
    var finished: Bool = false
    
    //min and max time the arrow is spinning
    let minDelay: Float = 2.5
    let maxDelay : Float = 9 //8 seconds
    
    //sound
    var soundPlayer: AVAudioPlayer? // = AVAudioPlayer()
    //let arrowSound = URL(fileURLWithPath: Bundle.main.path(forResource: "arrow_sound.mp3", ofType: nil)!)
    
    //rotate a button
    func rotateImage(btn: UIButton)  {
        
        self.finished = false
        //print("\(finished) är boolen vid starttryck")
        
        UIView.animate( withDuration: 0.01,
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
    func endSpinn() {

            self.finished = true
            //print("\(self.finished) är boolen")

    }
    
    //Random delay to stop the spinning at
    func delay() -> Float {
        
        return Float.random(in: minDelay ... maxDelay)
    }
    
    
    func makeSound() {
        if let sound = NSDataAsset(name: "arrow_sound"){

            do {
                soundPlayer = try AVAudioPlayer(data: sound.data, fileTypeHint: "mp3") //try AVAudioPlayer(contentsOf: arrowSound)
                playOnRepeat()
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
    
    
    func playOnRepeat()  {
        soundPlayer?.numberOfLoops = -1
        soundPlayer?.enableRate = true
        soundPlayer?.rate = 8.0
        
        soundPlayer?.play()
        
    }
    
    func endSound()  {
        soundPlayer?.stop()
    }
    
    
}


