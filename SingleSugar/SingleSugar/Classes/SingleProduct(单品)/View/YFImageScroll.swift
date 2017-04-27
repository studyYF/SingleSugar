//
//  YFImageScroll.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/25.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit
import Kingfisher

class YFImageScroll: UIView {
    
    //MARK: 定义属性
    
    ///图片地址数组
    var items : [String]? {
        didSet{
            setUI()
        }
    }
    
    ///scrollView
    var scrollView = UIScrollView()
    
    ///pageControl
    var pageControl = UIPageControl()
    
    init(frame: CGRect, itemArray: [String]) {
        super.init(frame: frame)
        items = itemArray
        setUI()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        
    }
}

extension YFImageScroll {
    fileprivate func setUI() {
        //1.初始化scorllView
        scrollView.frame = bounds
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.white
        addSubview(scrollView)
        //2.循环创建imageView
        var i: CGFloat = 0
        for imageString in items! {
            let imageView = UIImageView(frame: CGRect(x: i * kWidth, y: 0, width: kWidth, height: yfHeight))
            imageView.kf.setImage(with: URL(string: imageString), placeholder: UIImage(named:"PlaceHolderImage_small_31x26_"))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            scrollView.addSubview(imageView)
            i += 1
        }
        //3.创建pageControl
        pageControl.frame = CGRect(x: 0, y: yfHeight - 20, width: kWidth, height: 10)
        pageControl.yfCenterX = kWidth * 0.5
        pageControl.numberOfPages = (items?.count)!
        addSubview(pageControl)
        
        //4.设置scrollView 的contentSize
        scrollView.contentSize = CGSize(width: CGFloat((items?.count)!) * kWidth, height: 0)
        
        //5.创建蒙版
        let view = UIView(frame: CGRect(x: 0, y: 320, width: kWidth, height: 50))
        view.backgroundColor = UIColor.black
        view.alpha = 0.1
//        addSubview(view)
    }
}

extension YFImageScroll: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / kWidth
        pageControl.currentPage = Int(index)
    }
}
