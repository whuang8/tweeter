//
//  ProfileViewController.swift
//  Tweeter
//
//  Created by William Huang on 2/25/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import AFNetworking

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profilePictureImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userHandleLabel: UILabel!
    @IBOutlet weak var userBioLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    var user: User?   

    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = self.user {
            displayInformation(user: user)
        } else {
            self.user = User.currentUser
            displayInformation(user: self.user!)
        }
        setNavigationBarButtons()
        
        // Do any additional setup after loading the view.
    }
    
    func displayInformation(user: User) {
        profilePictureImageView.layer.cornerRadius = 5
        profilePictureImageView.clipsToBounds = true
        bannerImageView.setImageWith((user.bannerUrl)!)
        profilePictureImageView.setImageWith(user.profileUrl!)
        userNameLabel.text = user.name
        userHandleLabel.text = "@\((user.screenname)!)"
        userBioLabel.text = user.bio
        followingCountLabel.text = "\(user.followingCount)"
        followersCountLabel.text = "\(user.followersCount)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setNavigationBarButtons() {

        if self.user == User.currentUser {
            self.navigationController?.navigationBar.barTintColor = UIColor.white
            self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
            
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: UIBarButtonItemStyle.plain, target: self, action: #selector(onLogOut(_:)))
        }

    }
    
    
    func onLogOut(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: User.currentUser?.name, message: "Are you sure you want to logout of Tweeter?", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (UIAlertAction) in
            TwitterClient.sharedInstance.logout()
        }))
        self.present(alert, animated: true, completion: nil)
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
