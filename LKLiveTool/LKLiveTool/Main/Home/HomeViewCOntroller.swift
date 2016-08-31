//
//  HomeViewCOntroller.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//

import UIKit
import Alamofire

class HomeViewCOntroller: BasicViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var dataArray : [NSObject]?
    
    lazy var refreshView: DGElasticPullToRefreshLoadingViewCircle = {
        let refreshView = DGElasticPullToRefreshLoadingViewCircle()
        refreshView.tintColor = UIColor.whiteColor()
        
        return refreshView
    }()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestHomeList()
        
        addRefreshView()
        
        
        
        
        
        
    }
    
    
    
    private func addRefreshView() {
        tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self!.requestHomeList()
            
            }, loadingView: self.refreshView)
        
        tableView.dg_setPullToRefreshFillColor(NavBGColor)
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        
    }
    
    func requestHomeList(){

        Alamofire.request(.GET, HomeUrl, parameters: nil)
            .responseJSON { response in
//                print(response.request!)  // original URL request
//                print(response.response!) // URL response
//                print(response.result.value)   // result of response
                if let JSON = response.result.value {
                    print(JSON)
                    self.dataArray?.removeAll()
                    
                    let dic = JSON as! NSDictionary
                    let array = dic["lives"] as! NSArray
                    
                    self.dataArray = HomeModel.parses(arr: array)
                    
                    self.tableView.dg_stopLoading()
                    
                    self.tableView.reloadData()
                }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        super.prepareForSegue(segue, sender: sender)
        //判断segue.identifier
        if segue.identifier == "pushDetail"{
//            let page2 = segue.destinationViewController
            

        }
    }
    
    
}


// MARK: <<UITableViewDelegate UITableViewDataSource>>
extension HomeViewCOntroller : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //?? 表示判空
        //如果dataArray是空 则count(为0) 不为空 dataArray?.count
        return dataArray?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeTableViewCell", forIndexPath: indexPath) as! HomeTableViewCell
        cell.homeData = dataArray![indexPath.row] as? HomeModel
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let vc = UIViewController()
//        vc.hidesBottomBarWhenPushed = true
//        navigationController?.pushViewController(vc, animated: true)
    }
}