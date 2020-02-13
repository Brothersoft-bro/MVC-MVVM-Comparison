//
//  SearchResultViewModel.swift
//  MVVM
//
//  Created by Csongor G. Korosi on 12/11/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

struct SearchResultViewModel {
    var firstText: String
    var secondText: String
    var image: UIImage
    var imageURL: URL?
    var mediaURL: URL?
    
    init(audio: Audio) {
        self.firstText = audio.trackName ?? ""
        self.secondText = audio.artistName ?? ""
        self.image = audio.image ?? UIImage(named: Assets.mediaPlaceHolderImage)!
        self.mediaURL = audio.previewURL
        self.imageURL = audio.imageURL
    }
    
    init(video: Video) {
        self.firstText = video.title ?? ""
        self.secondText = video.details ?? ""
        self.image = video.image ?? UIImage(named: Assets.mediaPlaceHolderImage)!
        self.mediaURL = video.previewURL
        self.imageURL = video.imageURL
    }
}
