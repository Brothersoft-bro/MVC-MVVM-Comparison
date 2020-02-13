//
//  MediaManager.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 24/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

/** This class is responsible to play and download media.
 */
class MediaManager: NSObject {
    
    /** Plays media content using the given URL.
     */
    func playMedia(url: URL, viewController: UIViewController) {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = AVPlayer(url: url)
        viewController.present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    /** Downloads the thumbnail image of a media content.
     */
    func downloadThumbnailImage(url: URL, completion: @escaping (_ image: UIImage) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if (data != nil) {
                    let thumbnailImage = UIImage(data: data!)
                    completion(thumbnailImage!)
                }
            }
        }
        task.resume()
    }
}
