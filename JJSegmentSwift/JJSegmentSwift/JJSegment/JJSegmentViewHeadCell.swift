//
//  JJSegmentViewHeadCell.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit

class JJSegmentViewHeadCell: UICollectionViewCell {
    //  标签标题
    var titleLabel: UILabel?
    //  标签字体大小
    var fontSize: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = UILabel()
        self.titleLabel?.textAlignment = .center
        contentView.addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: fontSize ?? 17.0)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalTo(contentView)
            make.top.bottom.equalTo(contentView)
        })
    }
    
    
}
