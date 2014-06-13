//
//  ManageController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class ManageController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var pubTable : UITableView?
    var getTable : UITableView?
    var leftTab : UIButton? // 发布的任务
    var rightTab : UIButton? //领取的任务
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPubTable()
        setGetTable()
        var manageView = ManageViewDraw(_controller: self)
        leftTab=manageView.leftTab
        rightTab=manageView.rightTab
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func setPubTable(){
        self.pubTable = UITableView(frame:CGRectMake(7,70,306,UIScreen.mainScreen().applicationFrame.height-71), style:UITableViewStyle.Plain)
        self.pubTable!.delegate = self
        self.pubTable!.dataSource = self
        self.pubTable!.rowHeight = 160
        self.pubTable!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.pubTable!.backgroundColor = UIColor.clearColor()
        self.pubTable!.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view?.addSubview(self.pubTable)
    }
    
    func setGetTable(){
        self.getTable = UITableView(frame:CGRectMake(7,70,306,UIScreen.mainScreen().applicationFrame.height-71), style:UITableViewStyle.Plain)
        self.getTable!.delegate = self
        self.getTable!.dataSource = self
        self.getTable!.rowHeight = 160
        self.getTable!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.getTable!.backgroundColor = UIColor.clearColor()
        self.getTable!.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view?.addSubview(self.getTable)
        self.getTable!.hidden=true;
    }
    
    // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return 12
    }
    
    //创建一个单元格
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        if(tableView==self.pubTable){
            return GetPubTableView(tableView: tableView,indexPath: indexPath,tableIndex: 0).cell
        }
        else{
            return GetPubTableView(tableView: tableView,indexPath: indexPath,tableIndex: 1).cell
        }
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        if(tableView==self.pubTable){
            // 跳转到详情内页
            var detailsCon = DetailsController()
            self.presentModalViewController(detailsCon, animated:false)
            self.pubTable!.deselectRowAtIndexPath(indexPath, animated: false)
        }
        else{
            // 跳转到详情内页
            var detailsCon = DetailsController()
            self.presentModalViewController(detailsCon, animated:false)
            self.getTable!.deselectRowAtIndexPath(indexPath, animated: false)
        }
    }
    
    func footBtn1Action(sender: UIButton!) {
        var ViewCon = ViewController()
        self.presentModalViewController(ViewCon, animated:false)
    }
    
    func footBtn3Action(sender: UIButton!) {
        var myDataCon = MyDataController()
        self.presentModalViewController(myDataCon, animated:false)
    }
    
    func leftTabAction(sender: UIButton!) {
        sender.alpha=1
        self.rightTab!.alpha=0.5
        self.pubTable!.hidden=false;
        self.getTable!.hidden=true;
    }
    
    func rightTabAction(sender: UIButton!) {
        sender.alpha=1
        self.leftTab!.alpha=0.5
        self.getTable!.hidden=false;
        self.pubTable!.hidden=true;
    }
    
}