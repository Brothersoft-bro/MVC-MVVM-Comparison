//
//  ViewController.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 23/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UITextFieldDelegate {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView : UIActivityIndicatorView!
    @IBOutlet private weak var noResultsFoundLabel : UILabel!

    private var searchManager = SearchManager.init()
    private var datasource = [Media]()
    private var timer = Timer()
    private var mediaType = MediatType.Music
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: NibName.searchResultTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.search)
    }
}

    //MARK: UI methods
extension SearchResultsViewController {
    func showProgressUI() {
        self.activityIndicatorView.startAnimating()
        self.noResultsFoundLabel.isHidden = true
        self.showEmptyTableView()
    }
    
    func hideProgressUI() {
        self.activityIndicatorView.stopAnimating()
    }
    
    func showResultsReceivedUI() {
        self.noResultsFoundLabel.isHidden = (self.datasource.count != 0) ? true : false
        self.tableView.reloadData()
        self.hideProgressUI()
    }
    
    func showEmptyTableView() {
        self.datasource = []
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    @IBAction func segmentedControlValueChanged(segmentedControl: UISegmentedControl) {
        self.searchBar.endEditing(true)
        self.timer.invalidate()
        self.mediaType = Utils.mediaTypeForIndex(index: segmentedControl.selectedSegmentIndex)
        self.requestSearchResults(searchTerm: searchBar.text!, mediaType: mediaType)
    }
}

//UITableViewDelegate & UITableViewDatasource
extension SearchResultsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchResultTableViewCell! = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.search) as? SearchResultTableViewCell
        
        switch self.mediaType {
        case .Music:
            let audioTrack = datasource[indexPath.row] as? Audio
            if let audio = audioTrack {
                cell.firstLabel.text = audio.trackName
                cell.secondLabel.text = audio.artistName
                if (audio.image != nil) {
                    cell.thumbnailButton.setImage(audio.image, for: UIControl.State.normal)
                }
            }
        case .TVShow, .Movie:
            let tvShow = datasource[indexPath.row] as? Video
            if let show = tvShow {
                cell.firstLabel.text = show.title
                cell.secondLabel.text = show.details
                if (show.image != nil) {
                    cell.thumbnailButton.setImage(show.image, for: UIControl.State.normal)
                }
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let media = datasource[indexPath.row]
        if  media.image == nil {
            if let mediaURL = media.imageURL {
                let mediaManager = MediaManager()
                mediaManager.downloadThumbnailImage(url: mediaURL) { (image) in
                    media.image = image
                    DispatchQueue.main.async {
                        let index = self.datasource.index(of: media)
                        if (index != nil) {
                            if let cell = self.tableView.cellForRow(at: IndexPath(row: index!, section: 0)) {
                                let searchResultTableViewCell: SearchResultTableViewCell
                                searchResultTableViewCell = cell as! SearchResultTableViewCell
                                searchResultTableViewCell.thumbnailButton.setImage(image, for: .normal)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let media = datasource[indexPath.row]
        let mediaManager = MediaManager()
        
        if let mediaURL = media.previewURL {
            mediaManager.playMedia(url: mediaURL, viewController: self)
        }
    }
}

//UISearchBarDelegate methods
extension SearchResultsViewController {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false, block: { (timer) in
            self.requestSearchResults(searchTerm: searchBar.text!, mediaType: self.mediaType)
        })
    }
}

//MARK: Business Logic methods
extension SearchResultsViewController {
    func requestSearchResults(searchTerm: String, mediaType: MediatType) {
        if (searchTerm != "") {
            self.showProgressUI()
            
            switch mediaType {
            case .Music:
                searchManager.requestAudioTracks(searchTerm: searchBar.text) { (audioTracks) in
                    DispatchQueue.main.async {
                        self.datasource = audioTracks
                        self.showResultsReceivedUI()

                    }
                }
            case .TVShow:
                searchManager.requestTVShows(searchTerm: searchBar.text) { (tvSHows) in
                    DispatchQueue.main.async {
                        self.datasource = tvSHows
                        self.showResultsReceivedUI()
                    }
                }
            case.Movie:
                searchManager.requestMovies(searchTerm: searchBar.text) { (movies) in
                    DispatchQueue.main.async {
                        self.datasource = movies
                        self.showResultsReceivedUI()
                    }
                }
            }
        } else {
            self.showEmptyTableView()
        }
    }
}
