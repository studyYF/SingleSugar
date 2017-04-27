//
//  YFDetailCommentCell.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/26.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit
import SnapKit

class YFDetailCommentCell: UITableViewCell {

    //MARK: 属性
    
    ///评论数组
    var commentItems: [YFCommentItem]?
    
    ///图文详情
    var detail: String?
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kWidth, height:kHeight - 40 - kNavigationH))
        scrollView.isScrollEnabled = false
        return scrollView
    }()
    
    lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: kWidth, height:kHeight - 40 - kNavigationH))
        scrollView.backgroundColor = UIColor.green
        return scrollView
    }()
    
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: kWidth, y: 40, width: kWidth, height: kHeight - kNavigationH - 40))
        tableView.backgroundColor = UIColor.white
        tableView.register(UINib.init(nibName: "YFCommentCell", bundle: nil), forCellReuseIdentifier: "YFCommentCell")
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        setUI()
    }
}

extension YFDetailCommentCell {
    fileprivate func setUI() {
        contentView.addSubview(scrollView)

        tableView.delegate = self
        tableView.dataSource = self
        scrollView.addSubview(tableView)
        scrollView.addSubview(contentScrollView)
        
        scrollView.contentSize = CGSize(width: kWidth * 2, height: tableView.contentSize.height)
        
        tableView.snp.makeConstraints { (make) in
            make.height.equalTo(kHeight - 40 - kNavigationH)
            make.edges.equalTo(contentView).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
    }
}
//MARK: tableView 代理方法
extension YFDetailCommentCell: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (commentItems?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YFCommentCell", for: indexPath) as! YFCommentCell
        cell.item = commentItems?[indexPath.row]
        return cell
    }
    
}
