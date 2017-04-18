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
    
    //滑动scrollView
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: kNavigationH + kTitleViewH, width: kWidth, height: kHeight - kNavigationH - kTitleViewH))
        scrollView.bounces = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.white
        return scrollView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        //关闭自动调整控件位置
        automaticallyAdjustsScrollViewInsets = false
        setUI()
        loadData()
    }
}

//MARK: 设置UI
extension YFMonosacchrideViewController {
    
    ///设置ui
    fileprivate func setUI() {
        //1.设置scrollView
        scrollView.delegate = self
        view.addSubview(scrollView)
        //2.设置搜索框
        
    }
    
    //设置标题view
    fileprivate func setTitleView() {
        var titles = [String]()
        for item in titleItems! {
            titles.append(item.name!)
        }
        titleView = YFMonoTitleView(frame: CGRect(x: 0, y: kNavigationH, width: kWidth, height: kTitleViewH), titleItems: titles)
        titleView?.delegate = self
        view.addSubview(titleView!)
    }
    
    fileprivate func setController() {
        //设置控制器
        var vcArray = [UIViewController]()
        for item in titleItems! {
            let vc = YFCategoryViewController()
            vc.id = item.id
            vcArray.append(vc)
            addChildViewController(vc)
        }
        //添加到scrollView上
        var i: CGFloat = 0
        for vc in vcArray {
            vc.view.frame = CGRect(x: i * kWidth, y: 0, width: kWidth, height: scrollView.yfHeight)
            scrollView.addSubview(vc.view)
            print(i,vc.view.frame)
            i += 1
        }
        //设置scrollView的contentOffset
        scrollView.contentSize = CGSize(width: kWidth * CGFloat(vcArray.count), height: 0)
    }
}

//MARK: 获取网络数据
extension YFMonosacchrideViewController {
    func loadData() {
        //获取标题数据
        YFHTTPRequestTool.shareNetTool.monosacchrideTitleData { (items) in
            self.titleItems = items
            self.setTitleView()
            self.setController()
        }
    }
}

//MARK: scrollView代理方法
extension YFMonosacchrideViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / kWidth;
        self.titleView?.moveSelectedTitle(Int(index))
    }
}


//MARK: titleView代理方法
extension YFMonosacchrideViewController: YFMonoTitleViewDelegate {
    func selectedTitle(_ index: Int) {
        scrollView.setContentOffset(CGPoint(x: CGFloat(index) * kWidth, y: 0), animated: false)
    }
}



