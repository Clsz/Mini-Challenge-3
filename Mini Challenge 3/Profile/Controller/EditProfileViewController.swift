//
//  EditProfileViewController.swift
//  Mini Challenge 3
//
//  Created by Jerry Ming Ho on 26/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var imageEditProfile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageEditProfile.setRounded()
        
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
