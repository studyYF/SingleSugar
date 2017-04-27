//
//  YFCommentCell.swift
//  SingleSugar
//
//  Created by YangFan on 2017/4/26.
//  Copyright © 2017年 YangFan. All rights reserved.
//

import UIKit

class YFCommentCell: UITableViewCell {

    
    //MARK: 属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    var item: YFCommentItem? {
        didSet {
            iconImageView.kf.setImage(with: URL(string: (item?.user?.avatar_url)!), placeholder: UIImage(named: "PostComment_AvatarPlaceholder_40x40_"))
            nickNameLabel.text = item?.user?.nickname
            commentLabel.text = item?.content
            
//            timeLabel.text = item?.created_at
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    
}
