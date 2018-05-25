//
//  JJSegmentView.swift
//  JJSegmentSwift
//
//  Created by 金剑 on 2018/5/25.
//  Copyright © 2018年 金剑. All rights reserved.
//

import UIKit

protocol JJSegmentViewDelegate : NSObjectProtocol {
    //  指明父控制器
    func segmentSuperViewController() -> (UIViewController)
    //  创建子控制器
    func segmentSubViewControllerWithIndex(_ segment:JJSegmentView, _ index:NSInteger) -> UIViewController
    //  点击标签栏标签时
    func segmentItemSelectWithIndex(_ segment:JJSegmentView, _ index: NSInteger)

}

class JJSegmentView: UIView {
    var delegate: JJSegmentViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,
                  delegate: JJSegmentViewDelegate,
                  tittleDatas: [String],
                  headHeight: CGFloat,
                  fontSize: CGFloat,
                  headBgNomalColor: UIColor,
                  headBgSelectColor: UIColor,
                  headTitleNomalColor: UIColor,
                  headTitleSelectColor: UIColor,
                  headLineNomalColor: UIColor,
                  headLineSelectColor: UIColor)
    {
        self.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
