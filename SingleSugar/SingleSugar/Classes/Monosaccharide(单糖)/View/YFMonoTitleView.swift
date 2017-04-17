//
//  YFMonoTitleView.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/17.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit


class YFMonoTitleView: UIView {
    
    //MARK: 定义属性
    
    //协议属性
    var delegate: YFMonoTitleViewDelegate?
    
    ///title数组
    fileprivate var titleItems: [String]
    
    //上次选中按钮
    fileprivate var lastSelectedButton: UIButton?
    
    //下划线View
    fileprivate var lineView: UIView = UIView()
    
    init(frame: CGRect, titleItems: [String]) {
        self.titleItems = titleItems
        super.init(frame: frame)
        configButton()
        configLineView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 移动当前选中按钮
    ///
    /// - Parameter index: 下标
    func moveSelectedTitle(_ index: Int) {
        selectedAction(subviews[index] as! UIButton)
    }
    
    
    

}

//MARK: 初始化UI
extension YFMonoTitleView {
    //初始化按钮
    func configButton() {
        //1.算出每个按钮宽度
        //2.初始化按钮
        //3.设置按钮属性
        let buttonW = yfWidth / kTitleCount
        var i = 0
        for title in titleItems {
            //只能显示6个按钮
            if i >= Int(kTitleCount - 1) {
                break
            }
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.frame = CGRect(x: buttonW * CGFloat(i), y: 0, width: buttonW, height: yfHeight)
            button.tag = 300 + i
            button.setTitleColor(UIColor(hue:0.00, saturation:0.00, brightness:0.37, alpha:1.00), for: .normal)
            button.setTitleColor(UIColor(red: 245/255.0, green: 80/255.0, blue: 83/255.0, alpha: 1), for: .selected)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            button.addTarget(self, action: #selector(YFMonoTitleView.selectedAction(_:)), for: .touchUpInside)
            addSubview(button)
            i += 1
        }
        
        //添加最后一个展开按钮
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow_index_down_8x4_"), for: .normal)
        button.frame = CGRect(x: (kTitleCount - 1) * buttonW, y: 0, width: buttonW, height: yfHeight)
        button.addTarget(self, action: #selector(YFMonoTitleView.arrowButtonAction(_:)), for: .touchUpInside)
        addSubview(button)
        
        //添加分割线
        let sepeaterView = UIView(frame: CGRect(x: 0, y: yfHeight - 0.3, width: yfWidth, height: 0.3))
        sepeaterView.backgroundColor = UIColor(hue:0.00, saturation:0.00, brightness:0.75, alpha:1.00)
        addSubview(sepeaterView)

        
    }
    //初始化下划线
    func configLineView() {
        lineView.frame = CGRect(x: 0, y: yfHeight - 2, width: 0, height: 2)
        lineView.backgroundColor = UIColor(red: 245/255.0, green: 80/255.0, blue: 83/255.0, alpha: 1)
        addSubview(lineView)
        let button = subviews[0] as! UIButton
        button.isSelected = true
        lastSelectedButton = button
        button.titleLabel?.sizeToFit()
        lineView.frame.size.width = (button.titleLabel?.yfWidth)! + 5
        lineView.center.x = button.yfCenterX
    }
}

//MARK: 方法
extension YFMonoTitleView {
    @objc fileprivate func selectedAction(_ button: UIButton) {
        lastSelectedButton?.isSelected = false
        button.isSelected = !button.isSelected
        lastSelectedButton = button
        UIView.animate(withDuration: 0.3) {
            self.lineView.frame.size.width = (button.titleLabel?.yfWidth)! + 5
            self.lineView.center.x = button.yfCenterX
        }
        //回调给控制器
        delegate?.selectedTitle(button.tag - 300)
    }
    
    @objc fileprivate func arrowButtonAction(_ button: UIButton) {
        UIView.animate(withDuration: 0.2) { 
            button.imageView?.transform = (button.imageView?.transform.rotated(by: CGFloat.pi))!
        }
    }
}


//MARK: 选中title的代理
protocol YFMonoTitleViewDelegate {
    //选中的index
    func selectedTitle(_ index: Int)
}
