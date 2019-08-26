//
//  ProfileViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
   

    @IBOutlet weak var profileImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    profileImage.setRounded()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
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
