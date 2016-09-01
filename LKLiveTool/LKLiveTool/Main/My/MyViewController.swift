//
//  MyViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//


class MyViewController: BasicViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if tabBarController?.tabBar.hidden == true {
            tabBarController?.tabBar.hidden = false
            let animatedTabBar = self.tabBarController as! MainTabBarController
            animatedTabBar.animationTabBarHidden(false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
