//
//  YFMonoDetailViewController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/20.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit
import SVProgressHUD

let toolBarH: CGFloat = 44

class YFMonoDetailViewController: ViewController {

    //MARK: 定义属性
    
    
    ///webView
    lazy var webView: UIWebView = {
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: kWidth, height: kHeight - toolBarH))
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        return webView
    }()
    
    ///item
    var item: YFMonosacchrideItem? {
        didSet {
            let url = URL(string: (item?.content_url)!)
            let request = URLRequest(url: url!)
            webView.loadRequest(request)
            let imageArray = ["content-details_like_16x16_","content-details_share_16x16_","content-details_share_16x16_"]
            let titleArray = ["1244","24","9"]
            let buttonW = kWidth / 3.0
            var i: CGFloat = 0
            for imageName in imageArray {
                let button = YFToolButton(frame: CGRect(x: i * buttonW, y: 0, width: buttonW, height: toolBarH), imageName: imageName)
                button.setTitle(titleArray[Int(i)], for: .normal)
                toolBar.addSubview(button)
                i += 1
            }

        }
    }
    
    //toolBar
    let toolBar = UIToolbar(frame: CGRect(x: 0, y: kHeight - toolBarH, width: kWidth, height: toolBarH))

    
    //MARK: 生命周期函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
}


//MARK: 设置UI
extension YFMonoDetailViewController {
    fileprivate func setUI() {
        title = "攻略详情"
        view.backgroundColor = UIColor.white
        //webView
        webView.delegate = self
        view.addSubview(webView)
        
        //底部工具栏
        view.addSubview(toolBar)
    }
}


//MARK: UIWebView代理方法
extension YFMonoDetailViewController: UIWebViewDelegate {
    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show(withStatus:"加载中...")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        SVProgressHUD.showError(withStatus: "加载失败!")
    }
}

