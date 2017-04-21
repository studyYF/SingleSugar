//
//  YFMonoTableViewCell.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/17.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit
import Kingfisher

class YFMonoTableViewCell: UITableViewCell {

    //MARK: 属性
    ///图片
    @IBOutlet weak var contentImageView: UIImageView!
    ///标题label
    @IBOutlet weak var titleLabel: UILabel!
    ///按钮背景
    @IBOutlet weak var backView: UIView!
    ///收藏个数按钮
    @IBOutlet weak var faviButton: UIButton!
    
    ///模型
    var item: YFMonosacchrideItem? {
        didSet {
            contentImageView.kf.setImage(with: URL(string:(item?.cover_image_url)!), placeholder:UIImage(named: "PlaceHolderImage_small_31x26_"))
            titleLabel.text = item?.title
            faviButton.setTitle("\((item?.likes_count!)!)", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //设置控件属性
        backView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        faviButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -5)
        faviButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0)
        backView.layer.cornerRadius = backView.yfHeight * 0.5
        selectionStyle = .none
    }
    
    
}
