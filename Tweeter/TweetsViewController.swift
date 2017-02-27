//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by William Huang on 2/22/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40

        refreshControl.addTarget(self, action: #selector(fetchTweets), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.tabBarController?.tabBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        setNavigationBarButtons()
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets:[Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }) { (error: Error) in
            print("error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchTweets() {
        TwitterClient.sharedInstance.homeTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }) { (error: Error) in
            print("error: \(error.localizedDescription)")
            self.refreshControl.endRefreshing()
        }
    }
    
    func setNavigationBarButtons() {
        let logoImage = UIImage(named: "TwitterLogoBlue")
        let connectImage = UIImage(named: "addfriend-icon")
        let composeImage = UIImage(named: "edit-icon")
        
        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        logoView.image = logoImage
        logoView.contentMode = .scaleAspectFit
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
        logoView.frame = titleView.bounds
        titleView.addSubview(logoView)
        
        let connectButton = UIBarButtonItem(image: connectImage, style: .plain, target: self, action: nil)
        let composeButton = UIBarButtonItem(image: composeImage, style: .plain, target: self, action: nil)
        let searchButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: nil)
        searchButton.imageInsets = UIEdgeInsetsMake(0, 0, 0, -44)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItems = [composeButton, searchButton]
        self.navigationItem.titleView = titleView
        self.navigationItem.leftBarButtonItem = connectButton
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        let tweet = tweets[indexPath.row]
        if let url = tweet.profileUrl {
           cell.profilePictureImageView.setImageWith(url)
        }
        cell.userNameLabel.text = tweet.user?.name
        cell.userHandleLabel.text = "@\((tweet.user?.screenname)!)"
        cell.tweetTextLabel.text = tweet.text
        
        return cell
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
