//
//  SubjectCollectionViewCell.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-01-25.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class SubjectCollectionViewCell: UICollectionViewCell {
    

    var subject : String?
    
    @IBOutlet weak var subjectBtnView: UIButton! {
        didSet{
            subjectBtnView.backgroundColor = UIColor.white //.clear
            
            subjectBtnView.layer.cornerRadius = 10
            subjectBtnView.layer.borderWidth = 3
            subjectBtnView.contentEdgeInsets = UIEdgeInsets(top: 7,left: 3,bottom: 5,right: 3)
            
            subjectBtnView.layer.shadowColor = UIColor.lightGray.cgColor
            subjectBtnView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            subjectBtnView.layer.shadowRadius = 2.0
            subjectBtnView.layer.shadowOpacity = 1.0
            subjectBtnView.layer.masksToBounds = false
            subjectBtnView.layer.shadowPath = UIBezierPath(roundedRect: subjectBtnView.bounds, cornerRadius: subjectBtnView.layer.cornerRadius).cgPath
            //subjectBtnView.accessibilityActivate()
            
            
        }
        
        //Skapa en klass att hålla dessa i istället 30 mins in
    }

    @IBAction func subjectBtnAct(_ sender: Any) { //TODO DETTA BEHÖVS INTE
       // print("Cellpress")
        if let text = subjectBtnView.titleLabel?.text { //currentTitle!
            let vc = SubjectViewController()
            
            vc.subject = text
            
            //print("\(text) is the cell subject")//t("\(text) is the cell subject")
    
        }
    }
    
    


    
    

    
    
    
}
