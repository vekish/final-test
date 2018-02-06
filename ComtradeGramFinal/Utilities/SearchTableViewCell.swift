//
//  SearchTableViewCell.swift
//  ComtradeGramFinal
//
//  Created by Vera  Sercel on 2/4/18.
//  Copyright © 2018 com.comtrade.Gram. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePhoto: UIImageView!    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var locationBttn: UIButton!
    @IBOutlet weak var userLocationLbl: UILabel!
    @IBOutlet weak var addFriend: UIButton!
    @IBOutlet weak var userPostImg: UIImageView!    
    @IBOutlet weak var likeBttn: UIButton!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var commentBttn: UIButton!
    @IBOutlet weak var commentsLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
