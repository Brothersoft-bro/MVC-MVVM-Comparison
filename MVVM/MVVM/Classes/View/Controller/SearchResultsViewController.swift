//
//  ViewController.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 23/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UISearchBarDelegate, UITextFieldDelegate {
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView : UIActivityIndicatorView!
    @IBOutlet private weak var noResultsFoundLabel : UILabel!

    private var timer = Timer()
    private var searchResultsViewModel = SearchResultsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: NibName.searchResultTableViewCell, bundle: nil), forCellReuseIdentifier: TableViewCellIdentifier.search)
        self.searchResultsViewModel.delegate = self
    }
}

//MARK: UI Action methods
extension SearchResultsViewController {
    @IBAction func segmentedControlValueChanged(segmentedControl: UISegmentedControl) {
        self.searchBar.endEditing(true)
        self.timer.invalidate()
        self.searchResultsViewModel.requestSearchResults(searchTerm: searchBar.text!, segmentedControlIndex: self.segmentedControl.selectedSegmentIndex)    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.timer.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.35, repeats: false, block: { (timer) in
            self.searchResultsViewModel.requestSearchResults(searchTerm: searchBar.text!, segmentedControlIndex: self.segmentedControl.selectedSegmentIndex)
        })
    }
}

//MARK: UITableViewDelegate & UITableViewDatasource
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResultsViewModel.datasource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.searchResultsViewModel.datasource[indexPath.row]
    
        let cell: SearchResultTableViewCell! = tableView.dequeueReusableCell(withIdentifier: TableViewCellIdentifier.search) as? SearchResultTableViewCell
        cell.firstLabel.text = viewModel.firstText
        cell.secondLabel.text = viewModel.secondText
        cell.thumbnailButton.setImage(viewModel.image, for: UIControl.State.normal)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(self.searchResultsViewModel.cellHeight)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.searchResultsViewModel.downloadMediaImage(forItemAtIndex: indexPath.row);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchResultsViewModel.playMedia(forItemAtIndex: indexPath.row, fromViewController: self)
    }
}

//MARK: SearchResultsViewModelProtocol methods
extension SearchResultsViewController: SearchResultsViewModelProtocol {
    func didLoadSearchResults() {
        self.activityIndicatorView.stopAnimating()
        self.noResultsFoundLabel.isHidden = self.searchResultsViewModel.hideResultsNotFoundLabel()
        self.tableView.isHidden = false
        self.tableView.reloadData()
    }
    
    func willLoadSearchResults() {
        self.activityIndicatorView.startAnimating()
        self.noResultsFoundLabel.isHidden = true
        self.tableView.isHidden = true
    }
    
    func didDownloadImage(image: UIImage, forItemAtIndex index: Int) {
        if let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) {
            let searchResultTableViewCell: SearchResultTableViewCell
            searchResultTableViewCell = cell as! SearchResultTableViewCell
            searchResultTableViewCell.thumbnailButton.setImage(image, for: .normal)
        }
    }
}
