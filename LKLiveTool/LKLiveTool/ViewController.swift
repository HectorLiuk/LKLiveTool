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
        
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .response { response in
                print(response)
        }
        
        
    }


}

