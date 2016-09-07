//
//  MyViewController.swift
//  LKLiveTool
//
//  Created by Hector on 16/8/30.
//  Copyright © 2016年 LK. All rights reserved.
//


class MyViewController: BasicViewController {
    
    @IBOutlet weak var headView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var array = ["映票贡献榜","收益","账户","等级","实名认证","设置"]
    var arrayDetail = ["","1000映票","1000钻石","99级","",""]

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = NavBGColor
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = NavBGColor
        headView.backgroundColor = NavBGColor
        
    }

}

// MARK: <<UITableViewDelegate UITableViewDataSource>>
extension MyViewController : UITableViewDelegate ,UITableViewDataSource{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MyTableViewCell", forIndexPath: indexPath)
        cell.textLabel?.text = array[indexPath.row]
        cell.detailTextLabel?.text = arrayDetail[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //        let vc = UIViewController()
        //        vc.hidesBottomBarWhenPushed = true
        //        tabBarController?.tabBar.hidden = true
        //        navigationController?.pushViewController(vc, animated: true)
    }
}