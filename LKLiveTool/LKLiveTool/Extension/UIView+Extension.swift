//
//  UIView+Extension.swift
//  LKLiveTool
//
//  Created by Hector on 16/9/5.
//  Copyright © 2016年 LK. All rights reserved.
//

import Foundation

extension UIView {
    
    public func cornerRadiusToBounds(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
}