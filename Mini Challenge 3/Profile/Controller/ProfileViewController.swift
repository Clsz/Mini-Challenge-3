//
//  ProfileViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ProfileViewController: UIViewController {
   
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var users = [CKRecord]()
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phonenumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        profileImage.setRounded()
        queryDatabase()
    }
    
    @IBAction func unwindToProfileView(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? EditProfileViewController
        print(sourceViewController?.userEdit)
        // Use data from the view controller which initiated the unwind segue
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
//        queryDatabase()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editProfile = segue.destination as! EditProfileViewController
        editProfile.userEdit = users.first
    }
    
    func setView(){
        self.navigationItem.title = "Profile"
        let edit = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editProfile(_:)))
        self.navigationItem.rightBarButtonItem  = edit
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
    }
    
    func queryDatabase() {
        let query = CKQuery(recordType: "User", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.users = sortedRecords
            DispatchQueue.main.async {
                let tempImg =  self.users.first?.value(forKey: "image") as! CKAsset
                self.profileImage.image = tempImg.toUIImage()
                
                self.nameLabel.text = self.users.first?.value(forKey: "name") as? String
                self.emailLabel.text = self.users.first?.value(forKey: "email") as? String
                let pnumber = self.users.first?.value(forKey: "phoneNumber") as! String
                self.phonenumberLabel.text = "\(pnumber)"
                self.addressLabel.text = self.users.first?.value(forKey: "address") as? String
                print("ANJAYS")
            }
        }
    }
    
    
    @objc func editProfile(_ sender:UIButton){
            performSegue(withIdentifier: "gotonextpage", sender: self)
    }
    

}
