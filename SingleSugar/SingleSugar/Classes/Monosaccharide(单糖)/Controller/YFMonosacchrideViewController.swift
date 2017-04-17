//
//  YFMonosacchrideViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFMonosacchrideViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        YFHTTPRequestTool.shareNetTool.momosacchrideData(id: 4) { (items) in
            print(items)
        }
    }
}
