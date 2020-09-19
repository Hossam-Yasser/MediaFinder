//
//  user.swift
//  Media Finder
//
//  Created by Hossam on 7/12/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

enum Gender: String, Codable{
    case male, female
}
struct User: Codable{
    var image: Data!
    var name: String!
    var email: String!
    var password: String!
    var address: String!
    var gender: Gender
}

struct CodableImage: Codable{
    var imageData: Data?
    
    static func setImage(image: UIImage) -> Data? {
        let data = image.jpegData(compressionQuality: 1.0)
        return data
    }
    
    static func getImage(imageData: Data?)-> UIImage?{
        guard let Data = imageData else {
            return nil
        }
        let image = UIImage(data: Data)
        return image
    }
}
