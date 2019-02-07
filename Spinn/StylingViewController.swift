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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = bgColor
    

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
