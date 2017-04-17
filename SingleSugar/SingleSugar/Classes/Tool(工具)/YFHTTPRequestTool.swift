//
//  YFHTTPRequestTool.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
// 网络请求工具

import Foundation
import Alamofire
import SwiftyJSON
import SVProgressHUD


class YFHTTPRequestTool {
    
    ///单例
    static let shareNetTool = YFHTTPRequestTool()
    
    /// 网络请求基本方法
    ///
    /// - Parameters:
    ///   - method: 请求方式
    ///   - url: 网址
    ///   - param: 参数
    ///   - finished: 成功返回
    func baseRequest(_ url: String, param: [String:Any], finished: @escaping(Any) -> ()) {
        Alamofire.request(url, parameters: param).responseJSON { (response) in
            //判断是否请求成功
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败")
                return
            }
            //请求成功后，如果有数据，将数据返回
            if let value = response.result.value {
                finished(value)
            }
        }
    }
    
    /// 获取单糖数据
    ///
    /// - Parameters:
    ///   - id: 标题栏id
    ///   - finished: 成功返回
    func momosacchrideData(id: Int, finished: @escaping (_ monoItems: [YFMonosacchrideItem]) -> ()) {
        let url = baseURL + "v1/channels/\(id)/items"
        let param = ["gender": 1,
                     "generation": 1,
                     "limit": 20,
                     "offset": 0]
        baseRequest(url, param: param) { (response) in
            //判断返回的数据是否正确
            let dict = JSON(response)
            let code = dict["code"].intValue
            let message = dict["message"].stringValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            let data = dict["data"].dictionary
            if let items = data?["items"]?.arrayObject {
                var monosacchrideItems = [YFMonosacchrideItem]()
                for item in items {
                    let monoItem = YFMonosacchrideItem(dict: item as! [String : AnyObject])
                    monosacchrideItems.append(monoItem)
                }
                finished(monosacchrideItems)
            }
        }
    }
    
    func monosacchrideTitleData(_ finished: @escaping() -> ()) {
        
    }
    
    
}


















