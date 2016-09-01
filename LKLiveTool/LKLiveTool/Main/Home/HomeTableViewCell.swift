//
//  HomeTableViewCell.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var peopleCountLabel: UILabel!
    
    @IBOutlet weak var mainImage: UIImageView!
    
    var homeData : HomeModel? {
        didSet {
            titleLabel.text = homeData!.creator!.nick
            locationLabel.text = homeData!.city
            peopleCountLabel.text = homeData!.online_users.stringValue
            iconImage.kf_setImageWithURL(NSURL(string: MainImageUrl + (homeData!.creator.portrait)!),
                                         placeholderImage: nil,
                                         optionsInfo: nil)
            mainImage.kf_setImageWithURL(NSURL(string: MainImageUrl + (homeData!.creator.portrait)!),
                                         placeholderImage: nil,
                                         optionsInfo: nil)
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        iconImage.layer.cornerRadius = 20.0
        iconImage.layer.masksToBounds = true
        iconImage.contentMode = .ScaleAspectFit
        mainImage.contentMode = .ScaleAspectFill
        mainImage.clipsToBounds = true
        
        titleLabel.textColor = homeTitleColor
        locationLabel.textColor = homeTitleColor
        
        peopleCountLabel.textColor = homePeopleColor
        
    }

    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
