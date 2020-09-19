//
//  SignUp.swift
//  Media Finder
//
//  Created by Hossam on 7/12/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class SignUp: UIViewController {
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var userImageView: UIImageView!
    
    var gender = Gender.male
    var user: User?
    let imagePicker = UIImagePickerController()
    var usersArray: [User] = []
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUserDataBase()
        imagePicker.delegate = self
       
    }
    
    private func setUserDataBase(){
        UserDatabaseManager.Shared().setupConnection()
        UserDatabaseManager.Shared().createTable()
        UserDatabaseManager.Shared().getUsersDatabase{ usersArr in
            if let usersArrCheck = usersArr{
                self.usersArray = usersArrCheck
                
            }else{
                self.usersArray = []
            }
        }
    }

    
    
    
    
    
    @IBAction func ImagePickerBTN(_ sender: UIButton) {
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
                present(imagePicker, animated: true, completion: nil)
        
    }
    
    @IBAction func genderswitch(_ sender: UISwitch) {
        if sender .isOn {
            gender = .male
        }else{
            gender = .female
        }
    }
    
    private func isDataEntered() -> Bool {
        guard nameTF.text != "" else {
            showAlertWithCancel(alertTitle: "Error",message: "Please Enter your Name",actionTitle: "Dismiss")
            return false
        }
        guard emailTF.text != "" else {
            showAlertWithCancel(alertTitle: "Error",message: "Please Enter your E-mail",actionTitle: "Dismiss")
            return false
        }
        
        guard passwordTF.text != "" else {
             showAlertWithCancel(alertTitle: "Error",message: "Please Enter your Password",actionTitle: "Dismiss")
            return false
        }
        guard addressTF.text != "" else {
            showAlertWithCancel(alertTitle: "Error",message: "Please Enter your your Address",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    private func isValidRegex() -> Bool{
        guard isValidEmail(email: emailTF.text) else{
          
            print("Please enter Valid email")
            return false
        }
        guard isValidPassword(password: passwordTF.text) else{
            print("Password need to be : \n at least one uppercase \n at least one digit \n at leat one lowercase \n characters total")
            return false
        }
        return true
    }
    
    
    private func userEmailCheck(_ usersArr:[User]) -> Bool {
        for element in usersArr{
            if emailTF.text == element.email{
               showAlertWithCancel(alertTitle: "Alert",message: "The email is already taken please enter valid email ",actionTitle: "Dismiss")
                return false
            }
        }
        return true
    }
    
    private func gotoSignIn() {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let sgnin = sb.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignIn
        let user = User(image: CodableImage.setImage(image: userImageView.image!) , name: nameTF.text!,email: emailTF.text!, password: passwordTF.text!, address: addressTF.text! ,gender: gender)
        // usersArray.append(user)
      UserDatabaseManager.Shared().insertUser(user: user)
       self.navigationController?.pushViewController(sgnin, animated: true)
    }
    
    
    
    @IBAction func sumbitBTN(_ sender: UIButton) {
        if isDataEntered() {
            if isValidRegex() {
                if userEmailCheck(usersArray) { 
        gotoSignIn()
           }
          }
         }
        }
    
    @IBAction func addressBTN(_ sender: UIButton) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let map = mainStoryboard.instantiateViewController(withIdentifier: ViewController.MapVC) as! Map
        //4-
       map.delegate = self
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    
    
      }

 // Imager Picker

extension SignUp: UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            userImageView.contentMode = .scaleAspectFit
            userImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
    
extension SignUp: AddressSendingDelegate {
    func sendAddress(address: String, tag: Int) {
        addressTF.text = address

    }
    
  }
  

    



