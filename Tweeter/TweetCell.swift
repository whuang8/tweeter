//
//  TweetCell.swift
//  Tweeter
//
//  Created by William Huang on 2/25/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = 5
        profilePictureImageView.clipsToBounds = true
        checkCounts()
    }
    
    func checkCounts() {
        if replyCount.text == "0" {
            replyCount.isHidden = true
        }
        if retweetCount.text == "0" {
            retweetCount.isHidden = true
        }
        if favoriteCount.text == "0" {
            favoriteCount.isHidden = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
