//
//  PlayerLiveViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/31.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class PlayerLiveViewController: BasicViewController {

    var homeData : HomeModel?
        /// 高斯滤镜模糊效果
    lazy var blurView : UIImageView = {
       let blurView = UIImageView(frame: screenBounds)
        blurView.contentMode = .ScaleAspectFit
        
        blurView.kf_setImageWithURL(NSURL(string: MainImageUrl + (self.homeData!.creator.portrait)!),
                                     placeholderImage: nil,
                                     optionsInfo: nil)
        //模糊效果
        let blurEffect = UIBlurEffect(style: .Light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = blurView.bounds
        blurView.addSubview(visualEffectView)
        
        return blurView
    }()
    
    lazy var coseBtn : UIButton = {
       let coseBtn = UIButton(type: .Custom)
        coseBtn.setImage(UIImage(named: "mg_room_icon_stop"), forState: .Normal)
        coseBtn.addTarget(self, action: #selector(PlayerLiveViewController.coseLivingView), forControlEvents: .TouchUpInside)
        
        return coseBtn
    }()
    
    var player : IJKMediaPlayback!
    
    lazy var playerView : UIView = {
        let playerView = UIView(frame: screenBounds)
        playerView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        return playerView
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)

        //准备播放
        if player!.isPlaying() == false {
            player!.prepareToPlay()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCoseBtnInWindow()
        
        view.addSubview(blurView)
        
        startPlayer()
        
        

    }
    
    
    
    /**
     加载播放视频
     */
    func startPlayer() {
        
        player = IJKFFMoviePlayerController(contentURLString: homeData?.stream_addr, withOptions: nil)
        player?.scalingMode = .AspectFill
        
        playerView = (player?.view)!
        
        view.addSubview(playerView)
        
    }
    
    /**
     关闭按钮防止Window层
     */
    func addCoseBtnInWindow() {
        keyWindow?.addSubview(coseBtn)
        coseBtn.snp_makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.bottom.equalTo(-10)
            make.right.equalTo(-10)
        }
    }
    
    /**
     关闭当前视图
     */
    func coseLivingView() {
        player.shutdown()
        coseBtn.removeFromSuperview()
        navigationController?.setNavigationBarHidden(false, animated: false)

        popViewController()
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }


}
