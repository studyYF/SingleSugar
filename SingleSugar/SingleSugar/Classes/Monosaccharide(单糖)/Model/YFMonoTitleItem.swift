//
//  YFMonoTitleItem.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/17.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFMonoTitleItem: NSObject {

    var editable: Bool?
    var id: Int?
    var name: String?

    init(dict: [String : Any]) {
        super.init()
        editable = dict["editable"] as? Bool
        id = dict["id"] as? Int
        name = dict["name"] as? String
    }
}
