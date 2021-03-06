//
//  User.swift
//  Tweeter
//
//  Created by William Huang on 2/21/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var bannerUrl: URL?
    var bio: String?
    var dictionary: NSDictionary?
    var followingCount: Int = 0
    var followersCount: Int = 0
    static let userDidLogoutNotification = NSNotification.Name.init("UserDidLogout")
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        let bannerUrlString = dictionary["profile_background_image_url_https"] as? String
        bio = dictionary["description"] as? String
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        if let bannerUrlString = bannerUrlString {
            bannerUrl = URL(string: bannerUrlString)
        }
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let userDictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    if let userDictionary = userDictionary {
                        _currentUser = User(dictionary: userDictionary)
                    }
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }

}
