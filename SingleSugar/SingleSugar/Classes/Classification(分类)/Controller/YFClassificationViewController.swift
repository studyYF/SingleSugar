//
//  YFClassificationViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFClassificationViewController: ViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadData()
    }
    
}

extension YFClassificationViewController {
    fileprivate func loadData() {
        YFHTTPRequestTool.shareNetTool.classifyData(6) { (items) in
            
        }
    }
}
