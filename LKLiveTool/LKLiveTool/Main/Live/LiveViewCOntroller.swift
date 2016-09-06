//
//  LiveViewCOntroller.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//


class LiveViewCOntroller: BasicViewController {
    
    
    @IBOutlet weak var livingStateLabel: UILabel!
    
    @IBOutlet weak var beautyButton: UIButton!
    
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var closeButton: UIButton!
    
    
    
    lazy var session: LFLiveSession = {
        /// 音频设置
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration()
        /// 视频设置  
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfigurationForQuality(.Low3, outputImageOrientation: .Portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        
        session?.delegate = self
        session?.preView = self.view

        return session!
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        requestAccessForVideo()
        requestAccessForAudio()
        
    }
    //MARK: -------------
    //MARK: 页面按钮触发事件
    //美颜
    @IBAction func didTappedBeautyButton(sender: UIButton) {
        session.beautyFace = !session.beautyFace
        sender.selected = !session.beautyFace
    }
    
    //摄像头 前置后置
    @IBAction func didTappedCameraButton(sender: AnyObject) {
        let devicePositon = session.captureDevicePosition
        
        session.captureDevicePosition = (devicePositon == AVCaptureDevicePosition.Back) ? AVCaptureDevicePosition.Front : AVCaptureDevicePosition.Back;
    }
    
    //关闭
    @IBAction func didTappedCloseButton(sender: UIButton) {
        dismissViewControllerAnimated(true) { 
            
        }
    }
    
    //开启直播  结束直播
    @IBAction func didTappedStartLiving(sender: UIButton) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            let stream = LFLiveStreamInfo()
//            rtmp://
            stream.url = "rtmp://192.168.101.5:1935/rtmplive/room"
            session.startLive(stream)
        } else {
            session.stopLive()
        }
    }
    
    
    
    
    //MARK: 视频权限AccessAuth
    func requestAccessForVideo() -> Void {
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo)
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted) in
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), {
                        self.session.running = true;
                    });
                }
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.Authorized:
            session.running = true;
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.Denied: break
        case AVAuthorizationStatus.Restricted:break;
        
        }
    }
    
    //MARK: 音频权限
    func requestAccessForAudio() -> Void {
        let status = AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeAudio)
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.NotDetermined:
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeAudio, completionHandler: { (granted) in
            })
            break;
        // 已经开启授权，可继续
        case AVAuthorizationStatus.Authorized:
            break;
        // 用户明确地拒绝授权，或者相机设备无法访问
        case AVAuthorizationStatus.Denied: break
        case AVAuthorizationStatus.Restricted:break;
        
        }
    }

}

extension LiveViewCOntroller: LFLiveSessionDelegate{
    
    func liveSession(session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        log.info("debugInfo: \(debugInfo?.currentBandwidth)")
    }
    
    func liveSession(session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        log.info("errorCode: \(errorCode.rawValue)")
    }
    
    func liveSession(session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        log.info("liveStateDidChange: \(state.rawValue)")
        switch state {
        case LFLiveState.Ready:
            livingStateLabel.text = "未连接"
            break;
        case LFLiveState.Pending:
            livingStateLabel.text = "连接中"
            break;
        case LFLiveState.Start:
            livingStateLabel.text = "已连接"
            break;
        case LFLiveState.Error:
            livingStateLabel.text = "连接错误"
            break;
        case LFLiveState.Stop:
            livingStateLabel.text = "未连接"
            break;
        }
    }
    
}

