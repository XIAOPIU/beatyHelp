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
//    var rowIndex: Int = 0
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
        var url = "http://mm.renren.com/users-friend?uid=" + String(uid)
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            println(data)
            var arr = data["data"] as NSArray
            for data : AnyObject  in arr{
                self.dataArray.addObject(data)
            }
            OtherViewDraw(_controller: self)
//            self.setView(scrollView)
            })
    }
    
    func otherImage(sender: UIButton!){
        //        println(123)
        // 跳转到详情内页
        var otherCon = OtherController()
        otherCon.uid = (dataArray[index].objectForKey("id") as String).toInt()!
//        otherCon.uid = uid
        self.presentModalViewController(otherCon, animated:true)
    }
    
    func goBackAction(sender: UIButton!) {
        //        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
}