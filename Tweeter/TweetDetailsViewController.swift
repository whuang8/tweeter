//
//  TweetDetailsViewController.swift
//  Tweeter
//
//  Created by William Huang on 3/3/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import AFNetworking

class TweetDetailsViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!

    var tweet: Tweet?
    
    
    
    
    /*
     userNameLabel: UILabel!
     @IBOutlet weak var userHandleLabel: UILabel!
     @IBOutlet weak var tweetTextLabel: UILabel!
     @IBOutlet weak var timestampLabel: UILabel!
     @IBOutlet weak var replyCount: UILabel!
     @IBOutlet weak var retweetCount: UILabel!
     @IBOutlet weak var favoriteButton: UIButton!
     @IBOutlet weak var favoriteCount: UILabel!
     @IBOutlet weak var retweetButton: UIButton!
     */

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarButtons()
        profilePictureImageView.setImageWith((tweet?.profileUrl)!)
        userNameLabel.text = tweet?.user?.name
        userHandleLabel.text = "@\((tweet?.user?.screenname)!)"
        timestampLabel.text = DateFormatter.localizedString(from: (tweet?.timestamp)!, dateStyle: .medium, timeStyle: .medium)
        tweetLabel.text = tweet?.text
        retweetCountLabel.text = "\((tweet?.retweetCount)!)"
        favoriteCountLabel.text = "\((tweet?.favoriteCount)!)"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setNavigationBarButtons() {
        let logoImage = UIImage(named: "TwitterLogoBlue")
        let composeImage = UIImage(named: "edit-icon")
        
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        logoView.image = logoImage
        logoView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        logoView.frame = titleView.bounds
        titleView.addSubview(logoView)
        
        let composeButton = UIBarButtonItem(image: composeImage, style: .plain, target: self, action: #selector(composeButtonTapped(sender:)))
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: nil)
        searchButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, -44)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItems = [composeButton, searchButton]
        self.navigationItem.titleView = titleView
    }
    
    func composeButtonTapped(sender: UIBarButtonItem) {
        performSegue(withIdentifier: "ComposeTweetSegue", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
