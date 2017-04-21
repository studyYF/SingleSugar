//
//  YFNavigationController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFNavigationController: UINavigationController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationBar.isTranslucent = false 
    }
    
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            hidesBottomBarWhenPushed = true
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "checkUserType_backward_9x15_"), style: .plain, target: self, action: #selector(YFNavigationController.back))
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc private func back() {
        popViewController(animated: true)
    }
}


