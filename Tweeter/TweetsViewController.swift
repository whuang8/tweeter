//
//  TweetsViewController.swift
//  Tweeter
//
//  Created by William Huang on 2/22/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet] = []
    var refreshControl: UIRefreshControl!
    var tweetMaxId: Int?
    private var isMoreTweetsLoading = false
    var loadingMoreView: InfiniteScrollActivityView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 40

        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(fetchTweets(forInfiniteScroll:)), for: .valueChanged)
        refreshControl.backgroundColor = UIColor.groupTableViewBackground
        tableView.addSubview(refreshControl)
        
        self.tabBarController?.tabBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        setNavigationBarButtons()
        
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset;
        insets.bottom += InfiniteScrollActivityView.defaultHeight;
        tableView.contentInset = insets
        
        fetchTweets(forInfiniteScroll: false)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !isMoreTweetsLoading {
            let ScrollViewContentHeight = self.tableView.contentSize.height
            let scrollOffsetThreshold = ScrollViewContentHeight - self.tableView.bounds.size.height
            
            if scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging && !tweets.isEmpty {
                isMoreTweetsLoading = true
                
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                self.fetchTweets(forInfiniteScroll: true)
            }
        }
    }
    
    func fetchTweets(forInfiniteScroll: Bool) {
        if !forInfiniteScroll {
            tweetMaxId = nil
        }
        TwitterClient.sharedInstance.homeTimeline(withMaxId: tweetMaxId, success: { (tweets: [Tweet]) in
            self.isMoreTweetsLoading = false
            self.loadingMoreView?.stopAnimating()
            self.tweets = forInfiniteScroll ? self.tweets + tweets : tweets
            self.refreshControl.endRefreshing()
            self.tweetMaxId = tweets.last?.id
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
        cell.favoriteCount.text = "\(tweet.favoriteCount)"
        cell.retweetCount.text = "\(tweet.retweetCount)"
        cell.tweet = tweet
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
