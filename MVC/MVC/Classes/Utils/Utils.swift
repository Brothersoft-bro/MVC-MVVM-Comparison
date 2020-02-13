//
//  Utils.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 24/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import Foundation
import UIKit

/** This class is used to offer helper methods for convertions, API response parsing.
 */
class Utils: NSObject {
    
    /** Builds up a search URL using a search term and media type.
     */
    static func searchURLFor(searchTerm: String!, mediaType: MediatType!) -> URL {
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) as String?
        let urlString = API.baseURL + "?" + API.searchTerm + "=\(encodedTerm!)" + "&" + API.mediaType + "=" + mediaType!.rawValue
        
        return URL.init(string: urlString)!
    }
    
    
    //MARK: Audio Conversion methods

    static func audioTracksFromDictionary(dictionary: [String:AnyObject]) -> [Audio] {
        var audioTracks = [Audio]()
        let results = dictionary[API.results]
        
        for result in results as! Array<AnyObject> {
            let audioTrack = Utils.audioFromResultDictionary(resultDictionary: result as! [String : AnyObject])
            audioTracks.append(audioTrack)
        }
        
        return audioTracks
    }
    
    static func audioFromResultDictionary(resultDictionary: [String: Any]) -> Audio {
        let trackName = mediaTitleFromResultDictionary(resultDictionary: resultDictionary)
        let artistName = mediaArtistFromResultDictionary(resultDictionary: resultDictionary)
        let imageURL = mediaImageURLFromResultDictionary(resultDictionary: resultDictionary)
        let previewURL = mediaPreviewURLFromResultDictionary(resultDictionary: resultDictionary)

        return Audio(trackName: trackName, artistName: artistName, imageURL: imageURL, previewURL: previewURL)
    }
    
    //MARK: Video Conversion methods
    
    static func videosFromDictionary(dictionary: [String:AnyObject]) -> [Video] {
        var videos = [Video]()
        let results = dictionary[API.results]
        
        for result in results as! Array<AnyObject> {
            let video = Utils.videoFromResultDictionary(resultDictionary: result as! [String : AnyObject])
            videos.append(video)
        }
        
        return videos
    }
    
    static func videoFromResultDictionary(resultDictionary: [String: Any]) -> Video {
        let title = mediaTitleFromResultDictionary(resultDictionary: resultDictionary)
        let description = mediaDescriptionFromResultDictionary(resultDictionary: resultDictionary)
        let imageURL = mediaImageURLFromResultDictionary(resultDictionary: resultDictionary)
        let previewURL = mediaPreviewURLFromResultDictionary(resultDictionary: resultDictionary)
        
        return Video(title: title, details: description, imageURL: imageURL, previewURL: previewURL)
    }
    
    //MARK: Media Conversion methods
    
    static func mediaTitleFromResultDictionary(resultDictionary: [String: Any]) -> String? {
        var mediaTitle: String?
        if let title = resultDictionary[API.trackName] {
            mediaTitle = title as? String
        }
        
        return mediaTitle
    }
    
    static func mediaArtistFromResultDictionary(resultDictionary: [String: Any]) -> String? {
        var artistName: String?
        if let name = resultDictionary[API.artistName] {
            artistName = name as? String
        }
        
        return artistName
    }
    
    static func mediaDescriptionFromResultDictionary(resultDictionary: [String: Any]) -> String? {
        var description: String?
        if let details = resultDictionary[API.longDescription] {
            description = details as? String
        }
        
        return description
    }
    
    static func mediaPreviewURLFromResultDictionary(resultDictionary: [String: Any]) -> URL? {
        var previewURL: URL?
        if let preview = resultDictionary[API.previewURL] {
            previewURL = URL(string: preview as! String)
        }
        
        return previewURL
    }
    
    static func mediaImageURLFromResultDictionary(resultDictionary: [String: Any]) -> URL? {
        var imageURL: URL?
        if let image = resultDictionary[API.artworkURL100] {
            imageURL = URL(string: image as! String)
        }
        
        return imageURL
    }
    
    /** Returns the media type for a given index.
     */
    static func mediaTypeForIndex(index: Int!) -> MediatType {
        switch index {
        case 0:
            return MediatType.Music
        case 1:
            return MediatType.TVShow
        case 2:
            return MediatType.Movie
        default:
            return MediatType.Music
        }
    }
    
    //MARK: UI Conversion methods
    
    static func heightFor(withConstrainedWidth width: CGFloat, font: UIFont, text: String) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedString.Key: font], context: nil)
        
        return ceil(boundingBox.height)
    }
}
