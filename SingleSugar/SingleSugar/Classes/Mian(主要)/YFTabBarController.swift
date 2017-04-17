//
//  YFTabBarController.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/14.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVC(vc: YFMonosacchrideViewController(), title: "单糖", imageName: "TabBar_home_23x23_")
        addChildVC(vc: YFSingleProductViewController(), title: "单品", imageName: "TabBar_gift_23x23_")
        addChildVC(vc: YFClassificationViewController(), title: "分类", imageName: "TabBar_category_23x23_")
        addChildVC(vc: YFProfileViewController(), title: "我的", imageName: "TabBar_me_boy_23x23_")
    }
}



extension YFTabBarController {
    fileprivate func addChildVC(vc: UIViewController, title: String, imageName: String) {
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "selected")
        vc.tabBarItem.title = title
        vc.title = title
        addChildViewController(YFNavigationController(rootViewController: vc))
    }
}
