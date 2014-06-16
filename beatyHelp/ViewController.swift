//
//  ViewController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/6/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let identifier = "cell"
    var indexTable : UITableView?
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndexTable()
        loadData()
        // mainView 界面绘制
        MainViewDraw(_controller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func setIndexTable(){
        self.indexTable = UITableView(frame:CGRectMake(7,160,306,UIScreen.mainScreen().applicationFrame.height-179), style:UITableViewStyle.Plain)
        self.indexTable!.delegate = self
        self.indexTable!.dataSource = self
        self.indexTable!.rowHeight = 135
        self.indexTable!.registerClass(GetMainTabelCell.self, forCellReuseIdentifier: identifier)
        self.indexTable!.backgroundColor = UIColor.clearColor()
        self.indexTable!.separatorColor = UIColor.clearColor()
        self.automaticallyAdjustsScrollViewInsets = false
        self.view?.addSubview(self.indexTable)
    }
    
    func loadData()
    {
        var url = "http://mm.renren.com/task-all"
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            var arr = data["data"] as NSArray
            for data : AnyObject  in arr{
                self.dataArray.addObject(data)
            }
            self.indexTable!.reloadData()
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
        var cell = tableView?.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as? GetMainTabelCell
        var index = indexPath!.row
        var getData = self.dataArray[index] as NSDictionary
        cell!.data = getData
        cell!.getController = self
        return cell
    }
    
    // UITableViewDelegate Methods
    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        // 跳转到详情内页
        var detailsCon = DetailsController()
        var row = indexPath!.row
        detailsCon.rowIndex = row
        var getId = self.dataArray[row].objectForKey("id") as String
        detailsCon.id = getId.toInt()!
//        self.navigationController.pushViewController(detailsCon, animated: true)
//        detailsCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(detailsCon, animated:true)
        self.indexTable!.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func footBtn2Action(sender: UIButton!) {
        var manageCon = ManageController()
//        manageCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(manageCon, animated:false)
    }
    
    func footBtn3Action(sender: UIButton!) {
        var myDataCon = MyDataController()
//        myDataCon.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve;
        self.presentModalViewController(myDataCon, animated:false)
    }
}
