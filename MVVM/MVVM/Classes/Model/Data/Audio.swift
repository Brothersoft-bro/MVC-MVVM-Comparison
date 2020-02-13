//
//  Audio.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 07/11/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

class Audio: Media {
    var trackName: String?
    var artistName: String?
    
    override init(imageURL: URL?, previewURL: URL?) {
        super.init(imageURL: imageURL, previewURL: previewURL)
    }
    
    convenience init(trackName: String?, artistName: String?, imageURL: URL?, previewURL: URL?) {
        self.init(imageURL: imageURL, previewURL: previewURL)
        
        self.trackName = trackName
        self.artistName = artistName
    }
}
