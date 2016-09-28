//
//  InfoPlayerShowView.swift
//  LKLiveTool
//
//  Created by Hector on 16/9/2.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class InfoPlayerShowView: UIView {
    
    var player : IJKFFMoviePlayerController?
    
    //MARK: TopView
    @IBOutlet weak var topTitleView: UIView!
    
    @IBOutlet weak var topImage: UIImageView!
    
    @IBOutlet weak var topTitleLabel: UILabel!
    
    @IBOutlet weak var toPeppleCountLabel: UILabel!
    
    @IBOutlet weak var topOpenBtn: UIButton!
    
    //票数
    @IBOutlet weak var ticketView: UIView!
    
    @IBOutlet weak var ticketLabel: UILabel!
    
    @IBOutlet weak var ticketImage: UIImageView!
    
    @IBOutlet weak var AnchorScrollView: UIScrollView!
    
    @IBOutlet weak var giftClick: UIButton!

    //礼物效果
    /// 烟花
    var yanHuaGift = YanHuaView()
    
    
    
    var peopleRandomTimer: NSTimer!
    
    var loveGift: NSTimer!
    
    var array: [String]!
    
    var timer : NSTimer!
    
    lazy var renderer : BarrageRenderer = {
        let renderer = BarrageRenderer()
        renderer.canvasMargin = UIEdgeInsetsMake(screenWidth * 0.3, 10, 10, 10);
        
        return renderer
    }()
    
    var datas = [String]()
        
    
    var homeData : HomeModel? {
        didSet {
            toPeppleCountLabel.text = homeData!.online_users.stringValue
            topImage.kf_setImageWithURL(NSURL(string: MainImageUrl + (homeData!.creator.portrait)!),
                                         placeholderImage: nil,
                                         optionsInfo: nil)
            ticketLabel.text = "映票:666666"
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topTitleView.backgroundColor = showLivingGrayColor
        ticketView.backgroundColor = showLivingGrayColor
        
        topTitleView.cornerRadiusToBounds(25)
        ticketView.cornerRadiusToBounds(18)
        topOpenBtn.cornerRadiusToBounds(10)
        topImage.cornerRadiusToBounds(18)
        
        peopleRandomTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(InfoPlayerShowView.updataTopViewLableInfo), userInfo: nil, repeats: true)

        loveGift = NSTimer.scheduledTimerWithTimeInterval(0.25, target: self, selector: #selector(InfoPlayerShowView.showLoveGift), userInfo: nil, repeats: true)
        
        
//        for _ in 0  ..< 1000  {
//            datas.append("ssssssssssssssss")
//        }
        
        
        
        self.addSubview(renderer.view)
        renderer.start()
        //制造弹幕
        let saft = NSSafeObject(object: self, withSelector: #selector(autoSendBarrage))
        timer = NSTimer(timeInterval: 0.5, target: saft, selector: #selector(NSSafeObject.excute), userInfo: nil, repeats: true)
        
        
    }
    
    //MARK: 模拟实时数据跟新
    func updataTopViewLableInfo() {
        let randomCount = (Int)(arc4random_uniform(100))+1
        let watchPeopleCount = NSInteger((homeData?.online_users)!) + randomCount
        
        toPeppleCountLabel.text = "\(watchPeopleCount)"
        ticketLabel.text = "映票:\(666666+randomCount)"
        
    }
    
    deinit {
        peopleRandomTimer.invalidate()
        loveGift.invalidate()
        peopleRandomTimer = nil
        loveGift = nil
        
    }
    
    //MARK: --------------
    //MARK: 按钮点击触发事件
    @IBAction func openClick(sender: UIButton) {
        sender.selected = !sender.selected
        
         player?.shouldShowHudView = sender.selected
    }
    
    @IBAction func chatClick(sender: UIButton) {
        
    }
   
    
    //烟花
    @IBAction func beastClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            insertSubview(yanHuaGift, atIndex: 0)
        }else{
            yanHuaGift.removeFromSuperview()
        }
    }
    
    
    //暂停直播
    @IBAction func shareClick(sender: UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            player!.pause()
        }else{
            player!.play()
        }
    }
    
    func autoSendBarrage() {
        
        if renderer.spritesNumberWithName(nil) <= 50 {
            renderer.receive(danMuTextParams(BarrageWalkDirection.R2L))
        }
    }
    
    //生成弹幕
    func danMuTextParams(direction : BarrageWalkDirection) -> BarrageDescriptor {
        let descriptor = BarrageDescriptor()
        descriptor.spriteName = NSStringFromClass(BarrageWalkTextSprite);
        descriptor.params["text"] = "ssssssss"
        descriptor.params["textColor"] = UIColor.redColor();
        
        return descriptor
    }
    
    
    
    
    func showLoveGift() {
        let anim = XTLoveHeartView(frame:CGRectMake(0, 0, 40, 40))
        addSubview(anim)
       
        let fountainSource = CGPointMake( 60, bounds.size.height - 60 )
        anim.center = fountainSource;
        anim.animateInView(self)

    }
    
    
}
