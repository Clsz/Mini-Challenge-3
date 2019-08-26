//
//  PickUpViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class PickUpViewController: UIViewController {
    
    // Variables
    let imagesButton = [UIButton]()
    let cellID = "evidenceID"
    
    //Outlets
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var evidenceCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func learnMoreTapped(_ sender: UIButton) {
    }
    
}
//extension PickUpViewController:UICollectionViewDataSource, UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        <#code#>
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        <#code#>
//    }
//    
//    
//}
