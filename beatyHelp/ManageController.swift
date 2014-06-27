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
    let identifier = "cell" //tableCell的identifier
    var indexTable : UITableView? //首页的tableView
    var pubTable : UITableView?
    var getTable : UITableView?
    var leftTab : UIButton? // 发布的任务
    var rightTab : UIButton? //领取的任务
    var dataArray = NSMutableArray() //数据list
    var initTab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPubTable()
        setGetTable()
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        if initTab==0{
            loadData(self.pubTable!,url:"http://mm.nextsystem.pw/task-all?userid=\(applyid)")
        }
        else if initTab==1{
            loadData(self.getTable!,url:"http://mm.nextsystem.pw/task-all?applyid=\(applyid)")
        }
        var manageView = ManageViewDraw(_controller: self)
        leftTab=manageView.leftTab
        rightTab=manageView.rightTab
        if self.initTab==1{
            self.leftTab!.alpha=0.5
            self.rightTab!.alpha=1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    
    func setPubTable(){
        self.pubTable = UITableView(frame:CGRectMake(7,70,306,UIScreen.mainScreen().applicationFrame.height-90), style:UITableViewStyle.Plain)
//        self.pubTable!.rowHeight = 160
        
        self.pubTable!.delegate = self
        self.pubTable!.dataSource = self
        self.pubTable!.registerClass(GetPubTabelCell.self, forCellReuseIdentifier: identifier)
        self.pubTable!.backgroundColor = UIColor.clearColor()
        self.pubTable!.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.pubTable)
        if(self.initTab==1){
            self.pubTable!.alpha=0
            self.pubTable!.frame.origin.x = -UIScreen.mainScreen().applicationFrame.width+7
        }
    }
    
    func setGetTable(){
        self.getTable = UITableView(frame:CGRectMake(7,70,306,UIScreen.mainScreen().applicationFrame.height-90), style:UITableViewStyle.Plain)
//        self.getTable!.rowHeight = 160
        
        self.getTable!.delegate = self
        self.getTable!.dataSource = self
        self.getTable!.registerClass(GetPubTabelCell.self, forCellReuseIdentifier: "cell")
        self.getTable!.backgroundColor = UIColor.clearColor()
        self.getTable!.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.addSubview(self.getTable)
//        self.getTable!.hidden=true;
        if(self.initTab==0){
            self.getTable!.alpha=0
            self.getTable!.frame.origin.x = UIScreen.mainScreen().applicationFrame.width
        }
    }
    
    /**
    *  数据载入
    */
    func loadData(curTable:UITableView!,url:String!)
    {
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }else{
                var arr = data["data"] as NSArray //获取返回的数据list数组
                self.dataArray=[]
                for data : AnyObject  in arr{ //遍历保存数据
                    self.dataArray.addObject(data)
                }
                curTable.reloadData() //更新tableView内的数据
            }
            //            UIView.showAlertView("提示",message:toString(self.dataArray))
            })
    }
    
    // UITableViewDataSource Methods
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    
    //创建一个单元格
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
//        if(tableView==self.pubTable){
//            return GetPubTableView(tableView: tableView,indexPath: indexPath,tableIndex: 0).cell
//        }
//        else{
//            return GetPubTableView(tableView: tableView,indexPath: indexPath,tableIndex: 1).cell
        //        }
//        var CellIdentifier = NSString.localizedStringWithFormat("cell\(index)", indexPath.section, indexPath.row)
//        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? GetPubTabelCell
        
        var cell = tableView?.cellForRowAtIndexPath(indexPath) as? GetPubTabelCell
        
        if cell == nil{
            cell = GetPubTabelCell(style: UITableViewCellStyle.Default,reuseIdentifier: identifier)
            var index = indexPath!.row
            var getData = self.dataArray[index] as NSDictionary
            cell!.data = getData
            if tableView==self.pubTable{
                cell!.tableType=0
            }
            else{
                cell!.tableType=1
            }
            cell!.getController = self
        }
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
//        if(tableView==self.pubTable){
//            // 跳转到详情内页
//            var detailsCon = DetailsController()
//            self.presentModalViewController(detailsCon, animated:false)
//            self.pubTable!.deselectRowAtIndexPath(indexPath, animated: false)
//        }
//        else{
//            // 跳转到详情内页
//            var detailsCon = DetailsController()
//            self.presentModalViewController(detailsCon, animated:false)
//            self.getTable!.deselectRowAtIndexPath(indexPath, animated: false)
//        }
        // 跳转到详情内页
        var detailsCon = DetailsController()
        var row = indexPath!.row
        detailsCon.rowIndex = row
        var getId = self.dataArray[row].objectForKey("id") as String
        detailsCon.id = getId.toInt()!
        //        self.navigationController.pushViewController(detailsCon, animated: true)
        //        detailsCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(detailsCon, animated:true)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView!, heightForRowAtIndexPath indexPath: NSIndexPath!) -> CGFloat
     {
        var index = indexPath!.row
        var data = self.dataArray[index] as NSDictionary
//        return  GetPubTabelCell.cellHeightByData(data)
        
        return  GetPubTabelCell.cellHeightByData(data)
    }
    
    
    func footBtn1Action(sender: UIButton!) {
        var ViewCon = ViewController()
//        ViewCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(ViewCon, animated:false)
    }
    
    func footBtn3Action(sender: UIButton!) {
        var myDataCon = MyDataController()
//        myDataCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(myDataCon, animated:false)
    }
    
    func leftTabAction(sender: UIButton!) {
        sender.alpha=1
        self.rightTab!.alpha=0.5
//        self.pubTable!.hidden=false;
        //        self.getTable!.hidden=true;
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        loadData(self.pubTable!,url:"http://mm.nextsystem.pw/task-all?userid=\(applyid)")
        UIView.animateWithDuration(0.5, animations: {
            self.getTable!.alpha = 0;
            self.getTable!.frame.origin.x = UIScreen.mainScreen().applicationFrame.width-7
            self.pubTable!.alpha = 1;
            self.pubTable!.frame.origin.x = 7
            }, completion: { finished in })
    }
    
    func rightTabAction(sender: UIButton!) {
        sender.alpha=1
        self.leftTab!.alpha=0.5
//        self.getTable!.hidden=false;
        //        self.pubTable!.hidden=true;
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        loadData(self.getTable!,url:"http://mm.nextsystem.pw/task-all?applyid=\(applyid)")
        // Animate in the alert view
        UIView.animateWithDuration(0.5, animations: {
             self.getTable!.alpha = 1;
             self.getTable!.frame.origin.x = 7
             self.pubTable!.alpha = 0;
             self.pubTable!.frame.origin.x = -UIScreen.mainScreen().applicationFrame.width+7
            }, completion: { finished in })
    }
    
//    func otherImage(sender: UIButton!){
//        var otherCon = OtherController()
//        otherCon.uid = sender.tag
//        self.presentModalViewController(otherCon, animated:true)
//    }
    
}