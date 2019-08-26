//
//  Shadow.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 24/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    func setShadowView(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
    }
    
    func shadowActivity(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 2
        self.layer.shouldRasterize = true
    }
}

extension UIButton{
    func setShadowButton(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 10)
        self.layer.shadowRadius = 5
        self.layer.shouldRasterize = true
    }
}
