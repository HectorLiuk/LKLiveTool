//
//  ImportHeader.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/29.
//  Copyright © 2016年 LK. All rights reserved.
//

import Foundation
import SnapKit //autolayout 约束
import Kingfisher //图片异步请求








// MARK: 接口
let HomeUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
// 图片
let MainImageUrl = "http://img.meelive.cn/"

// MARK: DEBUG打印
func DEBUGLOG<T>(message: T, file: NSString = #file, method: String = #function, line: Int = #line)
{
    #if DEBUG
        print("\(method)[\(line)]: \(message)")
    #endif
}