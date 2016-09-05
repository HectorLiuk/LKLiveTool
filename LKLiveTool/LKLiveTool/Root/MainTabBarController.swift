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
    
    //设置访问直播权限
    private func setUpAccessAuthority() -> Bool{
        if UIDevice.deviceVersion() == "iPhone Simulator" {
            log.error("不能使用模拟器运行")
            return false
        }
        
        if !UIImagePickerController.isSourceTypeAvailable(.Camera) {
           log.error("您的设备没有摄像头或者相关的驱动, 不能进行直播")
            return false
        }
        
        //获取照相机访问权限
        let authStatus:AVAuthorizationStatus = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        if(authStatus == AVAuthorizationStatus.Denied || authStatus == AVAuthorizationStatus.Restricted) {
            
            return false
        }else{
            return true
        }
        
        return true
        
    }
    
}

extension MainTabBarController : UITabBarControllerDelegate{
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
        if viewController.isMemberOfClass(UINavigationController) {
            setUpAccessAuthority()
            
//            let sb = UIStoryboard(name: "Living", bundle: nil)
//            let livingVC = sb.instantiateInitialViewController()
//            
//            presentViewController(livingVC!, animated: true, completion: nil)
            
            return false
        }

        
        return true
        
    }
}