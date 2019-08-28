//
//  LoginViewController.swift
//  Mini Challenge 3
//
//  Created by Steven Gunawan on 26/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

    @IBOutlet weak var namaLengkap: UITextField!
    @IBOutlet weak var alamatLengkap: UITextField!
    @IBOutlet weak var nomorHP: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var konfirmPass: UITextField!
    let codeInput = UITextField()
    let cloud = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        namaLengkap.delegate = self
        alamatLengkap.delegate = self
        nomorHP.delegate = self
        email.delegate = self
        password.delegate = self
        konfirmPass.delegate = self
        
        namaLengkap.tag = 0
        alamatLengkap.tag = 1
        nomorHP.tag = 2
        email.tag = 3
        password.tag = 4
        konfirmPass.tag = 5
        
        
        
        self.accessoryDoneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.donePressed))
        self.accessoryToolBar.items = [self.accessoryDoneButton]

        
        accessoryToolBar.setItems([flexiblea, accessoryDoneButton], animated: false)
        
        namaLengkap.inputAccessoryView = accessoryToolBar
        alamatLengkap.inputAccessoryView = accessoryToolBar
        nomorHP.inputAccessoryView = accessoryToolBar
        email.inputAccessoryView = accessoryToolBar
        password.inputAccessoryView = accessoryToolBar
        konfirmPass.inputAccessoryView = accessoryToolBar
        
        navigationController?.navigationBar.barStyle = .black
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    func saveToCloud(){
        let data = CKRecord(recordType: "User")
        data["name"] = namaLengkap.text! as NSString
        data["address"] = alamatLengkap.text! as NSString
        data["phoneNumber"] = nomorHP.text! as NSString
        data["email"] = email.text! as NSString
        data["password"] = password.text! as NSString
      
        cloud.save(data) { (record, error) in
                guard record != nil else { return }
                print("saved record")
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField, moveDistance: -250, up: false)
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
    
    
    func moveTextField(_ textField: UITextField, moveDistance: Int, up: Bool) {
        let moveDuration = 0.3
        let movement: CGFloat = CGFloat(up ? moveDistance : -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
    func validationOfTextFields() -> Bool{
        var a = false
        let checkEmail = email.text
        if(password.text == "" || konfirmPass.text == "" || namaLengkap.text == "" || email.text == "" || alamatLengkap.text == "" || nomorHP.text == "")
        {
            let alertController = UIAlertController(title: "Error", message: "Please Fill All Required Fields", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
     
        else if password.text != konfirmPass.text {
            let alertController = UIAlertController(title: "Error", message: "Passwords don't Match", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else if checkEmail?.isValidEmail() == false{
            let alertController = UIAlertController(title: "Error", message: "Email Error", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        a = true
        return a
    }

    
    @IBAction func signUpditekan(_ sender: Any) {
        if validationOfTextFields() == true{
            saveToCloud()
            performSegue(withIdentifier: "gotoHome", sender: sender)
        }
    }
}
