//
//  Constants.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 24/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import Foundation

struct API {
    static let baseURL           = "https://itunes.apple.com/search"
    static let searchTerm        = "term"
    static let mediaType         = "media"
    static let limit             = "limit"
    static let results           = "results"
    static let trackName         = "trackName"
    static let artistName        = "artistName"
    static let artworkURL100     = "artworkUrl100"
    static let previewURL        = "previewUrl"
    static let longDescription   = "longDescription"
}

struct NibName {
    static let chatInputAccessoryView       = "ChatInputAccessoryView"
    static let chatTableViewCell            = "ChatTableViewCell"
    static let searchResultTableViewCell    = "SearchResultTableViewCell"
}

struct Assets {
    static let mediaPlaceHolderImage = "placeholder_icon"
}

struct Bot {
    static let firstMessage = "Hello. How can I help you?:)"
    static let textReplyMessage = "I see your point. I'm going to think about it and get back to you as soon as possible!"
    static let imageReplyMessage = "This is a great picture. Good job!"
}

struct TableViewCellIdentifier {
    static let chat   = "Bot"
    static let search = "SearchResult"
}

enum MediatType: String {
    case Music  = "music"
    case TVShow = "tvShow"
    case Movie  = "movie"
}
