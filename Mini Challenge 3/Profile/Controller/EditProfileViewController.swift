//
//  EditProfileViewController.swift
//  Mini Challenge 3
//
//  Created by Jerry Ming Ho on 26/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var userEdit:CKRecord!
    
    @IBOutlet weak var imageEditProfile: UIImageView!
    @IBOutlet weak var nameEditLabel: UITextView!
    @IBOutlet weak var emailEditLabel: UITextView!
    @IBOutlet weak var phoneNumberEditLabel: UITextView!
    @IBOutlet weak var addressEditLabel: UITextView!
    @IBAction func changePhoto(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
        
        imageEditProfile.setRounded()
        nameEditLabel.text = userEdit["name"]
        emailEditLabel.text = userEdit["email"]
        phoneNumberEditLabel.text = userEdit["phoneNumber"]
        addressEditLabel.text = userEdit["address"]
        
        //Function Image di Klik
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGesture:)))
        
        imageEditProfile.isUserInteractionEnabled = true
        imageEditProfile.addGestureRecognizer(tapGesture)
        
    }
    
    //func edit teks field
    func save(){
        
        userEdit["name"] = nameEditLabel.text as CKRecordValue
        userEdit["email"] = emailEditLabel.text as CKRecordValue
        userEdit["address"] = emailEditLabel.text as CKRecordValue
        userEdit["phoneNumber"] = phoneNumberEditLabel.text as CKRecordValue
        
        database.save(userEdit) { (record, error) in
            guard record != nil else { return }
            print("saved record")
        }
    }
    // function button done
    func setView(){
        let edit = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done(_:)))
        self.navigationItem.rightBarButtonItem  = edit
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
    }
    
    @objc func done (_ sender:UIButton){
        save()
        navigationController?.popViewController(animated: true)
    }
    
    // Function ImageTapped
    @objc func imageTapped(tapGesture: UITapGestureRecognizer){
        let tappedImage = tapGesture.view as! UIImageView
        
        //Codingan untuk Image Picker Controller
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
                let actionSheet = UIAlertController(title: "Photo Source", message: "Choose your photo evidence ", preferredStyle: .actionSheet)
        
                actionSheet.addAction(.init(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .camera
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                actionSheet.addAction(.init(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .photoLibrary
                    self.present(imagePickerController, animated: true, completion: nil)
                }))
                actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
        
                self.present(actionSheet, animated: true, completion: nil)
    }
    
        
}

//
    
    

    
