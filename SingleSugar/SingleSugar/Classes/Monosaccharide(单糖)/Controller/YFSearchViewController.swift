//
//  YFSearchViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/19.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFSearchViewController: ViewController {

    //MARK: 定义属性
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "搜索商品、专题"
        searchBar.layer.cornerRadius = 5
        searchBar.tintColor = UIColor.blue
        searchBar.backgroundColor = UIColor.white
        return searchBar
    }()
    
    //MARK: 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchBar.resignFirstResponder()
    }
}

extension YFSearchViewController {
    fileprivate func setUI() {
        //1.隐藏左侧返回,添加取消按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(YFSearchViewController.cancle))
        //2.设置导航栏搜索
        navigationItem.titleView = searchBar
    }
}

//MARK: 方法
extension YFSearchViewController {
    @objc fileprivate func cancle() {
        navigationController?.popViewController(animated: true)
    }
}
