//
//  Profile.swift
//  Media Finder
//
//  Created by Hossam on 7/12/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import UIKit

class Profile: UIViewController {

    @IBOutlet weak var namelabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var genderlabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!

    var userEmail: String = ""
    var user: User?
    var usersArray: [User] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultManager.shared().isLoggedIn = true
        setUsersDataBase()
        setUpData()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Media List", style: .plain, target: self, action: #selector(tapBtn))
        self.navigationItem.hidesBackButton = true

    }
    
    
    
    @objc private func tapBtn(){
        let movieListVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ViewController.MediaListVC) as! MediaList
        navigationController?.pushViewController(movieListVC, animated: true)
    }
    
    
    
    private func setUsersDataBase(){
        userEmail = UserDefaultManager.shared().userEmail ?? ""
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
    
    
    
    
    func setUpData () {
        if getUserData(usersArray){
            userImageView.image = CodableImage.getImage(imageData: user?.image)
            addresslabel.text = user?.address
            emaillabel.text = user?.email
            namelabel.text = user?.name
            genderlabel.text = user?.gender.rawValue
        }else{return}
    }
    
    
    private func getUserData(_ usersArr: [User]) -> Bool{
        for (index ,element) in usersArr.enumerated(){
            if userEmail == element.email  {
                user = usersArr[index]
                
                return true
            }
        }
        return false
    }
    
    
    
  private func goToSignIn(){
        
        UserDefaultManager.shared().isLoggedIn = false
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let signin = sb.instantiateViewController(withIdentifier: ViewController.signInVC) as! SignIn
        self.navigationController?.pushViewController(signin, animated: true)
        
    }
    
    
    @IBAction func LogOut(_ sender: UIButton) {
      goToSignIn()
}
        
        
}

