//
//  ViewController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/6/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import UIKit


/**
*  首页controller
*/
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let identifier = "cell" //tableCell的identifier
    var indexTable : UITableView? //首页的tableView
    var dataArray = NSMutableArray() //首页数据
    var userData = NSMutableArray() //首页数据
    var getUserId = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setIndexTable() //设置并创建tableView
        loadUserData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
    *  使顶部状态bar变为白色
    */
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    /**
    *  设置并创建tableView
    */
    func setIndexTable(){
        self.indexTable = UITableView(frame:CGRectMake(7,160,306,UIScreen.mainScreen().applicationFrame.height-179), style:UITableViewStyle.Plain) //创建tableView并设置CGRect以及样式
        self.indexTable!.delegate = self //设置委托
        self.indexTable!.dataSource = self //设置数据源
        self.indexTable!.rowHeight = 135 //table每行高度
        self.indexTable!.registerClass(GetMainTabelCell.self, forCellReuseIdentifier: identifier) //为table创建cell
        self.indexTable!.backgroundColor = UIColor.clearColor() //清除背景色
        self.indexTable!.separatorColor = UIColor.clearColor() //清除风格行样式
        self.automaticallyAdjustsScrollViewInsets = false //scrollView的内容自动调整
        self.view.addSubview(self.indexTable) //控件添加到controller
    }
    
    func loadUserData(){
        var url = "http://mm.renren.com/users-get?id=\(getUserId)" //"
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            var getData = data["data"] as NSDictionary //获取返回的数据list数组
            
            var plistPath = NSBundle.mainBundle().pathForResource("statuses",ofType: "plist")
            var dictionary = NSMutableDictionary(contentsOfFile:plistPath)
            var userData : (AnyObject!) = dictionary.objectForKey("userInfo")
            
            userData.setObject(getData.objectForKey("id"), forKey:"userId")
            userData.setObject(getData.objectForKey("uname"), forKey:"userName")
            userData.setObject(getData.objectForKey("mobile"), forKey:"phoneNum")
            userData.setObject(getData.objectForKey("status"), forKey:"userSign")
            userData.setObject(getData.objectForKey("avatar"), forKey:"headImage")
            
            dictionary.setObject(userData, forKey:"userInfo")
            
            dictionary.writeToFile(plistPath, atomically: true)
            self.loadData() //数据加载
            self.indexTable!.reloadData() //更新tableView内的数据
            //            UIView.showAlertView("提示",message:toString(self.dataArray))
            })
    }
    
    /**
    *  tablelist数据载入
    */
    func loadData()
    {
        let applyid = toString(getDictionary("userInfo").objectForKey("userId"))
        var url = "http://mm.nextsystem.pw/task-all?status=1&exuid=\(applyid)" //接口url
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            var arr = data["data"] as NSArray //获取返回的数据list数组
            for data : AnyObject  in arr{ //遍历保存数据
                self.dataArray.addObject(data)
            }
            MainViewDraw(_controller: self) //mainView界面绘制
            self.indexTable!.reloadData() //更新tableView内的数据
//            UIView.showAlertView("提示",message:toString(self.dataArray))
            })
    }
    
    /**
    *  设置tabel组数
    */
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }
    
    /**
    *  设置每组个数
    */
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.dataArray.count
    }
    
    /**
    *  创建一个单元格
    */
    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell = tableView?.cellForRowAtIndexPath(indexPath) as? GetMainTabelCell
        
        if cell == nil{
            cell = GetMainTabelCell(style: UITableViewCellStyle.Default,reuseIdentifier: identifier)
            var index = indexPath!.row
            var getData = self.dataArray[index] as NSDictionary
            cell!.data = getData
            cell!.getController = self
        }
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
    
    func cellBottomEvent(sender: UIButton!){
        var cell = sender.superview.superview as UITableViewCell
        var path = self.indexTable!.indexPathForCell(cell)
        var getId = self.dataArray[path.row].objectForKey("id") as String
//        func indexPathForCell(cell: UITableViewCell!) -> NSIndexPath! // returns nil if cell is not
        
        switch(sender.tag) {
        case 0:
            BHAlertView().comment(self, title: "任务评论", subTitle: "是否前往评论该任务？", alertType: "alertComment",userId: getId)
        case 1:
            BHAlertView().share(self, title: "任务分享", subTitle: "是否确定分享该任务？", alertType: "alertShare")
        case 2:
            BHAlertView().doIt(self, title: "任务领取", subTitle: "是否确定领取该任务，\n并在2014-05-19 17:00前完成？", alertType: "alertDoIt", cellData: self.dataArray[path.row] as NSDictionary )
        default:
            println("default")
        }
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
    
    func createAction(sender: UIButton!) {
        var createCon = CreateController()
        self.presentModalViewController(createCon, animated:true)
    }
}
