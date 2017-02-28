//
//  TweetCell.swift
//  Tweeter
//
//  Created by William Huang on 2/25/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import Lottie

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var replyCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    
    var tweet: Tweet?
    var favCount = 0
    var animationView: LOTAnimationView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        profilePictureImageView.layer.cornerRadius = 5
        profilePictureImageView.clipsToBounds = true
        retweetCount.text = "\(tweet?.retweetCount)"

    }
    
    @IBAction func onHeartTap(_ sender: Any) {
        favoriteCount.text = "\(Int(favoriteCount.text!)! + 1)"
        favoriteButton.setImage(UIImage(named: "favor-icon-red"), for: .normal)
    }
    
    @IBAction func onRetweetTap(_ sender: Any) {
        retweetCount.text = "\(Int(retweetCount.text!)! + 1)"
        retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
