//
//  Video.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 07/11/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

class Video: Media {
    var title: String?
    var details: String?
    
    override init(imageURL: URL?, previewURL: URL?) {
        super.init(imageURL: imageURL, previewURL: previewURL)
    }
    
    convenience init(title: String?, details: String?, imageURL: URL?, previewURL: URL?) {
        self.init(imageURL: imageURL, previewURL: previewURL)
        
        self.title = title
        self.details = details
    }
}
