//
//  YFCategoryViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/18.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

let cellName = "YFMonoTableViewCell"

class YFCategoryViewController: ViewController {

    //MARK: 属性
    
    //分类的id
    var id: Int?
    ///数组
    var items = [YFMonosacchrideItem]()
    
    ///tableView
    var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight - kNavigationH))
        tableView.register(UINib.init(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
        tableView.rowHeight = 170
        tableView.separatorStyle = .none
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setUI()
        loadData()
    }
}

extension YFCategoryViewController {
    fileprivate func setUI() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}


//MARK: 加载数据
extension YFCategoryViewController {
    fileprivate func loadData() {
        YFHTTPRequestTool.shareNetTool.momosacchrideData(id: id!) { [weak self] (items) in
            self!.items = items
            self!.tableView.reloadData()
        }
    }
}

//MARK: tableView代理方法
extension YFCategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as! YFMonoTableViewCell
        cell.item = items[indexPath.row]
        return cell
    }
}
