//
//  InfoPlayerShowView.swift
//  LKLiveTool
//
//  Created by Hector on 16/9/2.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class InfoPlayerShowView: UIView {
    
    //MARK: TopView
    @IBOutlet weak var topTitleView: UIView!
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var topTitleLabel: UILabel!
    
    @IBOutlet weak var toPeppleCountLabel: UILabel!
    
    @IBOutlet weak var topOpenBtn: UIButton!
    
    //票数
    @IBOutlet weak var ticketView: UIView!
    
    @IBOutlet weak var ticketLabel: UILabel!
    
    @IBOutlet weak var ticketImage: UIImageView!
    
    @IBOutlet weak var AnchorScrollView: UIScrollView!
    
    
    
    
    var homeData : HomeModel? {
        didSet {
            toPeppleCountLabel.text = homeData!.online_users.stringValue
            topImage.kf_setImageWithURL(NSURL(string: MainImageUrl + (homeData!.creator.portrait)!),
                                         placeholderImage: nil,
                                         optionsInfo: nil)
            ticketLabel.text = "映票:666666"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topTitleView.backgroundColor = showLivingGrayColor
        ticketView.backgroundColor = showLivingGrayColor
        
        topTitleView.cornerRadiusToBounds(25)
        ticketView.cornerRadiusToBounds(18)
        topOpenBtn.cornerRadiusToBounds(10)
        topImage.cornerRadiusToBounds(18)
        
        NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(InfoPlayerShowView.showImage), userInfo: nil, repeats: true)
        
    }
    
    
    
    @IBAction func openClick(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    @IBAction func chatClick(sender: AnyObject) {
        
        
        
        

        
    }
   
    
    @IBAction func beastClick(sender: AnyObject) {
    }
    
    @IBOutlet weak var giftClick: UIButton!
    
    @IBAction func shareClick(sender: AnyObject) {
    }
    
    func showImage() {
        let anim = XTLoveHeartView(frame:CGRectMake(0, 0, 40, 40))
        addSubview(anim)
        let fountainSource = CGPointMake(frame.size.width - 80, bounds.size.height - 30 / 2.0 - 10)
        anim.center = fountainSource;
        anim.animateInView(self)
        
    }
    
    
}
