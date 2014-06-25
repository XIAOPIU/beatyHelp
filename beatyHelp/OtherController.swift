//
//  OtherController.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/16/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class OtherController: UIViewController {
    var uid: Int = 0
    var index: Int = 0
    var dataArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFriendData(uid)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func loadFriendData(uid:Int){
        var url = "http://mm.nextsystem.pw/users-friend?uid=" + String(uid)
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            if data as NSObject == NSNull(){
                UIView.showAlertView("提示",message:"加载失败")
                return
            }
            
            var arr = data["data"] as NSArray
            for data : AnyObject  in arr{
                self.dataArray.addObject(data)
            }
            OtherViewDraw(_controller: self)
//            self.setView(scrollView)
            }
        )
    }
    
    func otherImage(sender: UIButton!){
        var otherCon = OtherController()
        otherCon.uid = (dataArray[sender.tag].objectForKey("id") as String).toInt()!
        self.presentModalViewController(otherCon, animated:true)
    }
    
    func goBackAction(sender: UIButton!) {
        //        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
}