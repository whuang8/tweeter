//
//  ComposeTweetViewController.swift
//  Tweeter
//
//  Created by William Huang on 3/4/17.
//  Copyright © 2017 William Huang. All rights reserved.
//

import UIKit
import AFNetworking

class ComposeTweetViewController: UIViewController {
    
    @IBOutlet weak var composeTweetView: UITextView!
    var user: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        composeTweetView.becomeFirstResponder()
        setNavigationBarButtons()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setNavigationBarButtons() {
        let closeImage = UIImage(named: "close-icon")
        let closeButton = UIBarButtonItem(image: closeImage, style: .plain, target: self, action: #selector(closeButtonTapped(sender:)))
        
//        let logoView = UIImageView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        logoView.layer.cornerRadius = 5
//        logoView.clipsToBounds = true
//        logoView.setImageWith((User.currentUser?.profileUrl)!)
//        logoView.contentMode = .scaleAspectFit
//        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 32, height: 32))
//        logoView.frame = titleView.bounds
//        titleView.addSubview(logoView)

        
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 64/255, green: 153/255, blue: 255/255, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItems = [closeButton]
        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Tweet", style: .plain, target: self, action: #selector(tweetButtonTapped(sender:)))
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
    }
    
    func tweetButtonTapped(sender: UIBarButtonItem) {
        
    }

    func closeButtonTapped(sender: UIBarButtonItem) {
        composeTweetView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
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
