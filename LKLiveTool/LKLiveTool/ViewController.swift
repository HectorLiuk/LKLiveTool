//
//  ViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/29.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit
import Alamofire


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
        
        let image0 = UIImageView()
        image0.kf_setImageWithURL(NSURL(string: "wwwww"))
        
        
        Alamofire.request(.GET, "https://httpbin.org/get", parameters: ["foo": "bar"])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let JSON = response.result.value {
                    print("JSON: \(JSON)")
                }
        }
    
        
    }

}


