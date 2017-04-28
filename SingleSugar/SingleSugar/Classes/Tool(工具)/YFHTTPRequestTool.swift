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
    func baseRequest(_ url: String, param: [String:Any]? = nil, finished: @escaping(Any) -> ()) {
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
    
    
    /// 获取单糖标题数据
    ///
    /// - Parameter finished: 完成回调
    func monosacchrideTitleData(_ finished: @escaping(_ titleItems: [YFMonoTitleItem]) -> ()) {
        let url = baseURL + "v2/channels/preset"
        let param = ["gender": 1,
                     "generation": 1]
        baseRequest(url, param: param) { (response) in
            let dict = JSON(response)
            let code = dict["code"].intValue
            let message = dict["message"].stringValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            let data = dict["data"].dictionary
            if let titles = data?["channels"]?.arrayObject {
                var titleItems = [YFMonoTitleItem]()
                for item in titles {
                    titleItems.append(YFMonoTitleItem(dict: item as! [String : Any]))
                }
                finished(titleItems)
            }
        }
    }
    
    /// 请求单品数据
    ///
    /// - Parameter finished: 数据回调
    func singleProductItem(finished: @escaping([YFSinglePItem]) -> ()) {
        let url = baseURL + "v2/items"
        let param = ["gender" : 1,
            "generation" : 1,
            "limit" : 20,
            "offset" : 0
        ]
        baseRequest(url, param: param) { (response) in
            let dict = JSON(response)
            let code = dict["code"].intValue
            let message = dict["message"].stringValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            let data = dict["data"].dictionary
            if let items = data?["items"]?.arrayObject {
                var products = [YFSinglePItem]()
                for item in items {
                    let itemDict = item as! [String : Any]
                    if let itemData = itemDict["data"] {
                        products.append(YFSinglePItem(dict: itemData as! [String : Any]))
                    }
                }
                finished(products)
            }
        }
    }
    
    /// 获取单品详情数据
    ///
    /// - Parameters:
    ///   - id: 商品id
    ///   - finished: 返回数组
    func singleProductDetail(id: Int, finished: @escaping(YFSingleProductDetailItem) -> ()) {
        let url = baseURL + "v2/items/\(id)"
        baseRequest(url) { (response) in
            let data = JSON(response)
            let message = data["message"].stringValue
            let code = data["code"].intValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            if let items = data["data"].dictionaryObject {
                let item = YFSingleProductDetailItem(dict: items as [String : AnyObject])
                finished(item)
            }
        }
    }
    
    /// 请求评论数据
    ///
    /// - Parameters:
    ///   - id: 商品id
    ///   - finished:
    func loadComment(id: Int, finished: @escaping([YFCommentItem]) -> ()) {
        let url = baseURL + "v2/items/\(id)/comments"
        let params = ["limit": 20,
                      "offset": 0]
        baseRequest(url, param: params) { (response) in
            let dict = JSON(response)
            let message = dict["message"].stringValue
            let code = dict["code"].intValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            if let data = dict["data"].dictionary {
                if let commentData = data["comments"]?.arrayObject {
                    var commentItems = [YFCommentItem]()
                    for item in commentData {
                        commentItems.append(YFCommentItem(dict: item as! [String : AnyObject]))
                    }
                    finished(commentItems)
                }
            }
        }
    }
    
    func classifyData(_ limit: Int, finished: @escaping([YFClassifyItem]) -> ()) {
        let url = baseURL + "v1/collections"
        let params = ["limit": limit,
                      "offset": 0]
        baseRequest(url, param: params) { (response) in
            let dict = JSON(response)
            let message = dict["message"].stringValue
            let code = dict["code"].intValue
            guard code == kSuccessCode else {
                SVProgressHUD.showInfo(withStatus: message)
                return
            }
            
        }
    }
}


















