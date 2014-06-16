//
//  DetailsController.swift
//  beatyHelp
//
//  Created by 李国锐,张杨雪 on 6/11/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class DetailsController: UIViewController {
    var rowIndex: Int = 0
    var id: Int = 0
    var data: NSDictionary?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData(id)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func loadData(id:Int){
        var url = "http://mm.renren.com/task-get?id=" + String(id)
        BHHttpRequest.requestWithURL(url,completionHandler:{ data in
            self.data = data["data"] as NSDictionary!
            DetailViewDraw(_controller: self)
        })
    }
    
    func otherImage(sender: UIButton!){
//        println(123)
        // 跳转到详情内页
        var otherCon = OtherController()
        otherCon.uid = (self.data!.objectForKey("uid") as String).toInt()!
        self.presentModalViewController(otherCon, animated:true)
    }
    
    func goBackAction(sender: UIButton!) {
//        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
}