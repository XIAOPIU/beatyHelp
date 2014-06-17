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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailViewDraw(_controller: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // 使顶部状态bar变为白色
    override func preferredStatusBarStyle()->UIStatusBarStyle{
        return UIStatusBarStyle.LightContent
    }
    
    func goBackAction(sender: UIButton!) {
//        self.navigationController.popViewControllerAnimated(true)
        self.dismissModalViewControllerAnimated(true)
    }
    
    
    
}