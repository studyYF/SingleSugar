//
//  YFMonosacchrideViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFMonosacchrideViewController: ViewController {

    lazy var titleView: YFMonoTitleView = YFMonoTitleView(frame: CGRect(x: 0, y: kNavigationH, width: kWidth, height: 40), titleItems: ["精选","没事","家具","数码","没雾"])
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(titleView)
        YFHTTPRequestTool.shareNetTool.momosacchrideData(id: 4) { (items) in
            print(items)
        }
        
    }
}



