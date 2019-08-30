//
//  ListRecyclableTableViewCell.swift
//  Mini Challenge 3
//
//  Created by Steven Gunawan on 23/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ListRecyclableTableViewCell: UITableViewCell {
    
    var listSampah = [CKRecord]()
    var imageSampah: UIImage?
    
    @IBOutlet weak var listSampahCV: UICollectionView!
    @IBOutlet weak var jenisSampah: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        listSampahCV.delegate = self
        listSampahCV.dataSource = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension ListRecyclableTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSampah.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LRecyclableCVCell", for: indexPath) as! ListRecyclableCollectionViewCell
        
        let harga = listSampah[indexPath.row].value(forKey: "wastePrice") as? Int
        cell.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
        cell.namaSampah.text = listSampah[indexPath.row].value(forKey: "wasteName") as? String
        cell.gambarSampah.image = imageSampah
        
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 5
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
        
    }
    
}


