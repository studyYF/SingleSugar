//
//  YFSinglePDetailViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/25.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFSinglePDetailViewController: ViewController {

    //MARK: 定义属性
    
    var id: Int?
    
    var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: kNavigationH, width: kWidth, height: kHeight - kNavigationH))
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib.init(nibName: "YFSPCell", bundle: nil), forCellReuseIdentifier: "YFSPCell")
        tableView.register(UINib.init(nibName: "YFDetailCommentCell", bundle: nil), forCellReuseIdentifier: "YFDetailCommentCell")
        tableView.register(YFSPHeaderView.self, forHeaderFooterViewReuseIdentifier: "YFSPHeaderView")
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    var item: YFSingleProductDetailItem?
    
    var commentItems: [YFCommentItem]?
    
    //MARK: 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "商品详情"
        view.backgroundColor = UIColor.white
        automaticallyAdjustsScrollViewInsets = false
        loadData()
    }
}

//MARK: 网络加载
extension YFSinglePDetailViewController {
    fileprivate func loadData() {
        YFHTTPRequestTool.shareNetTool.singleProductDetail(id: id!) {[weak self] (item) in
            self?.item = item
            if self?.commentItems != nil {
                 self?.setUI()
            }
        }
        YFHTTPRequestTool.shareNetTool.loadComment(id: id!) { [weak self] (items) in
            self?.commentItems = items
            if self?.item != nil {
                self?.setUI()
            }
        }
    }
}

//MARK: 设置UI
extension YFSinglePDetailViewController {
    fileprivate func setUI() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
}


//MARK: 方法
extension YFSinglePDetailViewController {
    
}

//MARK: UITableView代理方法
extension YFSinglePDetailViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YFSPCell", for: indexPath) as! YFSPCell
            cell.item = item
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "YFDetailCommentCell", for: indexPath) as! YFDetailCommentCell
                cell.commentItems = commentItems
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 10
        } else {
            return 0.01
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        } else {
            return 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return UIView()
        } else {
            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "YFSPHeaderView") as! YFSPHeaderView
            view.delegate = self
            return view
        }
    }

}

extension YFSinglePDetailViewController: YFSPHeaderViewDelegate {
    func selectedButton(_ button: UIButton) {
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? YFDetailCommentCell
        cell?.scrollView.contentOffset = CGPoint(x: CGFloat(button.tag - 300) * kWidth, y: 0)
    }
}

