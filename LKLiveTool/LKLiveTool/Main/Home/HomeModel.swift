//
//  HomeModel.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/31.
//  Copyright © 2016年 LK. All rights reserved.
//

import Foundation

/* 首页列表模型类 */
class HomeModel: Reflect {
    
    var ID : String!
    
    var city : String!
    
    var online_users : NSNumber!
    
    var stream_addr : String!
    
    var creator : Creator!
    
    
    
}

class Creator: Reflect {
    var portrait : String!
    var nick : String!
    
}
