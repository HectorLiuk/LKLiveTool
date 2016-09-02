//
//  InfoPlayerShowView.swift
//  LKLiveTool
//
//  Created by Hector on 16/9/2.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class InfoPlayerShowView: UIView {

    
    @IBAction func chatClick(sender: AnyObject) {
         NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(InfoPlayerShowView.showImage), userInfo: nil, repeats: true)
        
        
        

        
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
