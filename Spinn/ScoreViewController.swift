//
//  ScoreViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-04.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class ScoreViewController: StylingViewController {
    
    let segId = "unwindToSubjectViewId"
    var recievingName : String?
    var recievingPoint: Int? //Ta Bort sen!
    

    @IBOutlet weak var placeholderLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        placeholderLbl.text = "\(recievingName ?? "Name") \(recievingPoint ?? 2 )pts"

        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var nextBtnPressed: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == segId {
//             print("NextBtn CLICK!")
//        }  om unwindToSubjectViewId i score view controller scene unwind segue identifier
        
        if segue.identifier == segId {
            let destinationVC = segue.destination as! SubjectViewController
            
            if let name = recievingName{
                print("Not empty name")
                destinationVC.topicLbl.text = "\(name) Choose Topic"  
            }
            
            print("NextBtn CLICK!")
        }
      
    }
    
    //prepareForUnwind
    
//    @IBAction func unwindToSubjectView(segue: UIStoryboardSegue) {
//        performSegue(withIdentifier: segId, sender: self)
//    }
//    @IBAction func nextBtnClick(_ sender: Any) {
//
//
//        //performSegue(withIdentifier: segId, sender: self)
//    }
//
//     @IBAction func nextClick(_ sender: Any) {
//        print("NextBtn CLICK!")
//        self.performSegue(withIdentifier: segId, sender: self)
//     }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
