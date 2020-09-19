//
//  MyMovie.swift
//  Media Finder
//
//  Created by Hossam on 8/31/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import UIKit

struct Movie: Decodable {
    var title: String
    var afesh: String
    var rating: Double
    var releaseYear: Int
    
    enum codingKeys : String , CodingKey{
        case title
        case afesh = "image"
        case rating
        case releaseYear
    }
}
