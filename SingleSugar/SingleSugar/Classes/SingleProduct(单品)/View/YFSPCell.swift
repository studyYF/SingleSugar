//
//  YFSPCell.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/25.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFSPCell: UITableViewCell {
    
    //MARK: 属性
    @IBOutlet weak var imageScroll: YFImageScroll!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descripLabel: UILabel!
    
    
    var item: YFSingleProductDetailItem? {
        didSet{
            imageScroll.items = item?.image_urls
            titleLabel.text = item?.name
            descripLabel.text = item?.describe
            priceLabel.text = "￥\((item?.price)!)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
    
}
