//
//  ManageController.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class ManageController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        ManageViewDraw(_controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func footBtn1Action(sender: UIButton!) {
        var ViewCon = ViewController()
        self.presentModalViewController(ViewCon, animated:false)
    }
    
    func footBtn3Action(sender: UIButton!) {
        var myDataCon = MyDataController()
        self.presentModalViewController(myDataCon, animated:false)
    }
    
}