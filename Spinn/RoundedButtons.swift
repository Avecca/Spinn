//
//  RoundedButtons.swift
//  Spinn
//
//  Created by Hanna Astlind on 2019-02-19.
//  Copyright © 2019 Hanna Astlind. All rights reserved.
//

import UIKit

@IBDesignable class MyRoundedButton: UIButton
{
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }
    
    func updateCornerRadius() {
        layer.cornerRadius = rounded ? frame.size.height / 2 : 0
        layer.borderWidth = 3
        contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        
    }
}
