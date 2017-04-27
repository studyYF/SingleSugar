//
//  YFSPHeaderView.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/25.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

protocol YFSPHeaderViewDelegate {
    func selectedButton(_ button: UIButton)
}

class YFSPHeaderView: UITableViewHeaderFooterView {
    
    //MARK: 属性
    /// 详情
    var detailButton: UIButton?
    ///评论
    var commentButton: UIButton?
    ///下划线
    var lineView: UIView?
    
    var delegate: YFSPHeaderViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.white
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        detailButton = creatButton(CGRect(x: 0, y: 0, width: kWidth * 0.5, height: 40), title: "图文介绍", tag: 300)
        addSubview(detailButton!)
        
        commentButton = creatButton(CGRect(x: kWidth * 0.5, y: 0, width: kWidth * 0.5, height: 40), title: "评论", tag: 301)
        addSubview(commentButton!)
        
        
        lineView = UIView(frame: CGRect(x: 0, y: 38, width: kWidth * 0.5, height: 2))
        lineView?.backgroundColor = kMainColor
        addSubview(lineView!)
        
        createSepeaterLine(frame: CGRect(x: 0, y: 0, width: kWidth, height: 0.5))
        createSepeaterLine(frame: CGRect(x: 0, y: 39.5, width: kWidth, height: 0.5))
        createSepeaterLine(frame: CGRect(x: kWidth * 0.5, y: 0, width: 0.5, height: 40))
    }
}

extension YFSPHeaderView {
    
    /// 创建按钮
    ///
    /// - Parameters:
    ///   - frame: 位置
    ///   - title: 标题
    /// - Returns: button
    fileprivate func creatButton(_ frame: CGRect, title: String, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = frame
        button.tag = tag
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: #selector(YFSPHeaderView.selectorType(button:)), for: .touchUpInside)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }
    
    fileprivate func createSepeaterLine(frame: CGRect) {
        let view = UIView(frame: frame)
        view.backgroundColor = UIColor.lightGray
        addSubview(view)
    }
}

extension YFSPHeaderView {
    @objc fileprivate func selectorType(button: UIButton) {
        delegate?.selectedButton(button)
        UIView.animate(withDuration: 0.2) { 
            self.lineView?.frame = CGRect(x: kWidth * 0.5 * CGFloat(button.tag - 300), y: (self.lineView?.yfY)!, width: self.lineView!.yfWidth, height: (self.lineView?.yfHeight)!)
        }
    }
}
