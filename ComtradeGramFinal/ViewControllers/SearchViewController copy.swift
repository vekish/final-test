//
//  ViewController.swift
//  ComtradeGramFinal
//
//  Created by Predrag Jevtic on 1/10/18.
//  Copyright © 2018 com.comtrade.Gram. All rights reserved.
//

import UIKit
import SwiftInstagram

class SearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var instagramPosts : [InstagramMedia] = []
    var posts = [Post]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.loadPosts()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       return instagramPosts.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 350
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "cell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("error")
            
        }
        
        let post = instagramPosts[indexPath.row]
        
        cell.profilePhoto.layer.cornerRadius = (cell.profilePhoto.frame.width) / 2
//        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 10;
        cell.layer.borderColor = UIColor.init(red:204/255.0, green:21/255.0, blue:34/255.0, alpha: 1.0).cgColor
        
        //cell.likeBttn.tag = indexPath.row
        
        cell.usernameLbl.text = post.user.username
        cell.profilePhoto.downloadedFrom(url: post.user.profilePicture)
        cell.userLocationLbl.text = post.location?.name
        if cell.userLocationLbl.text == nil {
            cell.locationBttn.isHidden = true
        } else {
            cell.locationBttn.isHidden = false
        }
        
        cell.userPostImg.downloadedFrom(url: post.images.standardResolution.url, contentMode: .scaleAspectFill)
        //cell.contentTextView.text = post.caption?.text
        cell.likesLbl.text = (post.likes.count) == 1 ? "\(post.likes.count) like" : "\(post.likes.count) likes"
                
        return cell
        
    }

    @IBAction func findLocation(_ sender: Any) {
        print("show location")
    }
    
    @IBAction func addFriend(_ sender: Any) {
        print("pick me, pick me")
    }
    
    @IBAction func addLike(_ sender: UIButton) {
        //print("do you like me?")
        
        let instagramPost = self.instagramPosts[(sender as AnyObject).tag]
        
        let isLiked = sender.isSelected
        sender.isSelected = !isLiked
        let newStatus = !isLiked
        
        if newStatus == true {
            
            Instagram.shared.like(media: instagramPost.id, success:{
                print("like is done")
                
                if let cell = self.tableView.cellForRow(at: IndexPath.init(row: (sender as AnyObject).tag, section: 0)) as? SearchTableViewCell {
                    cell.likesLbl.text = "\(instagramPost.likes.count + 1) likes"
                    
                }
                
        
                }, failure: { error in
                    print(error.localizedDescription)
            })
            
            return
        }
        
        Instagram.shared.unlike(media: instagramPost.id, success:{
            print("unlike, unlike")
            
            if let cell = self.tableView.cellForRow(at: IndexPath.init(row: (sender as AnyObject).tag, section: 0)) as? SearchTableViewCell {
                cell.likesLbl.text = "\(instagramPost.likes.count - 1) likes"
                
            }
            
        }, failure: { error in
            print(error.localizedDescription)}
            
    )}
    
    
    @IBAction func addComment(_ sender: Any) {
        print("cao moze jedan comm")
    }
    
    // MARK: - Loading posts from Instagram
    
    func loadPosts(){
        
        Instagram.shared.recentMedia(fromUser: "self", count: 10, success: { mediaList in
            
            self.instagramPosts = mediaList
            self.tableView.reloadData()
            
            return
        }, failure: { error in
            print(error.localizedDescription)
        })
        
    }

    
}

