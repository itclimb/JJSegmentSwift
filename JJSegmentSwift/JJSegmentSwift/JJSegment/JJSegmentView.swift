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
    var titleDatas: Array<Any>?
//    {
//        didSet{
//            if (self.titleDatas?.count)! <= 0 { return }
//            for vc in (self.delegate?.segmentSuperViewController().childViewControllers)! {
//                vc.removeFromParentViewController()
//            }
//            for subView in self.subviews {
//                subView.removeFromSuperview()
//            }
//
//            self.createSubViews()
//        }
//    }
    var headHeight: CGFloat?
    var fontSize: CGFloat?
    var headBgNomalColor: UIColor?
    var headBgSelectColor: UIColor?
    var headTitleNomalColor: UIColor?
    var headTitleSelectColor: UIColor?
    var headLineNomalColor: UIColor?
    var headLineSelectColor: UIColor?
    var segmentHead:JJSegmentViewHead?
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(frame: CGRect,
                  delegate: JJSegmentViewDelegate,
                  titleDatas: Array<Any>,
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
        self.delegate = delegate
        self.headHeight = headHeight
        self.fontSize = fontSize
        self.headBgNomalColor = headBgNomalColor
        self.headBgSelectColor = headBgSelectColor
        self.headTitleNomalColor = headTitleNomalColor
        self.headTitleSelectColor = headTitleSelectColor
        self.headLineNomalColor = headLineNomalColor
        self.headLineSelectColor = headLineSelectColor
        self.titleDatas = titleDatas
        
        self.createSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubViews() {
        if (self.titleDatas?.count)! <= 0 { return }
        for vc in (self.delegate?.segmentSuperViewController().childViewControllers)! {
            vc .removeFromParentViewController()
        }
        for subView in self.subviews {
            subView .removeFromSuperview()
        }
        
        let segmentHead_frame = CGRect(x: 0, y: 64, width: self.bounds.width, height: 40)
        segmentHead = JJSegmentViewHead(frame: segmentHead_frame)
        segmentHead?.backgroundColor = .red
        self.addSubview(segmentHead!)
        
        let scrollView_frame = CGRect(x: 0, y: segmentHead_frame.size.height + segmentHead_frame.origin.y, width: self.bounds.width, height: self.bounds.height - segmentHead_frame.size.height)
        let scrollView = UIScrollView(frame: scrollView_frame)
        scrollView.backgroundColor = .blue
        self.addSubview(scrollView)
        
        for i in 0..<(self.titleDatas?.count)! {
            let baseVc = self.delegate?.segmentSubViewControllerWithIndex(self, i)
            self.delegate?.segmentSuperViewController().addChildViewController(baseVc!)
            scrollView.addSubview((baseVc?.view)!)
            
        }
        
    }
}
