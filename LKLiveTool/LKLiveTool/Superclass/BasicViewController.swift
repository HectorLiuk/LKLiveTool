//
//  BasicViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class BasicViewController: UIViewController {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if navigationController?.viewControllers.count > 1 {
            tabBarHidden()
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        //在iOS 7中，苹果引入了一个新的属性，叫做[UIViewController setEdgesForExtendedLayout:]，它的默认值为UIRectEdgeAll。当你的容器是navigation controller时，默认的布局将从navigation bar的顶部开始。这就是为什么所有的UI元素都往上漂移了44pt。
        //        edgesForExtendedLayout = .None
        
        let backBarItem = UIBarButtonItem(title: "", style: .Plain, target: nil, action:nil)
        navigationItem.backBarButtonItem = backBarItem
        
        
    }
    
    internal func popViewController() -> Void {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    
    
    
    private func tabBarHidden() {
        
        if tabBarController?.tabBar.hidden == false {
            tabBarController?.tabBar.hidden = true
            let animatedTabBar = self.tabBarController as! MainTabBarController
            animatedTabBar.animationTabBarHidden(true)
        }
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
