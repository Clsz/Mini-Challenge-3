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
    @IBOutlet weak var listSampahCV: UICollectionView!
    @IBOutlet weak var jenisSampah: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        cellDelegate2()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}



    
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //    }
    
//    func cellDelegate2(){
//        listSampahCV.dataSource =  self
//        listSampahCV.delegate = self
//    }

//func queryDatabase() {
//    let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
//    CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
//        guard let records = records else { return }
//        //            print(records)
//        let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
//        self.listSampah = sortedRecords
//        DispatchQueue.main.async {
//            self.listSampahCV.reloadData()
//        }
//    }
//}
//
//extension ListRecyclableTableViewCell
//{
//    func setCollectionViewDataSourceDelegate
//        <D: UICollectionViewDelegate & UICollectionViewDataSource>
//        (_  dataSourceDelegate: D, forRow row: Int)
//    {
//        listSampahCV.delegate = dataSourceDelegate
//        listSampahCV.dataSource = dataSourceDelegate
//        
//        listSampahCV.reloadData()
//    }
//}
