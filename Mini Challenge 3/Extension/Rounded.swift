//
//  Rounded.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 22/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    func setRounded(){
        self.layer.masksToBounds = false
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.cornerRadius = self.frame.height/2
        self.clipsToBounds = true
    }
    
    func littleRound(){
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
    }
    
}

extension UIView {
    
    func setRoundedView(){
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
    func littleRoundView(){
        self.layer.cornerRadius = 12.0
        self.clipsToBounds = false
    }
    
    func littleRoundCondition(){
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = false
    }
    
    func reallyRound(){
        self.layer.cornerRadius = 8
        self.clipsToBounds = false
    }
    
    func barRound(){
        self.layer.cornerRadius = 2.5
        self.clipsToBounds = false
    }
    
    func pickRound(){
        self.layer.cornerRadius = 13
        self.clipsToBounds = false
    }
    
    func statusRound(){
        self.layer.cornerRadius = 14.5
        self.clipsToBounds = false
    }
    
    func acceptRound(){
        self.layer.cornerRadius = 21
        self.clipsToBounds = false
    }
    
}

extension UIButton{
    func littleRoundButton(){
        self.layer.cornerRadius = 12
        self.clipsToBounds = false
    }
}

extension String {
    func isValidEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
