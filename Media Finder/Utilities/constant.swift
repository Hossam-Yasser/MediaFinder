//
//  constant.swift
//  Media Finder
//
//  Created by Hossam on 7/29/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation


struct UserDefaultsKeys{
    static let user = "UDKdata"
    static let isloggedIn = "isLoggedIn"
    static var userArray = "UserDataArray"
    static var userEmail = "UserEmail"
    
}

struct ViewController{
    
    static let signInVC = "SignIn"
    static let signUpVC = "SignUp"
    static let profileVC = "Profile"
    static let MapVC = "Map"
    static let MediaListVC = "MediaList"
    
}

struct Cells {
    static let MoviesListCell = "MoviesListCell"
}



struct Urls {
    static let base = "https://api.androidhive.info/json/movies.json"
    // = base + "sfgfsg"   lw ayez a3addel fl url
    static let media = "https://itunes.apple.com/search?"

}

struct Params{
    static let term = "term"
    static let media = "media"
}
