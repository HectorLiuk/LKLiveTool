//
//  MainNavigationViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/31.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {
    
    override func loadView() {
        super.loadView()
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationBar.barTintColor = NavBGColor
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = false
        
        navigationBar.titleTextAttributes=[NSForegroundColorAttributeName:
            UIColor.whiteColor(),NSFontAttributeName:UIFont.boldSystemFontOfSize(20)];
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    



}
