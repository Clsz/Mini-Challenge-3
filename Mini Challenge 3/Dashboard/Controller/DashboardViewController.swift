//
//  DashboardViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    // Variables
    let sortId = "sortID"
    var sortImages = [UIImage(named: "plastik"), UIImage(named: "metal"), UIImage(named: "kayu"), UIImage(named: "kaca"), UIImage(named: "kertas")]
    
    //Outlet
    @IBOutlet weak var sortCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
    }
    
    @IBAction func notifTapped(_ sender: UIButton) {
    }
    
}

extension DashboardViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    func cellDelegate(){
        sortCollectionView.dataSource = self
        sortCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sortId, for: indexPath) as! SortInfoCollectionViewCell
        cell.sortImage.image = sortImages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //performSegue(withIdentifier: <#T##String#>, sender: <#T##Any?#>)
    }
    
}
