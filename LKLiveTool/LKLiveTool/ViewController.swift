//
//  ViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/29.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let viewRed = UIView()
        viewRed.backgroundColor = UIColor.redColor()
        
        view.addSubview(viewRed);
        
        viewRed.snp_makeConstraints { (make) in
            make.center.equalTo(self.view)
            make.width.height.equalTo(50)
        }
        
        
    }


}

