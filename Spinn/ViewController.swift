//
//  ViewController.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-01-17.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

class ViewController: StylingViewController  {
    
    let segueId = "segueToSubjectId"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    @IBAction func rdyToiPlatBtn(_ sender: Any) {
        
        performSegue(withIdentifier: segueId, sender: self)
    }
    @IBAction func addPlayer(_ sender: Any) {
        super.addPlayer(name: "Hanna")
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        print("Override händer")
        
        let destinationVC = segue.destination as! SubjectViewController
        destinationVC.recievingName = nil
    }
    
}

