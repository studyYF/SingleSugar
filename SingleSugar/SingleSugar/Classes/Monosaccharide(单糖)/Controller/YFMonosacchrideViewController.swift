//
//  YFMonosacchrideViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFMonosacchrideViewController: ViewController {

    //MARK: 定义属性
    //titleView
    fileprivate var titleView: YFMonoTitleView?
    //标题数组
    fileprivate var titleItems: [YFMonoTitleItem]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        loadData()
    }
}

//MARK: 设置UI
extension YFMonosacchrideViewController {
    //设置标题view
    func setTitleView() {
        var titles = [String]()
        for item in titleItems! {
            titles.append(item.name!)
        }
        titles.append("你好")
        titleView = YFMonoTitleView(frame: CGRect(x: 0, y: kNavigationH, width: kWidth, height: 35), titleItems: titles)
        titleView?.delegate = self
        view.addSubview(titleView!)
    }
}

//MARK: 获取网络数据
extension YFMonosacchrideViewController {
    func loadData() {
        //获取标题数据
        YFHTTPRequestTool.shareNetTool.monosacchrideTitleData { (items) in
            self.titleItems = items
            self.setTitleView()
        }
    }
}



//MARK: titleView代理方法
extension YFMonosacchrideViewController: YFMonoTitleViewDelegate {
    func selectedTitle(_ index: Int) {
        
    }
}



