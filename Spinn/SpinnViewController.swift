//
//  SpinnViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class SpinnViewController: UIViewController {
    
    var recievingSubject: String?
    var recievingColor : UIColor?
    let segId = "segueToPointId"
    let btnFont = "Bradley Hand"
    let btnSize = 48 as CGFloat

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //testBtn.text = recievingSubject
        print("\(String(describing: recievingSubject)) spinn!")
        
        
        spinnBtn.setTitle("SPINN", for: .normal)
        spinnBtn.titleLabel?.font = UIFont(name: btnFont, size: btnSize)
        
        
        view.backgroundColor = recievingColor
        
        if recievingSubject == "Romance" {
            
            //TODO ta bort en?
            dareBtn.setTitleColor(UIColor.white, for: [] )
            dareBtn.setTitleColor(UIColor.white, for: .normal)
            dareBtn.titleLabel?.textColor = .white
        } else {
            
            //TODO ta bort en?
            dareBtn.setTitleColor(UIColor.red, for: .normal)
            dareBtn.titleLabel?.textColor = .red
            
        }
        
        if recievingSubject == "Physical" {//
            orBtn.textColor = .white
            spinnImg.image = UIImage(named: "loction_arrow_red")
            
        }
        

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var spinnImg: UIImageView!
    @IBOutlet weak var truthBtn: UIButton!
    @IBOutlet weak var dareBtn: UIButton! //{
    @IBOutlet weak var orBtn: UILabel!
    @IBOutlet weak var spinnBtn: UIButton!
    
    
    @IBAction func truthDareBtns(_ sender: Any) {
        //OBS sender: sender istället för sender: self för att få detta att funka
         performSegue(withIdentifier: segId, sender: sender)
        
    }
    
    @IBAction func spinnBtnAction(_ sender: Any) {
        
        
        truthBtn.isHidden = false
        dareBtn.isHidden = false
        orBtn.isHidden = false
        
        //dareBtn.setTitleColor(UIColor.red, for: .normal)
        (sender as! UIButton).setTitle("RE SPINN", for: [] )
        (sender as! UIButton).setTitle("RE SPINN", for: .normal)
        
        //spinnBtn.titleLabel?.text = "RE SPINN"
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("Testing recieing from cell if \(recievingSubject) is nil")
        
         if segue.identifier == segId {
            let btn = sender as! UIButton
            
            let btnType = btn.titleLabel?.text as! String
        
            print("prepare  \(btnType) is not nil")
            
            let destinationVC = segue.destination as! QuestionViewController
            destinationVC.recievingSubject = recievingSubject
            destinationVC.recievingType = btnType
            
        }
    }
    
}
