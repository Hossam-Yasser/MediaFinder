//
//  SignIn.swift
//  Media Finder
//
//  Created by Hossam on 7/12/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit
import Foundation

class SignIn: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!

    var user: User?
    var userArray: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUsersDataBase()
        UserDefaultManager.shared().isLoggedIn = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
    }
    
    
    
    private func setUsersDataBase(){
        UserDatabaseManager.Shared().setupConnection()
        UserDatabaseManager.Shared().createTable()
        UserDatabaseManager.Shared().getUsersDatabase{ usersArr in
            if let usersArrCheck = usersArr{
                self.userArray = usersArrCheck
            }
            else {
                self.userArray = []
            }
        }
    }
    
  
    private func isDataEntered() -> Bool {
        guard emailTF.text != "" else {
           showAlertWithCancel(alertTitle: "Error",message: "Please Enter your Email",actionTitle: "Dismiss")
            return false
        }
        guard passwordTF.text != "" else {
           showAlertWithCancel(alertTitle: "error",message: "Please Enter your Password",actionTitle: "Dismiss")
            return false
        }
        return true
    }
    
    
    private func checkData(_ usersArr: [User]) -> Bool {
        for (index,element) in usersArr.enumerated(){
            if emailTF.text == element.email && passwordTF.text == element.password {
                user = usersArr[index]
                UserDefaultManager.shared().userEmail = user!.email
                return true
            }
       
    }
        return false
    }
    
    private func goToMovieList(){
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let media = sb.instantiateViewController(withIdentifier: ViewController.MediaListVC) as! MediaList
            navigationController?.pushViewController(media, animated: true)
    
    }
    
    private func isValidRegex() -> Bool{
        guard isValidEmail(email: emailTF.text) else{print("Please enter Valid email")
            return false
        }
        guard isValidPassword(password: passwordTF.text) else{
            print("Password is Incorect")
            return false
        }
        return true
    }
    
    
    @IBAction func sumbitBTN(_ sender: UIButton) {
        if isDataEntered() {
           if isValidRegex() {
           // gotoProfile()
            if checkData(userArray) {
            goToMovieList()
           } else {
                 showAlertWithCancel(alertTitle: "Alert",message: "Email or Password not Valid",actionTitle: "Dismiss")
            }
            }
        }
        }
    
    private func goToSignUp() {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let signup = sb.instantiateViewController(withIdentifier: ViewController.signUpVC) as! SignUp
        self.navigationController?.pushViewController(signup, animated: true)
    }
     @IBAction func createNewAccount(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isloggedIn)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.userEmail)
        goToSignUp()

    }
    
    
    
}
    


