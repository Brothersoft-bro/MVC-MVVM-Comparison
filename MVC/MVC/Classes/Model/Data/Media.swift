//
//  Media.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 07/11/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

class Media: NSObject {
    var imageURL: URL?
    var previewURL: URL?
    var image: UIImage?
    
    init(imageURL: URL?, previewURL: URL?) {
        self.imageURL = imageURL
        self.previewURL = previewURL
    }
}
