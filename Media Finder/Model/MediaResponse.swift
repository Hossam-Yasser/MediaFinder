//
//  MediaResponse.swift
//  Media Finder
//
//  Created by Hossam on 9/7/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation
import Foundation

struct MediaResponse: Decodable {
    var resultCount: Int
    var results: [Media]
}
