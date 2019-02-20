//
//  SpinnViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

class SpinnViewController: UIViewController {
    
    var recievingSubject: String?
    var recievingColor : UIColor?
    let segId = "segueToPointId"
    let btnFont = "Bradley Hand"
    let btnSize = 48 as CGFloat

    //swedishversion variables
    let sweTruth = "Sanning"
    let sweDare = "Konka"
    let spinn = Spinn()
    
    
    @IBOutlet weak var truthBtn: UIButton!
    @IBOutlet weak var dareBtn: UIButton! //{
    @IBOutlet weak var orBtn: UILabel!
    @IBOutlet weak var spinnBtn: UIButton!
    @IBOutlet weak var spinnImgBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testBtn.text = recievingSubject
        print("\(String(describing: recievingSubject)) spinn!")
        
        truthBtn.setTitle(NSLocalizedString("truth_btn", comment: ""), for: .normal)
        dareBtn.setTitle(NSLocalizedString("dare_btn", comment: ""), for: .normal)
        
        spinnBtn.setTitle(NSLocalizedString("spinn", comment: ""), for: .normal)
        spinnBtn.titleLabel?.font = UIFont(name: btnFont, size: btnSize)

        
        //changes based on background color
        changesOnSubjectChoosen()
        

        
    }
    

    
    @IBAction func truthDareBtns(_ sender: Any) {
        //OBS sender: sender istället för sender: self för att få detta att funka
         performSegue(withIdentifier: segId, sender: sender)
        
    }
    //When you want to spinn the arrow
    @IBAction func spinnBtnAction(_ sender: Any) {
        
        //TODO TESTA DETTA IGEN
//        let rotateImg = CABasicAnimation(keyPath: "transform.rotation") //.z
//        //let randomAngle = arc4random_uniform(361) + 360
//        rotateImg.fromValue = 0.0
//        rotateImg.toValue = CGFloat(.pi * 2.0)//Float(randomAngle) * .pi  / 180
//        //CGFloat(.pi * 2.0) // 1 //((360*M_PI)/180)
//        rotateImg.duration = 1.0
//        rotateImg.repeatCount = Float.infinity //0//Float.infinity
//        rotateImg.isRemovedOnCompletion = false
//        spinnImgBtn.layer.add(rotateImg, forKey: nil)
        
        
        spinnBtn.setTitle(NSLocalizedString("de_spinn", comment: ""), for: [] )
        spinnBtn.setTitle(NSLocalizedString("de_spinn", comment: ""), for: .normal)
        
        //spinnBtn.titleLabel?.text = "RE SPINN"
        
        
        //Disable the buttons while image is spinning
        disableBtnsWhileSpinning()

        //Start spinning the arrow image button
        self.rotateImage()
        
        //create a random delay to stop the spinning at
        let delay: Float = spinn.delay()

        //after random delay stop the spinning
        self.endSpinn(delay: delay)
  
        
    }
    
    
    func changesOnSubjectChoosen() {
        
        //Set the background to the topics color
        view.backgroundColor = recievingColor
        
        if recievingSubject == "romance_topic" {
            
            //TODO ta bort en?
            dareBtn.setTitleColor(UIColor.white, for: [] )
            dareBtn.setTitleColor(UIColor.white, for: .normal)
            dareBtn.titleLabel?.textColor = .white
        } else {
            
            //TODO ta bort en?
            dareBtn.setTitleColor(UIColor.red, for: .normal)
            dareBtn.titleLabel?.textColor = .red
            
        }
        
        if recievingSubject == "physical_topic" {//
            orBtn.textColor = .white
            spinnImgBtn.setImage(UIImage(named: "loction_arrow_red"), for: .normal)
            
        }
        
    }
    
    //Rotate the arrow image
    func rotateImage() {
        
        let btn = self.spinnImgBtn as UIButton
        
        //start spinning the mentioned btn
        spinn.rotateImage(btn: btn)
        
    }
    

    // End the spinning after a random amount of double
    func endSpinn(delay: Float) {
        
        DispatchQueue.main.asyncAfter(deadline: (.now() + Double(delay))) {
            
           self.spinn.endSpinn()
            
            //TODO Knapparna ska visas och enableas
        self.showBtnsAfterSpinn()
        }
        
        


    }

    
    func disableBtnsWhileSpinning() {
        
        self.truthBtn.isEnabled = false
        self.dareBtn.isEnabled = false
        self.spinnImgBtn.isEnabled = false
        self.spinnBtn.isEnabled = false
        
    }
    
    func showBtnsAfterSpinn() {
        
        self.truthBtn.isHidden = false
        self.dareBtn.isHidden = false
        self.orBtn.isHidden = false
        self.truthBtn.isEnabled = true
        self.dareBtn.isEnabled = true
        self.spinnImgBtn.isEnabled = true
        self.spinnBtn.isEnabled = true
        
    }
    
 
    //Segue to next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //print("Testing recieing from cell if \(recievingSubject) is nil")
        
         if segue.identifier == segId {
            let btn = sender as! UIButton
            
            let btnType = btn.titleLabel?.text as! String
        
           // print("prepare  \(btnType) is not nil")
            
            let destinationVC = segue.destination as! QuestionViewController
            destinationVC.recievingSubject = recievingSubject
            
            if btnType == sweDare {
                
                destinationVC.recievingType = "dare"
            
            } else if btnType == sweTruth {
                destinationVC.recievingType = "truth"
            } else {
                destinationVC.recievingType = btnType.lowercased()
            }
            
            destinationVC.recievingColor = self.recievingColor
            
            
        }
    }
    
}



//
//        UIView.animateWithDuration(1.0, delay: 0, options: .CurveLinear, animations: { () -> Void in
//            self.mySpinnerView.transform = CGAffineTransformRotate(self.spinnImgBtn.transform, CGFloat(M_PI))
//        }) { (finished) -> Void in
//            self.beginAnimation()
//        }




//CGAffineTransform  (by: .pi)

//    func beginAnimation() {
//        UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: { <#T##() -> Void#> in self.mySpinnerView.transform = CGAffineTransformRotate(self.spinnImgBtn.transform, CGFloat(M_PI))
//        } ,completion: { -> Void in self.beginAnimation() })
//
//    }


//
//    func animat()
//    {
//
////        UIView.animate(withDuration: <#T##TimeInterval#>, delay: <#T##TimeInterval#>, options: <#T##UIView.AnimationOptions#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//
//    }




//spinnImgBtn.layer.add(rotateImg, forKey: "360")

//rotateImg.delegate = transitioningDelegate

//spinnImgBtn.layer.add(rotateImg, forKey: nil)  DETTA


//        spinnImgBtn.transform = spinnImgBtn.transform.rotated(by: CGFloat.pi/10)


//        UIView.animate(withDuration: 1.0, animations: ({
//
//            self.spinnImgBtn.transform = self.spinnImgBtn.transform.rotated(by: 670)
//        }))
//self.spinnImgBtn

//self.spinnImgBtn.transform = self.spinnImgBtn.transform.rotated(by: 240)

//UIView.ani



//dareBtn.setTitleColor(UIColor.red, for: .normal)
//(sender as! UIButton).setTitle("RE SPINN", for: [] )
//(sender as! UIButton).setTitle("RE SPINN", for: .normal)




//     lazy var animator : UIViewPropertyAnimator = UIViewPropertyAnimator(duration: 10.5, curve: .linear, animations: {
//
//        self.spinnImgBtn.transform = CGAffineTransform(rotationAngle: 360) //CGAffineTransform(translationX: 0.0, y: 200)
//    })




//        self.paused = false
//        self.animator.startAnimation()

//self.beginAnimation()



//
//func beginAnimation() {
//    UIView.animate(withDuration: 1.0, delay: 0, options: .curveLinear, animations: { self.spinnImgBtn.transform = self.spinnImgBtn.transform.rotated(by: .pi / 180)
//    })
//
//}



//    @IBAction func stopBtn(_ sender: Any) {
//
//        //self.spinnImgBtn.layer.removeAllAnimations()
//        //self.spinnImgBtn.layer.
//
////        if self.animator.state == .active {
////
////            self.paused = !self.paused
////            self.paused ? self.animator.pauseAnimation() : self.animator.startAnimation()
////
////        }
//
////        if spinnImgBtn.layer.animation(forKey: SpinnViewController.kRotationAnimationKey) != nil {
////            spinnImgBtn.layer.removeAnimation(forKey: SpinnViewController.kRotationAnimationKey)
////        }
//
//
//
//        self.finished = true
//        print("\(finished) är boolen")
//        //spinnImgBtn.layer.removeAllAnimations()
//
//    }




//var paused = false
