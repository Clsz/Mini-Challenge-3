//
//  Slide.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 04/09/19.
//  Copyright © 2019 11. All rights reserved.
//

import Foundation
import UIKit

class Slide: UIView{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myDescription: UILabel!
    @IBOutlet weak var myButton: UIButton!
    
    var listener: OnBoardingInputData?
    
    @IBAction func nextTapped(_ sender: UIButton){
        listener?.didTap()
    }
}
