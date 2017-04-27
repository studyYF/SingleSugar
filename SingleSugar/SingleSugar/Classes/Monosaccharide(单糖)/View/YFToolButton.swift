//
//  YFToolButton.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/24.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFToolButton: UIButton {
    
    init(frame: CGRect, imageName: String) {
        super.init(frame: frame)
        self.setImage(UIImage(named: imageName), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        self.setTitleColor(UIColor.lightGray, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
    }
}
