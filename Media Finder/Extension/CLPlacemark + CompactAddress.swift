//
//  CLPlacemark + CompactAddress.swift
//  Media Finder
//
//  Created by Hossam on 8/16/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

import MapKit
extension CLPlacemark {
    var compactAddress: String? {
    if let name = name {
    var result = name
    
        if let street = thoroughfare {
            result += ", \(street)"
        }
        
        if let city = locality {
            result += ", \(city)"
        }
        
        if let country = country {
            result += ", \(country)"
        }
        
        return result
    }
        return nil
        
    }
}
