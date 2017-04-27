//
//  YFSingleProductCell.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/24.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFSingleProductCell: UICollectionViewCell {

    //MARK: 属性
    
    ///图片
    @IBOutlet weak var contentImageView: UIImageView!
    ///标题
    @IBOutlet weak var titleLabel: UILabel!
    ///价格
    @IBOutlet weak var priceLabel: UILabel!
    ///喜欢次数
    @IBOutlet weak var likeCountButton: UIButton!
    
    var item: YFSinglePItem? {
        didSet {
            contentImageView.kf.setImage(with: URL(string: (item?.cover_image_url)!), placeholder: UIImage(named: "PlaceHolderImage_small_31x26"))
            titleLabel.text = item?.name
            priceLabel.text = "￥ \((item?.price)!)"
            likeCountButton.setTitle("\((item?.favorites_count)!)", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.white
        likeCountButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        self.layer.cornerRadius = 5
    }

}
