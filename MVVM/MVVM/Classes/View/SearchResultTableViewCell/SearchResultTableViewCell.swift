//
//  SearchResultTableViewCell.swift
//  WiFiestaTestApp
//
//  Created by Csongor G. Korosi on 24/08/2018.
//  Copyright © 2018 BrotherSoft. All rights reserved.
//

import UIKit

/** Displays information about the downloaded media(music, TV shows, movies)
 */
class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailButton: UIButton!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!

    override func prepareForReuse() {
        thumbnailButton.setImage(UIImage(named: Assets.mediaPlaceHolderImage), for: .normal)
    }
    
    /** Called when the media image view of the cell is selected.
     */
    @IBAction func didSelectThumbnailButton(button: UIButton) {
        //Bouncing animation
        UIView.animate(withDuration:1.0, delay:0.0, usingSpringWithDamping:0.4, initialSpringVelocity:0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            button.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        }, completion: {
            (value: Bool) in
            UIView.animate(withDuration: 0.1, animations: {
                button.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            })
        })
    }
}
