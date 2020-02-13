//
//  SearchManager.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 24/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

/** Manages search related operation.
 */
class SearchManager: NSObject {
    private var task: URLSessionDataTask!
    
    func requestAudioTracks(searchTerm: String!, completion: @escaping (_ audioTracks: [Audio]) -> Void)  {
        let searchURL = Utils.searchURLFor(searchTerm: searchTerm, mediaType: MediatType.Music)
        
        task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            do {
                if data != nil {
                    let searchResultsDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let audioTracks = Utils.audioTracksFromDictionary(dictionary: searchResultsDictionary)
                    
                    completion(audioTracks)
                } else {
                    completion([])
                }
            }
            catch {
                
            }
        }
        task.resume()
    }
    
    func requestMovies(searchTerm: String!, completion: @escaping (_ audioTracks: [Video]) -> Void)  {
        let searchURL = Utils.searchURLFor(searchTerm: searchTerm, mediaType: MediatType.Movie)
        
        task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            do {
                if data != nil {
                    let searchResultsDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let videos = Utils.videosFromDictionary(dictionary: searchResultsDictionary)
                    
                    completion(videos)
                } else {
                    completion([])
                }
            }
            catch {
                
            }
        }
        task.resume()
    }
    
    func requestTVShows(searchTerm: String!, completion: @escaping (_ audioTracks: [Video]) -> Void)  {
        let searchURL = Utils.searchURLFor(searchTerm: searchTerm, mediaType: MediatType.TVShow)
        
        task = URLSession.shared.dataTask(with: searchURL) { (data, response, error) in
            do {
                if data != nil {
                    let searchResultsDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
                    let videos = Utils.videosFromDictionary(dictionary: searchResultsDictionary)
                    
                    completion(videos)
                } else {
                    completion([])
                }
            }
            catch {
                
            }
        }
        task.resume()
    }
}
