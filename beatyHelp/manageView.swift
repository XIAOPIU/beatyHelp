//
//  manageView.swift
//  beatyHelp
//
//  Created by 李国锐 on 6/9/14.
//  Copyright (c) 2014 XIAOPIU. All rights reserved.
//

import Foundation
import UIKit

class ManageViewDraw{
    init(_controller: UIViewController){
        GetUIBaseView(_controller: _controller)
        GetFootBar(_controller: _controller, _index: 2)
    }
}