//
//  Media.swift
//  Media Finder
//
//  Created by Hossam on 9/7/20.
//  Copyright © 2020 IOS. All rights reserved.
//

import Foundation

public enum MediaTypes: String {
    case music = "music"
    case movie = "movie"
    case tvShow = "tvShow"
}

struct Media: Decodable{
    var artworkUrl100: String
    var artistName: String?
    var trackName: String?
    var previewUrl: String
    var kind: String?
    var longDescription: String?
    var email: String?

    
    func getType()-> MediaTypes{
        switch self.kind{
        case "song":
            return MediaTypes.music
        case "feature-movie":
            return MediaTypes.movie
        case "tv-episode":
            return MediaTypes.tvShow
        default:
            return MediaTypes.music
        }
    }
    
}

