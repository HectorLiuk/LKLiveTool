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
        
        addMovieNotificationObservers()
        
        

    }
    
    
    // MARK: player设置
    /**
     加载播放视频
     */
    func startPlayer() {
        
        player = IJKFFMoviePlayerController(contentURLString: homeData?.stream_addr, withOptions: nil)
        player?.scalingMode = .AspectFill
        
        playerView = (player?.view)!
        
        view.addSubview(playerView)
        
    }
    
    // MARK: ------------------
    // MARK: 添加player通知
    func addMovieNotificationObservers() {
        
        //通知准备好改变的对象状态 遵从MPMediaPlayback协议的改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKMPMediaPlaybackIsPreparedToPlayDidChange(_:)), name: IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification, object: player)
        
        //通知播放器形状比例模型已经发生改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKMPMediaPlaybackIsPreparedToPlayDidChange(_:)), name: IJKMPMoviePlayerScalingModeDidChangeNotification, object: player)
        
        //通知视频播放结束时或用户退出播放
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKFFMovieMoviePlayBackFinish(_:)), name: IJKMPMoviePlayerPlaybackDidFinishNotification, object: player)
        
        //通知视频播放状态发生改变是，已程序或者告诉用户
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKFFMovieLoadStateDidChange(_:)), name: IJKMPMoviePlayerPlaybackStateDidChangeNotification, object: player)

        //通知在网络加载时状态更改
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKFFMovieLoadStateDidChange(_:)), name: IJKMPMoviePlayerLoadStateDidChangeNotification, object: player)
        
        
    }
    
    deinit {
        //移除通知监听
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
    }
    
    // MARK: 通知准备好改变的对象状态 遵从MPMediaPlayback协议的改变
    func IJKMPMediaPlaybackIsPreparedToPlayDidChange(notification : NSNotification) {
        print("IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification")
    }
    
    // MARK: 通知播放器形状比例模型已经发生改变
    func IJKMPMoviePlayerScalingModeDidChange(notification : NSNotification) {
        print("IJKMPMoviePlayerScalingModeDidChange")
    }
    
    // MARK: 通知视频播放结束时或用户退出播放
    func IJKFFMovieMoviePlayBackFinish(notification : NSNotification) {
        
        let finishState = notification.userInfo![IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! IJKMPMovieFinishReason
        
        switch finishState {
        case .PlaybackEnded:
            print("视频退出播放:  IJKMPMovieFinishReason(视频结束)" )
            break
        case .UserExited:
            print("视频退出播放:  IJKMPMovieFinishReason(用户退出视频)" )
            break

        case .PlaybackError:
            print("视频退出播放:  IJKMPMovieFinishReason(视频播放出现错误退出)" )
            break
        }
    }
    
    // MARK: 通知视频播放状态发生改变是，已程序或者告诉用户
    func IJKMPMoviePlayerPlaybackStateDidChange(notification : NSNotification) {
//        switch player.playbackState {
//        case .:
//            <#code#>
//        default:
//            <#code#>
//        }
    }
    
    
    // MARK: 通知在网络加载时状态更改
    func IJKFFMovieLoadStateDidChange(notification : NSNotification) {
        let loadState = player.loadState
        print("++++网络加载时状态更改:\(player.loadState)")
        if loadState  != IJKMPMovieLoadState.Unknown || loadState == IJKMPMovieLoadState.PlaythroughOK   {
            print("网络加载时状态更改:  IJKMovieLoadStatePlayThroughOK(播放将要自动开始状态)  \(player.loadState)" )
            
        }else if loadState  != IJKMPMovieLoadState.Unknown || loadState == IJKMPMovieLoadState.Stalled {
            print("网络加载时状态更改:  IJKMPMovieLoadStateStalled(播放将要自动暂停)  \(player.loadState)" )
            
        }else{
            print("网络加载时状态更改:  ??????????(状态未知)  \(player.loadState)" )
            
        }
    }
    
    
    
    // MARK: 退出设置
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
        player.stop()
        player.shutdown()
        coseBtn.removeFromSuperview()
        navigationController?.setNavigationBarHidden(false, animated: false)

        popViewController()
    }
    
    


}
