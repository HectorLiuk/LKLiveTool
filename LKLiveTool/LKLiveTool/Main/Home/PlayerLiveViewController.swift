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
        coseBtn.setImage(UIImage(named: "talk_close_40x40"), forState: .Normal)
        coseBtn.addTarget(self, action: #selector(PlayerLiveViewController.coseLivingView), forControlEvents: .TouchUpInside)
        
        return coseBtn
    }()
    
    var player : IJKFFMoviePlayerController!
    
    lazy var playerView : UIView = {
        let playerView = UIView(frame: screenBounds)
        //swift 枚举多选
        playerView.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        return playerView
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.sharedApplication().setStatusBarStyle(UIStatusBarStyle.LightContent, animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCoseBtnInWindow()
        
        view.addSubview(blurView)
        
        startPlayer()
        
        addMovieNotificationObservers()
                
        let inforView = PlayerShowInfoView(model: homeData!, play: player)
        view.addSubview(inforView)
        
        
        
    }
    
    
    // MARK: player设置
    /**
     加载播放视频
     */
    func startPlayer() {
        
        //对视频播放编码选择
        let options = IJKFFOptions.optionsByDefault()
        
        //开启硬编码 会出现画声音不同
        options.setPlayerOptionIntValue(1, forKey: "videotoolbox")
        
        // 帧速率(fps) （可以改，确认非标准桢率会导致音画不同步，所以只能设定为15或者29.97  一般默认就好不需要设置）
//        options.setPlayerOptionIntValue(15 , forKey: "r")
        
        // -vol——设置音量大小，256为标准音量。（要设置成两倍音量时则输入512，依此类推)
        options.setPlayerOptionIntValue(256, forKey: "vol")
        
        //播放器设置
        player = IJKFFMoviePlayerController(contentURLString: homeData?.stream_addr, withOptions: options)
        
        player?.scalingMode = .AspectFill
        
        // 设置自动播放(必须设置为NO, 防止自动播放, 才能更好的控制直播的状态) 必须调用play() 方法才能开启直播。
//        player.shouldAutoplay = false
//        player.play()
        
        
        //准备播放 不需要我们手动开启直播 不需要调用play()
        player!.prepareToPlay()
        
        
        playerView = (player?.view)!
        
        view.addSubview(playerView)
        
    }
    
    // MARK: ------------------
    // MARK: 添加player通知
    func addMovieNotificationObservers() {
        
        //通知准备好改变的对象状态 遵从MPMediaPlayback协议的改变
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKMPMediaPlaybackIsPreparedToPlayDidChange(_:)), name: IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification, object: player)
        
        //通知播放器形状比例模型已经发生改变
        //        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(PlayerLiveViewController.IJKMPMediaPlaybackIsPreparedToPlayDidChange(_:)), name: IJKMPMoviePlayerScalingModeDidChangeNotification, object: player)
        
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
        
        log.info("IJKMPMediaPlaybackIsPreparedToPlayDidChangeNotification 通知准备好改变的对象状态 遵从MPMediaPlayback协议的改变 \(notification.userInfo)")
    }
    
//    // MARK: 通知播放器形状比例模型已经发生改变
//    func IJKMPMoviePlayerScalingModeDidChange(notification : NSNotification) {
//        log.info("IJKMPMoviePlayerScalingModeDidChange")
//    }
    
    // MARK: 通知视频播放结束时或用户退出播放
    func IJKFFMovieMoviePlayBackFinish(notification : NSNotification) {
        
        let finishState = notification.userInfo![IJKMPMoviePlayerPlaybackDidFinishReasonUserInfoKey] as! IJKMPMovieFinishReason
        
        switch finishState {
        case .PlaybackEnded:
            
            log.info("视频退出播放:  IJKMPMovieFinishReason(视频结束)" )
            break
        case .UserExited:
            log.info("视频退出播放:  IJKMPMovieFinishReason(用户退出视频)" )
            break
            
        case .PlaybackError:
            log.info("视频退出播放:  IJKMPMovieFinishReason(视频播放出现错误退出)" )
            break
        }
    }
    
    // MARK: 通知视频播放状态发生改变时，已程序或者告诉用户
    func IJKMPMoviePlayerPlaybackStateDidChange(notification : NSNotification) {
        switch player.playbackState {
        case .Playing:
            log.info("通知视频播放状态发生改变时:  ---(Playing)")
            
            break
        case .Stopped:
            log.info("通知视频播放状态发生改变时:  ---(Stopped)")
            
            break
        case .Paused:
            log.info("通知视频播放状态发生改变时:  ---(Paused)")

            break
        case .Interrupted:
            log.info("通知视频播放状态发生改变时:  ---(Interrupted 被阻止被中断)")

            break
        case .SeekingBackward:
            log.info("通知视频播放状态发生改变时:  ---(SeekingBackward 视频后退)")
            
            break
        case .SeekingForward:
            log.info("通知视频播放状态发生改变时:  ---(SeekingForward 视频前进)")

            break

        }
    }
    
    
    // MARK: 通知在网络加载时状态更改
    func IJKFFMovieLoadStateDidChange(notification : NSNotification) {
        let loadState = player.loadState
        
        if loadState.rawValue == 1 {
            log.info("网络加载时状态更改:  IJKMPMovieLoadStatePlayable(播放未知？？？？？？)  \(player.loadState)" )

        }else if loadState.rawValue == 2 {
            log.info("网络加载时状态更改:  IJKMPMovieLoadStatePlayable(播放可持续的)  \(player.loadState)" )
            
        }else if loadState.rawValue == 3 {
            log.info("网络加载时状态更改:  IJKMovieLoadStatePlayThroughOK(播放将要自动开始状态)  \(player.loadState)" )
//            if !player.isPlaying() {
//                player.play()
//                
//            }
            
        }else if loadState.rawValue == 4 {
            log.info("网络加载时状态更改:  IJKMPMovieLoadStateStalled(网速不佳播放将要自动暂停)  \(player.loadState)" )
            
        }
        
        //        if loadState  != IJKMPMovieLoadState.Unknown && loadState == IJKMPMovieLoadState.PlaythroughOK   {
        //            log.info("网络加载时状态更改:  IJKMovieLoadStatePlayThroughOK(播放将要自动开始状态)  \(player.loadState)" )
        //
        //        }else if loadState  != IJKMPMovieLoadState.Unknown && loadState == IJKMPMovieLoadState.Stalled {
        //            log.info("网络加载时状态更改:  IJKMPMovieLoadStateStalled(网速不佳播放将要自动暂停)  \(player.loadState)" )
        //
        //        }else{
        //            log.info("网络加载时状态更改:  ??????????(状态未知)  \(player.loadState)" )
        //            
        //        }
        
        
    }
    
    
    
    // MARK: 退出设置
    /**
     关闭按钮防止Window层
     */
    func addCoseBtnInWindow() {
        keyWindow?.addSubview(coseBtn)
        coseBtn.snp_makeConstraints { (make) in
            make.width.height.equalTo(44)
            make.bottom.equalTo(-16)
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
