//
//  SearchResultsViewModel.swift
//  MVVM
//
//  Created by Csongor G. Korosi on 12/11/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

protocol SearchResultsViewModelProtocol {
    func willLoadSearchResults()
    func didLoadSearchResults()
    
    func didDownloadImage(image: UIImage, forItemAtIndex index: Int)
}

class SearchResultsViewModel: NSObject {
    var searchManager = SearchManager()
    var mediaManager = MediaManager()
    
    var datasource = [SearchResultViewModel]()
    var mediaType = MediatType.Music
    var cellHeight = 100.0
    var delegate: SearchResultsViewModelProtocol?
    
    lazy var hideResultsNotFoundLabel = {
        return (self.datasource.count != 0) ? true : false
    }
    
    //MARK: Public methods
    
    func requestSearchResults(searchTerm: String, segmentedControlIndex: Int) {
        if (searchTerm != "") {
            self.delegate?.willLoadSearchResults()
            self.mediaType = Utils.mediaTypeForIndex(index: segmentedControlIndex)
            
            switch mediaType {
            case .Music:
                searchManager.requestAudioTracks(searchTerm: searchTerm) { (audioTracks) in
                    DispatchQueue.main.async {
                        self.updateSearchResultsViewModel(from: audioTracks)
                        self.delegate?.didLoadSearchResults()
                    }
                }
            case .TVShow:
                searchManager.requestTVShows(searchTerm: searchTerm) { (tvSHows) in
                    DispatchQueue.main.async {
                        self.updateSearchResultsViewModel(from: tvSHows)
                        self.delegate?.didLoadSearchResults()
                    }
                }
            case.Movie:
                searchManager.requestMovies(searchTerm: searchTerm) { (movies) in
                    DispatchQueue.main.async {
                        self.updateSearchResultsViewModel(from: movies)
                        self.delegate?.didLoadSearchResults()
                    }
                }
            }
        } else {
            self.delegate?.didLoadSearchResults()
        }
    }
    
    func playMedia(forItemAtIndex index: Int, fromViewController viewController: UIViewController) {
        let media = self.datasource[index]
        let mediaManager = MediaManager()
        
        if let mediaURL = media.mediaURL {
            mediaManager.playMedia(url: mediaURL, viewController: viewController)
        }
    }
    
    func downloadMediaImage(forItemAtIndex index: Int) {
        let searchResultViewModel = self.datasource[index] as SearchResultViewModel
        if searchResultViewModel.image.size == UIImage(named: Assets.mediaPlaceHolderImage)?.size {
            if let url = searchResultViewModel.imageURL {
                self.mediaManager.downloadThumbnailImage(url: url) { (image) in
                    DispatchQueue.main.async {
                        self.delegate?.didDownloadImage(image: image, forItemAtIndex: index)
                    }
                }
            }
        }
    }
    
    //MARK: Conversion methods
    func updateSearchResultsViewModel(from mediaTracks: [Media]) {
        self.datasource.removeAll()
        
        for media in mediaTracks {
            if let audio = media as? Audio {
                self.datasource.append(SearchResultViewModel(audio: audio))
            }
            if let video = media as? Video {
                self.datasource.append(SearchResultViewModel(video: video))
            }
        }
    }
}
