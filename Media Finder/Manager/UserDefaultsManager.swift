//
//  UserDefaultsManager.swift
//  Media Finder
//
//  Created by Hossam on 8/17/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation


import Foundation
// Singleton
class UserDefaultManager {
    
    private static let sharedInstance = UserDefaultManager()
    
    private init() {}
    
    static func shared() -> UserDefaultManager{
        return UserDefaultManager.sharedInstance
    }
    //_____________________________________________
    //ViewController flag
    var isLoggedIn: Bool {
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isloggedIn)
        }
        get{
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isloggedIn)
        }
    }
    //____________________________________________
    // UserData
    
    var userEmail: String? {
        set{
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.userEmail)
        }
        get{
            return UserDefaults.standard.object(forKey: UserDefaultsKeys.userEmail) as? String
        }
    }
    
}



