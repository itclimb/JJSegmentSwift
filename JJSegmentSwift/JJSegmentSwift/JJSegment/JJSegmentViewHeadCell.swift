//
//  JJSegmentViewHeadCell.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit

class JJSegmentViewHeadCell: UICollectionViewCell {
    //  标题
    var titleLabel: UILabel?
    //  底部线条
    var line: UIView?
    //  字体大小
    var fontSize: CGFloat?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.titleLabel = UILabel()
        self.titleLabel?.textAlignment = .center
        contentView.addSubview(titleLabel!)
        
        self.line = UIView()
        contentView.addSubview(line!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let fontSize:CGFloat = 17
        self.titleLabel?.font = UIFont(name: "HelveticaNeue", size: fontSize)
        self.titleLabel?.snp.makeConstraints({ (make) in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
        })
        
        self.line?.snp.makeConstraints({ (make) in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(2)
        })
        
    }
    
    
}
