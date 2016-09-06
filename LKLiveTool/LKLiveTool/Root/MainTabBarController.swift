//
//  MainTabBarController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class MainTabBarController: RAMAnimatedTabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    
    
}

extension MainTabBarController : UITabBarControllerDelegate{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
        if viewController.isMemberOfClass(UINavigationController) {
            
            let sb = UIStoryboard(name: "Living", bundle: nil)
            let livingVC = sb.instantiateInitialViewController()
            presentViewController(livingVC!, animated: true, completion: nil)
            return false
            
        }

        
        return true
        
    }
}